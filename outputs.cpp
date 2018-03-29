#ifndef OUTPUTS_CPP
#define OUTPUTS_CPP

#include <fstream>
#include <iostream>
#include <string>

#include "abstractions.cpp"

template <typename T>
class StdoutOutput: public Output<T> {
    public:
        void execute(T data) {
            std::cout << data << std::endl;
        };
};

template <typename T>
class FileOutput: public Output<T> {
    std::string out_file_name;

    public:
        FileOutput(std::string filename): out_file_name(filename) {};

        void execute(T data) {
            std::ofstream out_file;
            out_file.open(out_file_name);

            out_file << data << std::endl;

            out_file.close();
        };
};

#endif
