"""
Offer a significant performance boost; it is most effective in
situations where the cost of initializing a class instance is high, the
rate of instantiation of a class is high, and the number of
instantiations in use at any one time is low.
"""

require 'singleton'
require_relative 'proxy'

class ReusablePool
    """
    Manage Computer objects for use by Client objects.
    """
    include Singleton

    def self.of(cls, with_size=10)
        @@cls = cls
        @@size = with_size
        self
    end

    def initialize
        @reusables = SizedQueue.new @@size
        @@size.times { @reusables.push @@cls.new }
    end

    def acquire
        @reusables.pop
    end

    def release(reusable)
        @reusables.push reusable
    end
end


if __FILE__ == $0
    reusable_pool = ReusablePool.of(SuperuserAuthProxy).instance
    comp1 = reusable_pool.acquire
    comp2 = reusable_pool.acquire
    comp3 = reusable_pool.acquire
    reusable_pool.release(comp1)
    comp4 = reusable_pool.acquire

    params, func, output = [2], -> (x) { x * 42 }, nil
    task = Computation.new params, func, output

    [comp2, comp3, comp4].each do |comp|
        comp.set_admin_certificate Certificate.new(true)
        super_comp = ParallelMachine.new SlowMachine.new comp
        super_comp.run_task task
    end
end
