#include <stdio.h>

void binaryprint(int num)
{
    for(int i=31; i>=0; i--)
    {
        int bit = (num >> i) & 1;
        printf("%d", bit);
    }
}

int main()
{
    int a = 60;
    int b = 13;
    printf("a = %d, binary = ",a);
    binaryprint(a);
    printf("\nb = %d, binary = ",b);
    binaryprint(b);
    int c_and = a & b;
    printf("\na&b = %d, binary = ",c_and);
    binaryprint(c_and);
    int c_or = a | b;
    printf("\na | b = %d, binary = ",c_or);
    binaryprint(c_or);
    int c_xor = a ^ b;
    printf("\na XOR b = %d, binary = ",c_xor);
    binaryprint(c_xor);
    int a_shift = a << 2;
    printf("\na<<2 = %d, binary = ",a_shift);
    binaryprint(a_shift);
}