#include "TM4C123GH6PM.h"
void printNewLine()
{
	 char ptr_n[5] = "\n";
	 ITM_SendChar(*ptr_n);
	 return;
}
