/*
 * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
 */

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#ifndef __ANATOP_REGULATOR_H
#define __ANATOP_REGULATOR_H
#include <linux/regulator/driver.h>

struct anatop_regulator {
	struct regulator_desc *regulator;
	struct regulator_init_data *initdata;
	struct anatop_regulator_data *rdata;
};


struct anatop_regulator_data {
	const char *name;

	u32 control_reg;
	void *ioreg;
	int vol_bit_shift;
	int vol_bit_mask;
	int min_bit_val;
	int min_voltage;
	int max_voltage;
};

int anatop_register_regulator(
		struct anatop_regulator *reg_data, int reg,
		      struct regulator_init_data *initdata);

#endif /* __ANATOP_REGULATOR_H */
