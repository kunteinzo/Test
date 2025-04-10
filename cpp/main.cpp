#include <iostream>
using namespace std;

int main() {
	const int MAX = 100;
	string name;
	int age;
	cout << "Enter your name: ";
	getline(cin, name); // Read a line of text
	cout << "Enter an integer: ";
	cin >> age; // Do not skip whitespace
	cout << "Hello " << name << ", you are " << age << " years old.\n" << endl;
	cout << "Hello World!\n";
	cout << "This is my C++ app.";
 	return 0;
}
