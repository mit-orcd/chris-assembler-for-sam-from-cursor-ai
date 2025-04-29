#include <stdio.h>
#include <cuda_runtime.h>

// PTX function declaration
extern "C" void float_add(double a, double b, double *result);

int main() {
    double a = 3.14159;
    double b = 2.71828;
    double result;

    // Call the PTX function
    float_add(a, b, &result);

    printf("Result: %f\n", result);

    return 0;
} 