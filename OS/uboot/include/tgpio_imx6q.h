/**    
    @file     tgpio_imx6.c
    @date     2013/7/22
    @author   오재경 freefrug@falinux.com  FALinux.Co.,Ltd.
    @brief    gpio 를 드라이버없이 mmap를 이용하여 제어한다.
              Ver 0.7.0
             
              
    @modify   
    @todo     
    @bug     
    @remark   
    @warning 
*/
//----------------------------------------------------------------------------
#ifndef _TGPIO_IMUX6Q_HEADER_
#define _TGPIO_IMUX6Q_HEADER_

#endif	// _TGPIO_IMUX6Q_HEADER_


#ifdef __cplusplus 
extern "C" { 
#endif 	

/// @{
/// @brief   tgpio_imx6q.h 에서 제공하는 함수 리스트 
extern void  imx6_gpio_open( int  mcu_nr );

/// @}
extern void make_wave( int freq, int keep_msec );
extern int get_rotary_switch_value(void);
extern int imx6_gpio_input( int gp_nr );
extern void set_front_led(int dbg_start, int cpu_run );


#ifdef __cplusplus 
}
#endif 
