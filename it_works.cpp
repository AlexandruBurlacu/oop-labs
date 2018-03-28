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

Executable<T>       Stageble
  execute(T)         set_next_stage(Stageble)
     |                 |
     -------------------
              |
            Stage
              |
    -----------------------
    |         |           |
  Input     Output   Transformation

  ... And below are concrete classes

*/

#include <iostream>
#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

template <typename T>
class Executable {
    public:
        virtual void execute(T data) = 0;
};

class Stageble {
    public:
        void set_next_stage(Stageble* next_st);
};

template <typename T>
class Stage: public Stageble, public Executable<T> {    
    public:
        Stage<T>* next_stage;

        void set_next_stage(Stage<T>* next_st) {
            next_stage = next_st;
        };
};

template <typename T>
class Input: public Stage<T> {};

template <typename T>
class Output: public Stage<T> {};

template <typename T>
class Transformation: public Stage<T> {};

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
