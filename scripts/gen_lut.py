import math
# generate LUT for embedding in the C program
print(", ".join(map(str, [int(math.log2(1 + math.pow(2, -i)) * (1 << 15)) for i in range(15)])))   