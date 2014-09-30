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

#include <linux/linkage.h>
#include <mach/hardware.h>
#include <asm/hardware/cache-l2x0.h>

#define SRC_GPR1_OFFSET		0x020
#define SRC_GPR2_OFFSET		0x024
#define MMDC_MAPSR_OFFSET 	0x404
#define MMDC_MAPSR_PSS 		(1 << 4)
#define MMDC_MAPSR_PSD 		(1 << 0)
#define ANATOP_REG_2P5		0x130

.macro	ddr_io_save
	ldr	r4, [r9, #0x5ac] /* DRAM_DQM0 */
	ldr	r5, [r9, #0x5b4] /* DRAM_DQM1 */
	ldr	r6, [r9, #0x528] /* DRAM_DQM2 */
	ldr	r7, [r9, #0x520] /* DRAM_DQM3 */
	stmfd	sp!, {r4-r7}

	ldr	r4, [r9, #0x514] /* DRAM_DQM4 */
	ldr	r5, [r9, #0x510] /* DRAM_DQM5 */
	ldr	r6, [r9, #0x5bc] /* DRAM_DQM6 */
	ldr	r7, [r9, #0x5c4] /* DRAM_DQM7 */
	stmfd	sp!, {r4-r7}

	ldr	r4, [r9, #0x56c] /* DRAM_CAS */
	ldr	r5, [r9, #0x578] /* DRAM_RAS */
	ldr	r6, [r9, #0x588] /* DRAM_SDCLK_0 */
	ldr	r7, [r9, #0x594] /* DRAM_SDCLK_1 */
	stmfd	sp!, {r4-r7}

	ldr	r5, [r9, #0x750] /* DDRMODE_CTL */
	ldr	r6, [r9, #0x774] /* DDRMODE */
	stmfd	sp!, {r5-r6}

	ldr	r4, [r9, #0x5a8] /* DRAM_SDQS0 */
	ldr	r5, [r9, #0x5b0] /* DRAM_SDQS1 */
	ldr	r6, [r9, #0x524] /* DRAM_SDQS2 */
	ldr	r7, [r9, #0x51c] /* DRAM_SDQS3 */
	stmfd	sp!, {r4-r7}

	ldr	r4, [r9, #0x518] /* DRAM_SDQS4 */
	ldr	r5, [r9, #0x50c] /* DRAM_SDQS5 */
	ldr	r6, [r9, #0x5b8] /* DRAM_SDQS6 */
	ldr	r7, [r9, #0x5c0] /* DRAM_SDQS7 */
	stmfd	sp!, {r4-r7}

	ldr	r4, [r9, #0x784] /* GPR_B0DS */
	ldr	r5, [r9, #0x788] /* GPR_B1DS */
	ldr	r6, [r9, #0x794] /* GPR_B2DS */
	ldr	r7, [r9, #0x79c] /* GPR_B3DS */
	stmfd	sp!, {r4-r7}

	ldr	r4, [r9, #0x7a0] /* GPR_B4DS */
	ldr	r5, [r9, #0x7a4] /* GPR_B5DS */
	ldr	r6, [r9, #0x7a8] /* GPR_B6DS */
	ldr	r7, [r9, #0x748] /* GPR_B7DS */
	stmfd	sp!, {r4-r7}

	ldr	r5, [r9, #0x74c] /* GPR_ADDS*/
	ldr	r6, [r9, #0x59c] /* DRAM_SODT0*/
	ldr	r7, [r9, #0x5a0] /* DRAM_SODT1*/
	stmfd	sp!, {r5-r7}
.endm

.macro	ddr_io_restore
	ldmfd	sp!, {r5-r7}
	str	r5, [r9, #0x74c] /* GPR_ADDS*/
	str	r6, [r9, #0x59c] /* DRAM_SODT0*/
	str	r7, [r9, #0x5a0] /* DRAM_SODT1*/

	ldmfd	sp!, {r4-r7}
	str	r4, [r9, #0x7a0] /* GPR_B4DS */
	str	r5, [r9, #0x7a4] /* GPR_B5DS */
	str	r6, [r9, #0x7a8] /* GPR_B6DS */
	str	r7, [r9, #0x748] /* GPR_B7DS */

	ldmfd	sp!, {r4-r7}
	str	r4, [r9, #0x784] /* GPR_B0DS */
	str	r5, [r9, #0x788] /* GPR_B1DS */
	str	r6, [r9, #0x794] /* GPR_B2DS */
	str	r7, [r9, #0x79c] /* GPR_B3DS */

	ldmfd	sp!, {r4-r7}
	str	r4, [r9, #0x518] /* DRAM_SDQS4 */
	str	r5, [r9, #0x50c] /* DRAM_SDQS5 */
	str	r6, [r9, #0x5b8] /* DRAM_SDQS6 */
	str	r7, [r9, #0x5c0] /* DRAM_SDQS7 */

	ldmfd	sp!, {r4-r7}
	str	r4, [r9, #0x5a8] /* DRAM_SDQS0 */
	str	r5, [r9, #0x5b0] /* DRAM_SDQS1 */
	str	r6, [r9, #0x524] /* DRAM_SDQS2 */
	str	r7, [r9, #0x51c] /* DRAM_SDQS3 */

	ldmfd	sp!, {r5-r6}
	str	r5, [r9, #0x750] /* DDRMODE_CTL */
	str	r6, [r9, #0x774] /* DDRMODE */

	ldmfd	sp!, {r4-r7}
	str	r4, [r9, #0x56c] /* DRAM_CAS */
	str	r5, [r9, #0x578] /* DRAM_RAS */
	str	r6, [r9, #0x588] /* DRAM_SDCLK_0 */
	str	r7, [r9, #0x594] /* DRAM_SDCLK_1 */

	ldmfd	sp!, {r4-r7}
	str	r4, [r9, #0x514] /* DRAM_DQM4 */
	str	r5, [r9, #0x510] /* DRAM_DQM5 */
	str	r6, [r9, #0x5bc] /* DRAM_DQM6 */
	str	r7, [r9, #0x5c4] /* DRAM_DQM7 */

	ldmfd	sp!, {r4-r7}
	str	r4, [r9, #0x5ac] /* DRAM_DQM0 */
	str	r5, [r9, #0x5b4] /* DRAM_DQM1 */
	str	r6, [r9, #0x528] /* DRAM_DQM2 */
	str	r7, [r9, #0x520] /* DRAM_DQM3 */
.endm

.macro	ddr_io_set_lpm
	mov	r4, #0
	str	r4, [r9, #0x5ac] /* DRAM_DQM0 */
	str	r4, [r9, #0x5b4] /* DRAM_DQM1 */
	str	r4, [r9, #0x528] /* DRAM_DQM2 */
	str	r4, [r9, #0x520] /* DRAM_DQM3 */

	str	r4, [r9, #0x514] /* DRAM_DQM4 */
	str	r4, [r9, #0x510] /* DRAM_DQM5 */
	str	r4, [r9, #0x5bc] /* DRAM_DQM6 */
	str	r4, [r9, #0x5c4] /* DRAM_DQM7 */

	str	r4, [r9, #0x56c] /* DRAM_CAS */
	str	r4, [r9, #0x578] /* DRAM_RAS */
	str	r4, [r9, #0x588] /* DRAM_SDCLK_0 */
	str	r4, [r9, #0x594] /* DRAM_SDCLK_1 */

	str	r4, [r9, #0x750] /* DDRMODE_CTL */
	str	r4, [r9, #0x774] /* DDRMODE */

	str	r4, [r9, #0x5a8] /* DRAM_SDQS0 */
	str	r4, [r9, #0x5b0] /* DRAM_SDQS1 */
	str	r4, [r9, #0x524] /* DRAM_SDQS2 */
	str	r4, [r9, #0x51c] /* DRAM_SDQS3 */

	str	r4, [r9, #0x518] /* DRAM_SDQS4 */
	str	r4, [r9, #0x50c] /* DRAM_SDQS5 */
	str	r4, [r9, #0x5b8] /* DRAM_SDQS6 */
	str	r4, [r9, #0x5c0] /* DRAM_SDQS7 */

	str	r4, [r9, #0x784] /* GPR_B0DS */
	str	r4, [r9, #0x788] /* GPR_B1DS */
	str	r4, [r9, #0x794] /* GPR_B2DS */
	str	r4, [r9, #0x79c] /* GPR_B3DS */

	str	r4, [r9, #0x7a0] /* GPR_B4DS */
	str	r4, [r9, #0x7a4] /* GPR_B5DS */
	str	r4, [r9, #0x7a8] /* GPR_B6DS */
	str	r4, [r9, #0x748] /* GPR_B7DS */

	str	r4, [r9, #0x74c] /* GPR_ADDS*/
	str	r4, [r9, #0x59c] /* DRAM_SODT0*/
	str	r4, [r9, #0x5a0] /* DRAM_SODT1*/
.endm

/*
 * imx6q_suspend:
 *
 * Suspend the processor (eg, wait for interrupt).
 * Set the DDR into Self Refresh
 * IRQs are already disabled.
 *
 * Registers usage in the imx6q_suspend:
 *
 * r0: suspend_iram_paddr
 * r1: suspend_iram_vaddr
 * r2: suspend_iram_size
 *
 * r8: src_base pointer
 * r9: iomux_base pointer
 * r10: mmdc_base pointer
 * r11: anatop_base pointer
 * sp: iram stack
 *
 * Corrupted registers: r0-r3
 */

ENTRY(imx6q_suspend)
	mov	r3, sp				@ save sp
	add	sp, r1, r2			@ set sp to top iram stack
	sub	sp, sp, #16	 		@ 4 regs ptr
	stmfd	sp!, {r4 - r12, lr}		@ save registers

	add	r4, r1, r2
	ldr	r8, [r4, #-16]			@ r8 = src_base pointer
	ldr	r9, [r4, #-12]			@ r9 = iomux_base pointer
	ldr	r10, [r4, #-8]			@ r10 = mmdc_base pointer
	ldr	r11, [r4, #-4]			@ r11 = anatop_base pointer

	/* should not access sp in ddr until resume with cache MMU on */
	stmfd	sp!, {r3}			@ save old sp

	ldr	r4, [r8, #SRC_GPR1_OFFSET]	@ r8 = src_base pointer
	stmfd	sp!, {r4}			@ save old resume func

	/* Enable weak 2P5 linear regulator */
	ldr	r4, [r11, #ANATOP_REG_2P5]	@ r11 = anatop_base pointer
	orr	r4, r4, #0x40000
	str	r4, [r11, #ANATOP_REG_2P5]
	mov	r6, #1
wait:	ldr	r4, [r11, #ANATOP_REG_2P5]
	and	r4, r4, r6, lsl #17			@ output ok?
	cmp	r4, #0
	beq	wait

	/* save ddr iomux regs */
	ddr_io_save

	/* set ddr to low power mode */
	ldr	r4, [r10, #MMDC_MAPSR_OFFSET]	@ r10 = mmdc_base pointer
	bic	r4, #MMDC_MAPSR_PSD
	str	r4, [r10, #MMDC_MAPSR_OFFSET]
refresh:
	ldr	r4, [r10, #MMDC_MAPSR_OFFSET]
	and	r4, r4, #MMDC_MAPSR_PSS
	cmp	r4, #0
	beq	refresh

	ddr_io_set_lpm

	/* save resume pointer into SRC_GPR1, sp pointer into SRC_GPR2 */
	ldr	r4, =imx6q_suspend
	ldr	r5, =imx6q_resume
	sub	r5, r5, r4			@ r5 = resmue offset
	add	r5, r0, r5			@ r0 = suspend_iram_paddr, r5 = resmue phy addr
	str	r5, [r8, #SRC_GPR1_OFFSET]	@ r8 = src_base pointer
	sub	r5, sp, r1			@ r1 = suspend_iram_vaddr, r5 = sp offset
	add	r5, r0, r5			@ r0 = suspend_iram_paddr, r5 = sp phy addr
	str	r5, [r8, #SRC_GPR2_OFFSET]	@ r8 = src_base pointer

	/* execute a wfi instruction to let SOC go into stop mode */
	dsb
	wfi

	nop
	nop
	nop
	nop

	/*
	 * if go here, means there is a wakeup irq pending, we should resume
	 * system immediately.
	 */
	ddr_io_restore

	/* Disable weak 2P5 linear regulator */
	ldr	r4, [r11, #ANATOP_REG_2P5]	@ r11 = anatop_base pointer
	bic	r4, #0x40000
	str	r4, [r11, #ANATOP_REG_2P5]

	ldmfd	sp!, {r4}			@ drop old resmue func ptr
	ldmfd	sp!, {r3}
	ldmfd	sp!, {r4 - r12, lr}
	mov	sp, r3
	mov	pc, lr

/*
 * when SOC exit stop mode, arm core restart from here, currently
 * are running with MMU off.
 */
imx6q_resume:
	ldr	r0, =MX6Q_SRC_BASE_ADDR
	mov	r1, #0x0
	str	r1, [r0, #SRC_GPR1_OFFSET] 	@ clear SRC_GPR1
	ldr	sp, [r0, #SRC_GPR2_OFFSET]
	str	r1, [r0, #SRC_GPR2_OFFSET]	@ clear SRC_GPR2

	ldr	r9, =MX6Q_IOMUXC_BASE_ADDR
	ddr_io_restore

	ldr	r0, =MX6Q_MMDC0_BASE_ADDR
	ldr	r1, [r0, #MMDC_MAPSR_OFFSET]
	orr	r1, #MMDC_MAPSR_PSD
	str	r1, [r0, #MMDC_MAPSR_OFFSET]

	/* Disable weak 2P5 linear regulator */
	ldr	r0, =MX6Q_ANATOP_BASE_ADDR
	ldr	r1, [r0, #ANATOP_REG_2P5]
	bic	r1, #0x40000
	str	r1, [r0, #ANATOP_REG_2P5]

	ldmfd	sp!, {r2}			@ resmue func ptr
	ldmfd	sp!, {r3}
	ldmfd	sp!, {r4 - r12, lr}
	mov	sp, r3

	/* return back */
	mov	pc, r2
ENDPROC(imx6q_suspend)
