require_relative 'state'

class ComputerDecorator < SimpleDelegator
    def initialize(machine)
        @machine = machine
    end
end

class ParallelMachine < ComputerDecorator
    def run_task(task)
        p "Just running on GPU"
        @machine.run_task task
        @machine.run_task task
        @machine.run_task task
    end
end

class SlowMachine < ComputerDecorator
    def run_task(task)
        p "I'm slow to start"
        sleep 1
        @machine.run_task task
    end
end

class SimpleComputer
    def initialize
        @state_context = StateContext.new
    end

    def run_task(task)
        p "Just running"
        @state_context.run_state task
    end
end

if __FILE__ == $0
    comp = SimpleComputer.new
    slow_gpu_comp = ParallelMachine.new SlowMachine.new comp

    params, func, output = [2], -> (x) { x * 42 }, nil
    task = Computation.new params, func, output

    slow_gpu_comp.run_task task
end
