.origin 0
.entrypoint START

#include "servos.hp"
#include "macros.hp"

START:

    // Enable OCP master port, to allow communication with ARM bus
    LBCO    r1, C4, 4, 4        // load content of PRU_ICSS_CONFIG register (pointed by C4) into r0
    CLR     r1, r1, 4           // clear SYSCFG[STANDBY_INIT], which enables OCP master port
    SBCO    r1, C4, 4, 4        // store back PRU_ICSS_CONFIG register content


// Main loop, which basically blinks an external LED on GPIO
// gnd is 

MAIN_LOOP:
    // Turn on servos 0-15 outputs
    pulse_on    SERVO_00_GPIO, SERVO_00_BIT                                                                     // 40ns
    pulse_on    SERVO_01_GPIO, SERVO_01_BIT
    pulse_off    SERVO_02_GPIO, SERVO_02_BIT
    pulse_on    SERVO_03_GPIO, SERVO_03_BIT

    // First µs
    wait    DELAY1


    // Turn on servos 16-31 outputs
    pulse_off    SERVO_00_GPIO, SERVO_00_BIT                                                                     // 40ns
    pulse_on    SERVO_01_GPIO, SERVO_01_BIT
    pulse_off    SERVO_02_GPIO, SERVO_02_BIT
    pulse_on    SERVO_03_GPIO, SERVO_03_BIT

    // First µs
    wait    DELAY2

    JMP     MAIN_LOOP                                                                                           //  5ns
