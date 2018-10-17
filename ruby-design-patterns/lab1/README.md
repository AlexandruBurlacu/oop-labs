# Design Patterns - Creational Design Patterns

In this lab I first implemented the Abstract Factory in Ruby, following the UML Class diagram
from GoF, you can see it in the `gof_abstract_factory.rb` file.

Then I found the Ruby orthdox implementation of the Abstract Factory from [here](https://practicingruby.com/articles/creational-design-patterns).

And then, I also made all factories Singletones, because who needs many factories for the same families of classes? And then, as if that's not enough, I also added the Builder pattern, it's fluent incarnation (to be honest, the way it is done is quite... dirty, but hey, it seems like a Builder, so who cares?).

Enjoy.

### The specifics of Abstract Factory, Singleton and Builder pattern in Ruby

- __Singleton__: In Ruby, a singleton can be defined by using `include Singleton` in a class. It's that easy.
- __Abstract Factory__: Ruby is a dynamic language, with great support for Duck Typing, and so it doesn't require interfaces and types. That results in implementing the concrete Product classes within the concrete Factory classes. Also, there's no actual need for Abstract classes from which to inherit, all is needed is to have a common API.
- __Builder (fluent)__: Ruby's way of doing builder is just to have a number of setter methods that return `self` so that these are chainable. In the end, you might not even need the `.build()` method, depending on the situation.

Btw, I decided to go with Ruby because of it's true OOP-ness, and the feeling of Smalltalk + more career prospects for a new grad that it gives. Smalltalk is awesone. Ruby too.

Final note - Sorry for everything-in-a-single-file way of implementation, it hurts my eyes too, but I was in a hurry.
