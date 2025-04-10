#include <stdio.h>
#include <stdbool.h>

int main() {
	printf("Hello World!\n");
	printf("This is my C app.\n");
	bool areYouGay = true;
	printf("Are you gay?: ");
	scanf("%d", &areYouGay);
	if (areYouGay)
	{
		printf("The user is gay.\n");
	} else
	{
		printf("The user isn't gay.");
	}
	
	
	return 0;
}
