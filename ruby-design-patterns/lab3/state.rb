class State
    def run_state(context, computation)
        computation
        raise NotImplementedError.new
    end
end

class InstructionFetch < State
    def run_state(context, computation)
        puts "Fetching #{computation.params}"
        sleep 1
        context.set_new_state(InstructionDecode.new)
    end
end

class InstructionDecode < State
    def run_state(context, computation)
        puts "Computation source: #{computation.func}"
        sleep 1
        context.set_new_state(Execute.new)
    end
end

class Execute < State
    def run_state(context, computation)
        puts "Computation result is #{computation.run}"
        sleep 1
        context.set_new_state(MemoryAccess.new)
    end
end

class MemoryAccess < State
    def run_state(context, computation)
        puts "Writing the result"
        computation.write
        sleep 1
        context.set_new_state(RegisterWriteback.new)
    end
end

class RegisterWriteback < State
    def run_state(context, computation)
        puts "The result in #output register is #{computation.output}"
        sleep 1
        context.set_new_state(InstructionFetch.new)
    end
end

class StateContext
    def initialize
        @current_state = InstructionFetch.new
    end

    def set_new_state(state)
        p "Transitioning from #{@current_state.class} to #{state.class}"
        @current_state = state
    end

    def run_state(computation)
        @current_state.run_state self, computation
    end
end

class Computation
    attr_reader :params, :func, :output

    def initialize(params, func, output)
        @params = params
        @func = func
        @output = output
    end

    def run
       @temp = func[*params]
       @temp
    end

    def write
        @output = @temp
        @temp = nil
    end
end

if __FILE__ == $0
    state_context = StateContext.new
    params, func, output = [2], -> (x) { x * 42 }, nil
    computation = Computation.new params, func, output

    state_context.run_state computation
    state_context.run_state computation
    state_context.run_state computation
    state_context.run_state computation
    state_context.run_state computation
end
