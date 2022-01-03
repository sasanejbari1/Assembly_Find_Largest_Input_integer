#include <iostream>
#include <string>
extern "C" long input_array(long * array, long max_size){
	long count = 0, i = 0, j = 0;
	char input[100];
	std::cout << "Input your integer data one line at a time and enter 'q' when finished" << std::endl;
	while(count<max_size){
		std::cout << "Enter the next integer: ";
		std::cin >> input;
		i = j = 0;
		if(input[i] == '+' || input[i] == '-')
			i++;
		while(input[i]!=0){
			if(input[i] < '0' || input[i] > '9'){
				std::cerr << "You have entered nonsense! Assuming you are done" << std::endl;
				j = 1;
				break;
			}
			i++;
		}
		if (j==1)
			break;
		array[count] = strtol(input, nullptr, 10);
		std::cout << "You entered: " << array[count] <<std::endl;
		count++;
		std::cout << "You can enter up to " << max_size - count << " more integers" <<std::endl;	
	}
	std::cout <<"Total numbers entered: " << count << std::endl << std::endl;
	return count;
}