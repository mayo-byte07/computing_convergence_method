#include <stdio.h>
#include <stdint.h>
#include <math.h>

// # of bits of precision
#define K 16
// 2^(K-1) represents our scale => 2^15 = 32768
#define SCALE_FACTOR (1 << (K - 1))  

// dynamic LUT
void calculate_lut(int32_t LUT[K]) {
    for (int i = 0; i < K - 1; i++) {
        LUT[i] = (int32_t)(log2(1 + pow(2, -i)) * SCALE_FACTOR); 
    }
}

// ccm with fixed point arithmetic
int32_t log2_CCM(int32_t M) {   
    int32_t LUT[K];
    // dynamic LUT
    calculate_lut(LUT);

    // init to 0
    int32_t f = 0; 

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

    int32_t result_fixed = log2_CCM(M_fixed);
    printf("ccm log2(%d) = %d\n", M_fixed, result_fixed);

    // revert to floating-point notation
    // double result_real = (double)result_fixed / SCALE_FACTOR;

    // printf("unoptimized fp ccm log2(%f) = %f\n", M_real, result_real);

    return 0;
}
