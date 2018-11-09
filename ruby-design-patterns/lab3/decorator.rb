class ComputerDecorator < SimpleDelegator
    def initialize(machine)
        @machine = machine
        super
    end
end

class GPUEnabledMachine < ComputerDecorator
    def run_on_gpu(task)
        p "Just running on GPU"
        task[]
        task[]
        task[]
    end
end

class MachineWithDocker < ComputerDecorator
    def containerize(service)
        p "Just running safely in a container"
        service[]
        p "Exiting the container"
    end
end

class WithInfinibandAdapter < ComputerDecorator
    def connect(machine)
        raise NotImplementedError.new
    end
end

class SimpleComputer
    def initialize(name)
        @name = name
    end

    def just_run(task)
        p "Just running"
        task[]
    end
end

END {
    comp = SimpleComputer.new "host1"
    gpu_comp_with_docker = MachineWithDocker.new GPUEnabledMachine.new comp

    gpu_comp_with_docker.run_on_gpu -> { p 42 }
}
