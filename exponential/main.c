#include <stdio.h>
#include <inttypes.h>

uint64_t uint64_pow(uint64_t n, uint64_t exp);

int main() {
	for (uint64_t i = 0; i < 20; i++) {
		printf("2^%2lu = %lu\n", i, uint64_pow(2,i));
	}
}
