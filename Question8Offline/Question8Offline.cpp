// Question8.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

extern "C" void calcLucasRatio();

extern "C" int readInteger()
{
	int i;
	cin >> i;
	return i;
}

extern "C" void printInteger(int i)
{
	cout << i << endl;
}

extern "C" void printString(char* s)
{
	cout << s;
}

int main()
{
	calcLucasRatio();
	return 0;
}




