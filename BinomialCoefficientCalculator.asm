/CODE WRITTEN FOR MARIE MACHINE ARCHITECTURE

Start,									Input
                                        Store n
                                        Input 
                                        Store k
                                        
/Here I verify that n ≥ k subtracting k from n, and checking that the result is not less than 0.
/I then verify that k is not less than 0. If either is < 0 they will fail the skipcond and jump
/to the program's exit subroutine.

                                        Load n
                                        Subt k
                                        Skipcond 800
                                        Jump Exit
                                        Load k
                                        Skipcond 800
                                        Jump Exit
                                        
/This first sequence of commands sets a series of variables use in my FactorialCalculation subroutine
/to values required to calculate the factorial of whatever the user input for n. It then runs the
/FactorialCalculation subroutine.

StartFactorialN,						Load n
                                        Store addValue
                                        Subt one
                                        Store multCounter
                                        Store currentFactor
                                        Jump FactorialCalculation

/Once the FactorialCalculation has finished calculating (n!) it will run through the MainSequence
/subroutine, which will recognise that no valid value exists at the memory address of the variable
/nFactorial, assume that it has just completed calculating (n!) and jump to the StoreNFactorial
/subroutine.

StoreNFactorial,						Load runningTotal
                                        Store nFactorial
                                        Clear
                                        Store runningTotal
                            
/Once the result of (n!) has been calculated and stored, the program sets the variables used in the
/FactorialCalculation subroutine to those required to calculate the factorial of the user's k value.
/It then runs the FactorialCalculation subroutine.

StartFactorialK,						Load k
                                        Store addValue
                                        Subt one
                                        Store multCounter
                                        Store currentFactor
                                        Jump FactorialCalculation

/Upon completion the FactorialCalculation subroutine once again jumps to the MainSequence subroutine,
/which will recognise that a non-0 value is stored in nFactorial but not in kFactorial, and send the
/program to StoreKFactorial with the FactorialCalculation's saved values.

StoreKFactorial,						Load runningTotal
                                        Store kFactorial
                                        Clear
                                        Store runningTotal

/After storing kFactorial the program sets FactorialCalculation's variables such that they will calculate
/(n-k)! - and once again runs the FactorialCalculation subroutine.

StartNMinusKFactorial,					Load n
                                        Subt k
                                        Store addValue
                                        Subt one
                                        Store multCounter
                                        Store currentFactor
                                        Jump FactorialCalculation
                            
/FactorialCalculation segues into MainSequence on completion, which identifies nFactorial and kFactorial
/as completed, and sends the program back to StoreNMinusKFactorial 
                            
StoreNMinusKFactorial, 					Load runningTotal
                                        Store nMinusKFactorial
                                        Clear
                                        Store runningTotal

/In order to get our final denominator for the binomial coefficient we have to solve for k!(n-k)!, 
/we have k! and (n-k)! now so we must solve for k!(n-k)!. The MultiplyKByNMinusK does this without
/use of the FactorialCalculation subroutine. 
                                        
StartkFactorialByNMinusKFactorial,      Load kFactorial
                                        Store addValue

                                        Load nMinusKFactorial
                                        Store multCounter
                            
MultiplyKByNMinusK,						Load runningTotal
                                        Add addValue
                                        Store runningTotal

                                        Load multCounter
                                        Subt one
                                        Store multCounter

                                        Skipcond 800
                                        Jump MainSequence /If multCounter is 0, program advances
                                        				  /to Divide subroutine via MainSequence
                                        Jump MultiplyKByNMinusK
                            
StoreKFactorialByNMinusKFactorial,	    Load runningTotal
                                        Store kFactorialByNMinusKFactorial
                                        Clear
                                        Store runningTotal
                                        Jump MainSequence
   
/The FactorialCalculation subroutine performs a series of multiplications based of the values
/of addValue, multCounter, and currentFactor - all of which must be set before entering it.

/addValue defines the value to be added in a given multiplication round, multCounter counts
/how many times it must be added until a given multiplication is complete, and currentFactor
/tracks what multiplication in the factorial should be completed.

/To solve for (n!) the variable addValue should be set to (n) and the variables multCounter
/and currentFactor should both be set to (n-1). The Factorial Calculation subroutine once entered
/will add 6 to "runningTotal" 5 times. Once multCounter hits 0 (there are no more multiplications
/to be completed) the FactorialCalculation subroutine will exit its multiplication loop and check
/currentFactor. So long as currentFactor is 1 or greater, it will reduce that number by one and
/set multCounter to the same number, before restarting the multiplication loop. Now, the multiplication
/loop will add the current value (stored in the runningTotal variable) to itself the quantity of times
/listed in multCounter. In the case of 6!, it will add runningTotal from the previous round (30) to itself
/4 times (as it as already completed n-1, it is now completing n-2). It will continue this process until
/currentFactor is 1, at which point it will return to MainSequence for instructions on what to do next.
/In MainSequence, it will direct itself to the appropriate place to store its result, which will in turn
/direct the program to the next calculation.
   
FactorialCalculation, 					Load runningTotal		
                                        Add addValue			
                                        Store runningTotal		

                                        Load multCounter		
                                        Subt one
                                        Store multCounter

                                        Load multCounter 			        
                                        Skipcond 400				
                                        Jump FactorialCalculation	

                                        Load runningTotal
                                        Store addValue	 					

                                        Load currentFactor
                                        Subt one
                                        Skipcond 800				
                                        Jump MainSequence			

                                        Store multCounter 			
                                        Store currentFactor 		
                                        Clear
                                        Store runningTotal
                                        Jump FactorialCalculation
                            
MainSequence,							Load nFactorial
                                        Skipcond 800
                                        Jump StoreNFactorial

                                        Load kFactorial
                                        Skipcond 800
                                        Jump StoreKFactorial

                                        Load nMinusKFactorial
                                        Skipcond 800
                                        Jump StoreNMinusKFactorial

                                        Load kFactorialByNMinusKFactorial
                                        Skipcond 800
                                        Jump StoreKFactorialByNMinusKFactorial

                                        Jump DivideNFactorialByNMinusKFactorial

/Once all of the required Factorials have been calculated, the program has a simplified division to
/complete. For n=6 and k=4, for example, it would be 720/48. The Divide subroutine stores the dividend
/and repeatedly subtracts the divisor from it. Each time that this process completes and yields a result
/not smaller than 0 it adds 1 onto the value of the variable quotient.

/Once subtracting the divisor from the dividend results in the dividend equaling 0 or less the program
/checks that the remainder is not equal to the dividend (as this would result in one quotient being missed
/and output as a remainder, in the case of 720/48 it would output: 14 remainder 48 etc..). If it is equal
/to the dividend it increases the quotient by 1 and clears the remainder. Otherwise the program posts
/both the quotient and remainder.

DivideNFactorialByNMinusKFactorial,		Load nFactorial
										Store dividend
                                        
                                        Load kFactorialByNMinusKFactorial
                                        Store divisor
                                        
Divide,									Load dividend
										Subt divisor
                                        Skipcond 800
                                        Jump Output
                                        Store dividend
                                        Load quotient
                                        Add one
                                        Store quotient
                                        Jump Divide
                                        
Output,									Load dividend
										Subt divisor
                                        Skipcond 000
                                        Jump WholeDivision
										Output
                                        Load quotient
                                        Output
                                        Halt
                                        
WholeDivision,							Load quotient
										Add one
                                        Store quotient
                                        Load dividend
                                        Subt divisor
                                        Store dividend
                                        Jump Output
                    
Exit,									Halt
                                 		
n, DEC 0
k, DEC 0
multCounter, DEC 0
addValue, DEC 0
currentFactor, DEC 0
runningTotal, DEC 0
nFactorial, DEC 0
kFactorial, DEC 0
nMinusKFactorial, DEC 0
kFactorialByNMinusKFactorial, DEC 0
dividend, DEC 0
divisor, DEC 0
quotient, DEC 0
one, DEC 1