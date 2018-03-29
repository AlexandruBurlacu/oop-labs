/*
I usually do not write C++, but when I do, it's a template heavy piece of shit

Stages
- INPUT
- TRANSFORMATION
- OUTPUT
- FanIn
- FanOut

[INPUTS]
Read File Class
Read Stream Class

[TRANSFORMATIONS]
Lambda
Map
Reduce
Filter
FlatMap
GroupBy

[OUTPUTS]
Write File Class
Write Stream Class

[INHERITANCE TREE]

Executable<T> <- Chainable<ChildClass>
  execute(T)       set_next_stage(ChildClass*)
     |                |
     |                |
  ---------------------------------- Printable
  |         |           |
Input     Output   Transformation

  ... And below are concrete classes

*/

#include <iostream>
#include <string>
#include <vector>
#include <numeric>
#include <algorithm>
#include <fstream>

class Printable {
    operator std::string() const { return "Printable Class"; }
};

template <typename T>
class Executable {
    public:
        virtual void execute(T data) = 0;
};

template <typename T>
class Chainable {
    public:
        Executable<T>* next_stage;

        void set_next_stage(Executable<T>* next_st) {
            next_stage = next_st;
        };
};

template <typename T>
class Output: public Printable, public Executable<T> {};

template <typename T>
class Transformation: public Printable, public Executable<T>, public Chainable<T> {};

template <typename T>
class Input: public Printable, public Executable<T>, public Chainable<T> {};

/* IMPLEMENTATIONS */

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
class StdoutOutput: public Output<T> {
    public:
        void execute(T data) {
            std::cout << data << std::endl;
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

template <typename T>
class FileOutput: public Output<T> {
    std::string out_file_name;

    public:
        FileOutput(std::string filename): out_file_name(filename) {};

        void execute(T _data) {
            std::ofstream out_file;
            out_file.open(out_file_name);

            out_file << data << std::endl;

            out_file.close();
        };
};

template <typename T>
class UppercaseTransformation: public Transformation<T> {
    public:
        void execute(T data) {
            std::string new_data = (std::string) data;
            std::transform(new_data.begin(), new_data.end(), new_data.begin(), ::toupper);
            this->next_stage->execute(new_data);
        };
};

template <typename T>
class SplitterTransformation: public Transformation<T> {
    private:
        std::string delim;

        template <typename S>
        std::vector<S>
        split(const S& str, const S& delimiters) {
            std::vector<S> v;
            typename S::size_type start = 0;
            auto pos = str.find_first_of(delimiters, start);
            while(pos != S::npos) {
                if(pos != start) // ignore empty tokens
                    v.emplace_back(str, start, pos - start);
                start = pos + 1;
                pos = str.find_first_of(delimiters, start);
            }
            if(start < str.length()) // ignore trailing delimiter
                v.emplace_back(str, start, str.length() - start); // add what's left of the string
            return v;
        }

        template <typename S>
        std::string combine(std::vector<S> vec) {
            return std::accumulate(vec.begin(), vec.end(), std::string(""));
        }

    public:
        SplitterTransformation(std::string d): delim(d) {};

        void execute(T data) {
            this->next_stage->execute(combine(split(data, delim)));
        };
};

int main() {
    Input<std::string>* inp = new StdinInput<std::string>();
    Output<std::string>* out = new StdoutOutput<std::string>();
    Transformation<std::string>* tr1 = new UppercaseTransformation<std::string>();
    Transformation<std::string>* tr2 = new SplitterTransformation<std::string>(" \t");

    inp->set_next_stage(tr1);
    tr1->set_next_stage(tr2);
    tr2->set_next_stage(out);

    while (true) {
        inp->execute("42");
    }

    return 0;
}
