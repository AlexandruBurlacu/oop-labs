/* I usually do not write C++, but when I do, it's a template-heavy piece of shit */

#include <iostream>
#include <string>

#include "inputs.cpp"
#include "outputs.cpp"
#include "transformations.cpp"

int main() {
    Input<std::string>* inp = new StdinInput<std::string>();
    Output<std::string>* out = new FileOutput<std::string>("example.txt");
    Transformation<std::string>* tr1 = new UppercaseTransformation<std::string>();
    Transformation<std::string>* tr2 = new SplitterTransformation<std::string>(" \t");

    inp->set_next_stage(tr1);
    tr1->set_next_stage(tr2);
    tr2->set_next_stage(out);

    int count = 10;
    while (count--) {
        inp->execute("42");
    }

    Printable example;

    std::cout << (std::string) *inp << std::endl;
    std::cout << example.to_string() << std::endl;

    return 0;
}