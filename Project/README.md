## Advanced ARM Architecture Project - Implementation of a Scheduler in Cortex M4

### Background 
#### - Scheduler
A program is a set of instructions. A process is a program under execution. When multiple programs run on the same processor they will have to share the resources. If that's the case then, we need a program called the scheduler. It will schedule the tasks (i.e., programs) such that each of the tasks is given the resources without bias, unless prioritised.
Many different algorithms are available to implement the scheduler. We have chosen to implement the easiest of them all.
The Round Robin Algorithm:
When a particular task arrives, it's added to the queue, and the first task from the head of the queue is assigned the processor for t cycles. After t cycles, the task which is being run is added back at the end of the queue. And the process is repeated until the queue is empty.
For example, suppose there are 4 tasks to be scheduled, the processor will run task1 for t cycles, and then task2 for t cycles, and so on. After task4 has run for t cycles, task1 is run again for t cycles. Supposing a task end in less than nt (where n is an integer) cycles, then the next task is before the nth t-cycle is complete.

[1] Context Switching involves storing the context or state of a process so that it can be reloaded when required and execution can be resumed from the same point as earlier. Since we run the task only for t cycles, and most times tasks do not end in t cycles, we need to store the context of each task.

#### - Interrupt
[2] An interrupt is a function of an operating system that provides multi-process multi-tasking. The interrupt is a signal that prompts the operating system to stop work on one process and start work on another (called the Interrupt Service Routine). In the cortex M4 when the interrupt occurs, it also saves the context so that it can return to after the point at which the interrupt occurred. It saves R0-R3, R12, R14 (Link Register), R15 (Program Counter) and the xPSR.
We make use of this context switch data. Will be explained later, how exactly.

#### - SysTick Timer
[3] SysTick is a simple timer that is part of the NVIC controller in the Cortex-M microprocessor. Its intended purpose is to provide a periodic interrupt for an RTOS, but it can be used for other simple timing purposes.

### Procedure
We used the SysTick timer and the ISR that it raises. When it enters the SysTick ISR, it saves part of the context of the process under execution. So within the ISR we save the other part of the context and then switch back.
[4] The SysTick timer is memory mapped to the location 0xE000E010. The last three bits are what we play around with.
Bit 0 - Enable the timer.
Bit 1 - Which clock signal should the timer consider.
Bit 2 - Enable the counter.
When the counter reaches 0, the ISR will be called.
Within the ISR after disabling the timer, we store the value of R4-R11, since those values do not get saved during the interrupt context switch.
Our task queue is within the memory itself, i.e., 0x20000000->0x20000030->0x20000060.
For saving R4-R11, we again use different locations within the memory, i.e., 0x20000200->0x20000230->0x20000260

The context of the current program is saved in the stack when we go into an ISR. Within the ISR we change the contents of the stack so that the next task's context is loaded, and that is what the ISR considers for context switch.

For debugging purposes we assigned;
- task1 - Turn ON the LED.
- task2 - Turn OFF the LED
- task3 - Turn OFF the LED
- task4 - Turn OFF the LED

For this we also used the GPIO registers. This part of the code was taken from [5]

### Challenges Faced
When being run through the debugger, the program sometimes goes into HardFault exception. We still can't figure out why.

### Acknowledgements
Thanks to professor Girish Kumar for baring with our million queries!

### References:
[1] https://www.tutorialspoint.com/what-is-context-switching-in-operating-system

[2] https://www.techopedia.com/definition/3373/interrupt-computing

[3] http://dev.ti.com/tirex/content/simplelink_msp432_sdk_1_30_00_40/docs/driverlib/msp432p4xx/html/driverlib_html/group__systick__api.html

[4] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0553a/Babieigh.html

[5] https://github.com/gopal-amlekar/stm32f4-arm-systick
