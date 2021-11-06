/CODE WRITTEN FOR MARIE MACHINE ARCHITECTURE

/Accept an input, if that input is 0 go straight to Exit. Otherwise, jump to Compare.

Start,		Input
			Skipcond 400
        	Jump Compare
			Jump Exit

/Subtract the largest stored number from the input; if the result is greater than 0
/jump to Record. Otherwise, jump back to Start. 

Compare,	Subt B
			Skipcond 800
        	Jump Start
          	Jump Record

/Restore the number to its original value by adding the largest known number back in,
/and store the resulting value as the new largest known number. Jump back to Start.

Record,   	Add B
        	Store B
        	Jump Start

/Exit commands load the largest recorded number of the session, output the result, and 
/halt the program.

Exit, 		Load B
			Output
       	 	Halt
        
/B is the variable used to store the largest recorded number, it initialised as 0 so
/that the first input records properly (value - 0)

B, HEX 0