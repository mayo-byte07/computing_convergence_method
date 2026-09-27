#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>
#include <arm_neon.h>

// !
// NOTE: This file's docs are intentionally not great because it's cloned from the `5_general_optimizations.c` file, just with a tester.
// !

#define K 16
#define SCALE_FACTOR (1 << (K - 1))

double ccm(double input_value) {
    register int32_t M = (int32_t)(input_value * SCALE_FACTOR);
    register int32_t f = 0;
    int shifts = 0;

    // define the LUT arrays
    int32_t LUT_array1[4] = {32768, 19168, 10548, 5568};
    int32_t LUT_array2[4] = {2865, 1454, 732, 367};
    int32_t LUT_array3[4] = {184, 92, 46, 23};
    int32_t LUT_array4[4] = {11, 5, 2, -1};

    // load LUT into NEON vectors
    int32x4_t LUT_vec[4] = {
        vld1q_s32(LUT_array1),
        vld1q_s32(LUT_array2),
        vld1q_s32(LUT_array3),
        vld1q_s32(LUT_array4)
    };

    // normalize M to be within the range [0.5, 1.0)
    while (M >= SCALE_FACTOR) {
        M >>= 1;
        shifts++;
    }

    for (register int i = 0; !(i & 16); i += 2) {
        int32_t LUT_val1 = vgetq_lane_s32(LUT_vec[i >> 2], i & 3);
        register int32_t u1 = M + (M >> i);
        register int lteSF1 = u1 <= SCALE_FACTOR;
        M = lteSF1 ? u1 : M;
        f = lteSF1 ? f - LUT_val1 : f;

        if (!((i + 2) & 16)) {
            int32_t LUT_val2 = vgetq_lane_s32(LUT_vec[(i + 1) >> 2], (i + 1) & 3);
            register int32_t u2 = M + (M >> (i + 1));
            register int lteSF2 = u2 <= SCALE_FACTOR;
            M = lteSF2 ? u2 : M;
            f = lteSF2 ? f - LUT_val2 : f;
        }
    }

    f += shifts << (K - 1); 

    return (double)f / SCALE_FACTOR;
}

int main() {
    const int NUM_TESTS = 1000; 
    double total_percentage_difference = 0.0;

    for (int i = 0; i < NUM_TESTS; i++) {
        // between 0 and 100
        double input_value = (double)rand() / (double)RAND_MAX;

        // scale to be between 0 and 100
        input_value *= 100.0;


        // check my version
        double ccm_result = ccm(input_value);

        // check real true value
        double math_log2_result = log2(input_value);

        // get percent difference
        double percentage_difference = fabs((ccm_result - math_log2_result) / math_log2_result) * 100.0;
        total_percentage_difference += percentage_difference;

        // log
        printf("TEST CASE %d:\n-----\n", i + 1);
        printf("Randomly chosen input: %f\n", input_value);
        printf("CCM log2: %f\n", ccm_result);
        printf("True log2: %f\n", math_log2_result);
        printf("Percent difference: %f%%\n\n", percentage_difference);
    }

    printf("MEAN OVERALL PERCENTAGE DIFFERENCE: %f%%\n", total_percentage_difference / NUM_TESTS);

    return 0;
}
