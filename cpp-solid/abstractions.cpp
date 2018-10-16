/*
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

#ifndef ABSTRACTIONS_CPP
#define ABSTRACTIONS_CPP

#include <string>

class Printable {
    public:
        operator const std::string () const { return "Printable Class"; };

        std::string to_string() const {
            return "Printable Class";
        };
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

#endif
