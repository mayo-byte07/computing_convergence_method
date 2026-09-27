#include <stdio.h>
#include <stdint.h>

// # of bits of precision
#define K 16
// 2^(K-1) represents our scale => 2^15 = 32768
#define SCALE_FACTOR (1 << (K - 1))  

// predefined lookup LUT values (pre-calculated with a small Python script)
const int32_t LUT[K-1] = {
    32768, 19168, 10548, 5568, 2865, 1454, 732, 
    367, 184, 92, 46, 23, 11, 5, 2
};

// ccm now with fixed point
int32_t log2_CCM(int32_t M) {
    int32_t f = 0; 

    // iter from 0 to K-1
    for (int i = 0; i < K - 1; i++) {
        int32_t u = M + (M >> i);  
        int32_t phi = f - LUT[i];

        if (u <= SCALE_FACTOR) {
            M = u;
            f = phi;
        }
    }

    return f; 
}

int main() {
    // double M_real = 0.6;  
    // convert to fixed-point notation
    // int32_t M_fixed = (int32_t)(M_real * SCALE_FACTOR);

    // dummy scaled value for testing
    int32_t M_fixed = 19660;

    // call the optimized CCM log2 function
    int32_t result_fixed = log2_CCM(M_fixed);

    // get output
    printf("ccm log2(%d) = %d\n", M_fixed, result_fixed);

    // revert to floating-point notation
    // double result_real = (double)result_fixed / SCALE_FACTOR;

    // printf("optimized fp ccm log2(%f) = %f\n", M_real, result_real);

    return 0;
}
