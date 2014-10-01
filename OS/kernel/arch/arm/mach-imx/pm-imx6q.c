/*
 * Copyright 2011 Freescale Semiconductor, Inc.
 * Copyright 2011 Linaro Ltd.
 *
 * The code contained herein is licensed under the GNU General Public
 * License. You may obtain a copy of the GNU General Public License
 * Version 2 or later at the following locations:
 *
 * http://www.opensource.org/licenses/gpl-license.html
 * http://www.gnu.org/copyleft/gpl.html
 */

#include <linux/init.h>
#include <linux/io.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/suspend.h>
#include <asm/mach/map.h>
#include <asm/cacheflush.h>
#include <asm/proc-fns.h>
#include <asm/suspend.h>
#include <asm/hardware/cache-l2x0.h>
#include <mach/iram.h>
#include <mach/common.h>
#include <mach/hardware.h>

struct imx_iram_pm {
	void *iram_cpaddr;
	unsigned long suspend_iram_paddr;
	unsigned long suspend_iram_size;
	void *suspend_iram_vaddr;
	void *reg_ptr[4];
} imx6q_iram_pm;

extern unsigned long phys_l2x0_saved_regs;
extern void imx6q_suspend(void);
static void (*suspend_in_iram)(unsigned long iram_paddr,
				unsigned long iram_vaddr,
				unsigned long iram_size);

static int imx6q_suspend_finish(unsigned long val)
{
	if ((val == PM_SUSPEND_MEM) && suspend_in_iram) {
		suspend_in_iram((unsigned long)imx6q_iram_pm.suspend_iram_paddr,
				(unsigned long)imx6q_iram_pm.suspend_iram_vaddr,
				(unsigned long)imx6q_iram_pm.suspend_iram_size);
	} else
		cpu_do_idle();

	return 0;
}

static void imx6q_prepare_suspend_iram(void)
{
	unsigned long *iram_stack = imx6q_iram_pm.suspend_iram_vaddr
					+ imx6q_iram_pm.suspend_iram_size;

	*(--iram_stack) = (unsigned long)imx6q_iram_pm.reg_ptr[3];
	*(--iram_stack) = (unsigned long)imx6q_iram_pm.reg_ptr[2];
	*(--iram_stack) = (unsigned long)imx6q_iram_pm.reg_ptr[1];
	*(--iram_stack) = (unsigned long)imx6q_iram_pm.reg_ptr[0];
}

static int imx6q_pm_enter(suspend_state_t state)
{
	switch (state) {
	case PM_SUSPEND_STANDBY:
	case PM_SUSPEND_MEM:
		if (imx_gpc_wake_irq_pending())
			return 0;

		if (state == PM_SUSPEND_STANDBY)
			imx6q_set_lpm(STOP_POWER_OFF);
		else
			imx6q_set_lpm(ARM_POWER_OFF);

		imx_gpc_pre_suspend();
		imx_set_cpu_jump(0, v7_cpu_resume);
		if (state == PM_SUSPEND_MEM)
			imx6q_prepare_suspend_iram();
		/* Zzz ... */
		cpu_suspend(state, imx6q_suspend_finish);
		imx_smp_prepare();
		imx_gpc_post_resume();
		break;
	default:
		return -EINVAL;
	}

	return 0;
}

static int imx6q_pm_valid(suspend_state_t state)
{
	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
}

static const struct platform_suspend_ops imx6q_pm_ops = {
	.enter = imx6q_pm_enter,
	.valid = imx6q_pm_valid,
};

static int __init imx6q_pm_iram_of_init(void)
{
	struct device_node *np;

	/*
	 * these register may already ioremaped, need figure out
	 * one way to save vmalloc space.
	 */
	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
	imx6q_iram_pm.reg_ptr[0] = of_iomap(np, 0);
	if (!imx6q_iram_pm.reg_ptr[0])
		goto err0;

	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-iomuxc");
	imx6q_iram_pm.reg_ptr[1] = of_iomap(np, 0);
	if (!imx6q_iram_pm.reg_ptr[1])
		goto err1;

	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-mmdc");
	imx6q_iram_pm.reg_ptr[2] = of_iomap(np, 0);
	if (!imx6q_iram_pm.reg_ptr[2])
		goto err2;

	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
	imx6q_iram_pm.reg_ptr[3] = of_iomap(np, 0);
	if (!imx6q_iram_pm.reg_ptr[3])
		goto err3;

	return 0;
err3:
	iounmap(imx6q_iram_pm.reg_ptr[2]);
err2:
	iounmap(imx6q_iram_pm.reg_ptr[1]);
err1:
	iounmap(imx6q_iram_pm.reg_ptr[0]);
err0:
	return -EINVAL;
}

void __init imx6q_pm_init(void)
{
	/*
	 * The l2x0 core code provides an infrastucture to save and restore
	 * l2x0 registers across suspend/resume cycle.  But because imx6q
	 * retains L2 content during suspend and needs to resume L2 before
	 * MMU is enabled, it can only utilize register saving support and
	 * have to take care of restoring on its own.  So we save physical
	 * address of the data structure used by l2x0 core to save registers,
	 * and later restore the necessary ones in imx6q resume entry.
	 */
	phys_l2x0_saved_regs = __pa(&l2x0_saved_regs);

	suspend_set_ops(&imx6q_pm_ops);

	/* Move suspend routine into iRAM */
	imx6q_iram_pm.suspend_iram_size = SZ_4K;
	imx6q_iram_pm.iram_cpaddr = iram_alloc(imx6q_iram_pm.suspend_iram_size,
			&imx6q_iram_pm.suspend_iram_paddr);
	if (imx6q_iram_pm.iram_cpaddr) {
		if (imx6q_pm_iram_of_init() < 0) {
			iram_free(imx6q_iram_pm.suspend_iram_paddr,
					imx6q_iram_pm.suspend_iram_size);
			return;
		}
		/*
		 * Need to remap the area here since we want the memory region
		 * to be noncached & executable.
		 */
		imx6q_iram_pm.suspend_iram_vaddr =
			__arm_ioremap(imx6q_iram_pm.suspend_iram_paddr,
					imx6q_iram_pm.suspend_iram_size,
					MT_MEMORY_NONCACHED);
		pr_info("cpaddr = %p suspend_iram_base=%p\n",
				imx6q_iram_pm.iram_cpaddr,
				imx6q_iram_pm.suspend_iram_vaddr);

		/*
		 * Need to run the suspend code from IRAM as the DDR needs
		 * to be put into low power mode manually.
		 */
		memcpy(imx6q_iram_pm.iram_cpaddr, imx6q_suspend,
					imx6q_iram_pm.suspend_iram_size);

		suspend_in_iram = (void *)imx6q_iram_pm.suspend_iram_vaddr;

	} else
		suspend_in_iram = NULL;
}
