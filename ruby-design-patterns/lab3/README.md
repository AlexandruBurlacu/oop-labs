# Design Patterns - Mixing all 3 types of Patterns

4 Patterns. 3 types. Ruby code. That's gonna be epic.

First things first, I'm gonna simulate the execution of an instruction in a processor, these are _Instruction Fetch_, _Instruction Decode_, _Execution_, _Memory Access_ and finally _Memory Writeback_ (at least that's what Wikipedia and the Computer Architecture course told us). Because of the sequential and cyclic nature of these operations, why not to simulate them via State Pattern? Exactly, I don't know any reasons not to, too. Now, every `SimpleComputer` can run a `Computation` and internally has a state machine to run these `Computation`s correctly. In some sense, `Computation` class is sort of a Strategy, or rather, it could become one if I want. Moving forward `SimpleComputer`s can be decorated with parallel processors or bad processors, that are slowing down the process. Also, because some computations require not to be run by anyone, we have an access proxy (`SuperuserAuthProxy`), that asks for some Admin `Certificate` before running the `Computation`s. And the icing... we got an Object Pool!!! Not just a simple one, but one that punches you in the face if you ask for more resources than it has, and that can hold any type of resources. Neat, isn't it? We will hold our computers there.

### The specifics of Proxy, Decorator, State and Object Pool patterns in Ruby

- __Proxy__: Nothing special, all is like in GoF. I implemented 2 types of proxy, one for access, and one for logging. They even support my decorators. To authenticate one has to pass a certificate struct to the `set_admin_certificate` method, before using the proxy.
- __Decorator__: Ruby has a very neat feature, it's the `SimpleDelegator` class that lets you easily create Decorators :heart: One has only to inherit it and all is done and write the `initialize` method.
- __Object Pool__: (1) Object Pool makes sense to be a Singleton, because why on Earth would you need 2 in a context? (2) To make my life easier I used as its backbone, not a list, but a `SizedQueue` and I initialize all reusable objects at once in the beginning. Also, to make it more generic, I have a dedicated class method that asks for the type of objects I will want in my pool and it's size (optional).
- __State__: Just like Proxy, nothing special. No magic. No sugar (from Ruby's perspective). A very simple state machine that simulates the instruction execution stages in a processor. To make it at least somehow useful, I also wrote sort-of-a-Strategy for it, that is passed and partially executed at state transitions.

P.S. To run the whole integrated mess: `ruby object_pool.rb` in the terminal. For partially integrated messes, run every file.
