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
    pulse_off    SERVO_00_GPIO, SERVO_00_BIT                                                                     // 40ns

    pulse_on    SERVO_02_GPIO, SERVO_02_BIT
    pulse_on    SERVO_03_GPIO, SERVO_03_BIT
    pulse_on    SERVO_04_GPIO, SERVO_04_BIT

    pulse_on    SERVO_06_GPIO, SERVO_06_BIT
    pulse_on    SERVO_07_GPIO, SERVO_07_BIT
    pulse_on    SERVO_08_GPIO, SERVO_08_BIT

    pulse_on    SERVO_10_GPIO, SERVO_10_BIT
    pulse_on    SERVO_11_GPIO, SERVO_11_BIT
    pulse_on    SERVO_12_GPIO, SERVO_12_BIT

    pulse_on    SERVO_14_GPIO, SERVO_14_BIT
    pulse_on    SERVO_15_GPIO, SERVO_15_BIT

MAIN_LOOP:
    pulse_on    SERVO_01_GPIO, SERVO_01_BIT
    pulse_off    SERVO_05_GPIO, SERVO_05_BIT
    pulse_off    SERVO_09_GPIO, SERVO_09_BIT
    pulse_off    SERVO_13_GPIO, SERVO_13_BIT
    wait    DELAY1
    pulse_off    SERVO_01_GPIO, SERVO_01_BIT
    pulse_on    SERVO_05_GPIO, SERVO_05_BIT
    pulse_off    SERVO_09_GPIO, SERVO_09_BIT
    pulse_off    SERVO_13_GPIO, SERVO_13_BIT
    wait    DELAY1
    pulse_off    SERVO_01_GPIO, SERVO_01_BIT
    pulse_off    SERVO_05_GPIO, SERVO_05_BIT
    pulse_on    SERVO_09_GPIO, SERVO_09_BIT
    pulse_off    SERVO_13_GPIO, SERVO_13_BIT
    wait    DELAY1
    pulse_off    SERVO_01_GPIO, SERVO_01_BIT
    pulse_off    SERVO_05_GPIO, SERVO_05_BIT
    pulse_off    SERVO_09_GPIO, SERVO_09_BIT
    pulse_on    SERVO_13_GPIO, SERVO_13_BIT
    wait    DELAY1
    pulse_off    SERVO_01_GPIO, SERVO_01_BIT
    pulse_off    SERVO_05_GPIO, SERVO_05_BIT
    pulse_on    SERVO_09_GPIO, SERVO_09_BIT
    pulse_off    SERVO_13_GPIO, SERVO_13_BIT
    wait    DELAY1
    pulse_off    SERVO_01_GPIO, SERVO_01_BIT
    pulse_on    SERVO_05_GPIO, SERVO_05_BIT
    pulse_off    SERVO_09_GPIO, SERVO_09_BIT
    pulse_off    SERVO_13_GPIO, SERVO_13_BIT
    wait    DELAY1

    JMP     MAIN_LOOP                                                                                           //  5ns
