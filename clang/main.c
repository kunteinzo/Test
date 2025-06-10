#include <stdio.h>
#include <stdbool.h>

int main() {
//	int age = 0;
//	age = 21;
//	printf("Hello World!\n");
//	printf("This is my C app.\n");
//	printf("I am %d years old.\n", age);
//	printf("Please enter your age: ");
//	scanf("%d", &age);
//	printf("I am %d years old.\n", age);
        printf("Welcome\nWhat is your name?: ");
        char name[] = "";
        scanf("%s", name);
        printf("\nHello %s.\nCan I ask you some question?\n___,I am  gay.\n1 Yes\n2 No\n3 Maybe\n", name);
        int gay = 1;
        printf("\n");
        scanf("%d",&gay);
        printf("I know you are gay.\n");
	return 0;
}
