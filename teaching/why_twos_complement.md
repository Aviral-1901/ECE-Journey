Normal binary can only represent positive numbers. To work with real world problems we need negative numbers too. 

First attempt — sign-magnitude, how it works
Signed magnitude representation is a way in which we keep the MSB for sign and we keep 0 for + and 1 for -. Using this we would be represent a number like 3 as 011 and -3 as 111.

Why it fails?
But this method is highly flawed. Adding 3 to -3 would result in 1010 which is not a zero. And in this system the number 0 would be represented by 000 and 100 and there is no such thing as -0 so this system of representing numbers is discarded.

Better solution - 2's complement 
So it works on the idea that negative of a number when added to its positive part gives 0. Like (-3) + (+3) = 0. For it also the MSB shows the sign 0 means + and 1 means -. In binary 3 is 011. Normally 3 could be represented by 2 bits but as we are dealing with signs we need 3 bits to represent 3 and using 3 bits allows us to represent values from -4 to 3.

How to calculate 2's complement
To get a 2's complement at first we have to invert all the bits of the number then we add 1 to it.
Like 3 is 011.
At first we invert the bits so it becomes 100.
Now we add 1 to the inverted bit (100) + 1 = 101 which is the 2's complement of binary.

Proof it works 
-3 in two's complement is 101 (derived by inverting 011 → 100, adding 1 → 101).

Proof: 3 + (-3) should equal 0.
  011
+ 101
-----
 1000  → discard carry → 000 

In signed number representation we had two numbers representing 0 but in 2's complement there is no such thing like that. There is only one 0 and due to this we get one extra -ve number so 3 bit can represent numbers from -4 to +3.