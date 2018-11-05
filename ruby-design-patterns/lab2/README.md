# Design Patterns - Behavioural and Structural Patterns

Will implement an Iterpreter with Visitor and Bridge Pattern.

Using Interpreter Pattern I will define an interpreter for the simple math subset of the Forth language. Then, using the Visitor Pattern, I will make the Components class capable of computing simple expressions in Polish notation/Forth Language or outputing some strings. In the end, I will define separately a bunch of Low-level Implementors and Higher-level abstractions, those resulting in 2 orthogonal hierarchies of classes, making the Bridge Pattern implementation a breeze.

### The specifics of Interpreter, Visitor and ??? pattern in Ruby

- __Interpreter__: In Ruby and writing custom sublanguages are a match made in heaven. Although Ruby extends the idea of Interpretor to DSLs (Domain Specific Language), the core concept, of creating sub-languages for specific domains that are easy to extend, is still there. Because Ruby is so dynamic, there's no need for the base Expression class. Just keep duck-typing your way until it works.
- __Visitor__: Visitor is a great idea, IMO, making it so easy to add functionality to an existing class. It's like an USB. In Ruby the implementation is pretty much the same as the canonic, GoF one. Only that the Visitable is a module in my implementation, such that now I can use it as a trait and reutilize the logic.
- __Bridge__: To make the Bridge work in Ruby, just follow the UML diagram from GoF, no special Ruby magic is required. 2 Orthogonal (read, non overlapping) hierarchies that can use one another, and you are basically done.


P.S. This time, the patterns are split in 3 different files, hallelujah.