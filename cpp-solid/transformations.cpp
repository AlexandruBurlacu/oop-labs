#ifndef TRANSFORMATIONS_CPP
#define TRANSFORMATIONS_CPP

#include <vector>
#include <numeric>
#include <algorithm>

#include "abstractions.cpp"

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

#endif
