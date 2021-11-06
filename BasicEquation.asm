/CODE WRITTEN FOR MARIE MACHINE ARCHITECTURE

/Prompt user for four inputs and store them as variables A, B, C, and D

Input
Store A
Input
Store B
Input
Store C
Input
Store D

/Load the value of variable B into the Accumulator, add the values of variables B and D,
/and store the resulting value as the variable EXPR1

Load B
Add B
Add D
Store EXPR1

/Load the value of variable A into the Accumulator, add the value of variable A twice,
/add the value of variable C once, subtract the value of EXPR1, and store the resulting
/value as variable E

Load A
Add A
Add A
Add C
Subt EXPR1
Store E

/Output the value in the Accumulator

Output
Halt

/Initialise each of the variables used in the program with a value of 0

A, DEC 0
B, DEC 0
C, DEC 0
D, DEC 0
EXPR1, DEC 0
E, DEC 0