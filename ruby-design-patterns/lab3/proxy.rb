require_relative 'decorator'

class SuperuserAuthProxy
    def initialize
        @target = SimpleComputer.new "host1"
    end

    def set_new_target(new_target)
        @target = new_target
    end

    def run_task(user, task)
        if user.admin
            @target.run_task task
        else
            raise 'You need admin credentials to use this method'
        end
    end
end

class LoggerProxy
    def initialize
        @target = SimpleComputer.new "host1"
    end

    def set_new_target(new_target)
        @target = new_target
    end

    def method_missing(method, *args, &block)
        p "Method #{method} was called on #{@target.class}"
        @target.send(method, *args, &block)
    end
end

if __FILE__ == $0
    params, func, output = [2], -> (x) { x * 42 }, nil
    task = Computation.new params, func, output
    Certificate = Struct.new(:admin)

    comp_with_logs = LoggerProxy.new
    comp_with_logs.run_task task

    protected_comp = SuperuserAuthProxy.new
    protected_comp.set_new_target(comp_with_logs)
    protected_comp.run_task Certificate.new(true), task
end
