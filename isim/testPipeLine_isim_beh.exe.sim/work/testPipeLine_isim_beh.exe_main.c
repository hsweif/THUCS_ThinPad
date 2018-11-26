/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000003006098589_3401777568_init();
    work_m_00000000001222529538_2138213552_init();
    work_m_00000000003566496742_3683593905_init();
    work_m_00000000002943187615_1648104263_init();
    work_m_00000000003866267673_2455510036_init();
    work_m_00000000000643737843_2921961307_init();
    work_m_00000000000072308389_1538694250_init();
    work_m_00000000002161408920_1382215645_init();
    work_m_00000000002906548984_2504628852_init();
    work_m_00000000002843855901_1586474674_init();
    work_m_00000000001164996165_1729233856_init();
    work_m_00000000003065383455_2457849965_init();
    work_m_00000000001985922890_4067338986_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001985922890_4067338986");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
