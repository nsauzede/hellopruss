#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>

#include <prussdrv.h>
#include <pruss_intc_mapping.h>

int main(void)
{
    unsigned int ret;
    tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;

    printf("init PRU\n");
    /* Initialize the PRU */
    prussdrv_init ();
    /* Open PRU Interrupt */
    ret = prussdrv_open(PRU_EVTOUT_0);
    if (ret)
    {
        printf("prussdrv_open open failed\n");
        return (ret);
    }
    /* Get the interrupt initialized */
    prussdrv_pruintc_init(&pruss_intc_initdata);
    /* Execute firmware on PRU */
    printf("executing firmware\n");
    prussdrv_exec_program (0, "./pru0.bin");
	/* following line would disable PRU, which may not be desirable */
//    prussdrv_pru_disable (0);
    prussdrv_exit ();
    return(0);
}
