#include <stdio.h>
#include <stdint.h>
#include <arm_neon.h>

#define K 16
#define SCALE_FACTOR (1 << (K - 1))

int main()
{   
    // conversion to fixed-point notation
    double real_input = 22;
    register int32_t M = (int32_t)(real_input * SCALE_FACTOR);

    // init to 0
    register int32_t f = 0;

    // defining the LUT arrays separately
    // from python script
    int32_t LUT_array1[4] = {32768, 19168, 10548, 5568};
    int32_t LUT_array2[4] = {2865, 1454, 732, 367};
    int32_t LUT_array3[4] = {184, 92, 46, 23};
    int32_t LUT_array4[4] = {11, 5, 2, -1}; // -1 to represent we don't use this place of the array, but have the space (for alignment)

    // load the LUT into NEON vectors
    int32x4_t LUT_vec[4] = {
        // v1
        vld1q_s32(LUT_array1),
        // v2
        vld1q_s32(LUT_array2),
        // v3
        vld1q_s32(LUT_array3),
        // v4 with dummy padding of 128/4 on the right side (32 bit)
        vld1q_s32(LUT_array4)};

    // normalization of M to range
    int shifts = 0;
    while (M >= SCALE_FACTOR)
    {
        // keep shifting till within range
        M >>= 1;
        // inc shift to make reversible later
        shifts++;
    }

    // double loop
    for (register int i = 0; !(i & 16); i += 2)
    {
        // NEON to LUT value #1 for unroll 1
        int32_t LUT_val1 = vgetq_lane_s32(LUT_vec[i >> 2], i & 3);

        // #1 unrolled iter
        register int32_t u1 = M + (M >> i);
        register lteSF1 = u1 <= SCALE_FACTOR;
        M = lteSF1 ? u1 : M;
        f = lteSF1 ? f - LUT_val1 : f;

        // prepare for the next iteration within the current one #2 one
        if (!((i + 2) & 16))
        {
            // NEON to LUT value #2 for unroll 2
            int32_t LUT_val2 = vgetq_lane_s32(LUT_vec[(i + 1) >> 2], (i + 1) & 3);
            register int32_t u2 = M + (M >> (i + 1));
            register lteSF2 = u2 <= SCALE_FACTOR;
            M = lteSF2 ? u2 : M;
            f = lteSF2 ? f - LUT_val2 : f;
        }
    }

    // denormalize the fixed-point value
    f += shifts << 15; // K - 1 = 15
    printf("optimized fp ccm log2(%f) = %f\n", 0.6, (double)f / SCALE_FACTOR);

    return 0;
}
