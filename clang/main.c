#include <stdio.h>
#include <stdbool.h>

int main() {
	int age = 0;
	age = 21;
	printf("Hello World!\n");
	printf("This is my C app.\n");
	printf("I am %d years old.\n", age);
	printf("Please enter your age: ");
	scanf("%d", &age);
	printf("I am %d years old.\n", age);
	return 0;
}
