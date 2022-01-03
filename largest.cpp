#include <iostream>

extern "C" long manager();

int main(){
	std::cout <<"Welcome to CPSC 240 Assignment 3 brought to you by Sasan Ejbari" << std::endl << std::endl;
	long value = manager();
	std::cout <<"The driver received this value: " << value << std::endl;
	std::cout <<"Have a nice day. The program will return control to the operating system." << std::endl;
	return 0;
}