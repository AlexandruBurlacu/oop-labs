#ifndef INPUTS_CPP
#define INPUTS_CPP

#include <fstream>
#include <iostream>
#include <string>

#include "abstractions.cpp"

template <typename T>
class StdinInput: public Input<T> {
    public:
        void execute(T _data) {
            std::string used_data;
            std::cin >> used_data;
            this->next_stage->execute(used_data);
        };
};

template <typename T>
class FileInput: public Input<T> {
    std::string in_file_name;

    public:
        FileInput(std::string filename): in_file_name(filename) {};

        void execute(T _data) {
            std::string data;

            std::ifstream src_file;
            src_file.open(in_file_name);

            src_file >> data;

            src_file.close();
            this->next_stage->execute(data);
        };
};

#endif
