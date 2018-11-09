class State
    def run_state(context)
        raise NotImplementedError.new
    end
end

class InstructionFetch < State
    def run_state(context)
        sleep 1
        context.set_new_state(InstructionDecode.new)
    end
end

class InstructionDecode < State
    def run_state(context)
        sleep 1
        context.set_new_state(Execute.new)
    end
end

class Execute < State
    def run_state(context)
        sleep 1
        context.set_new_state(MemoryAccess.new)
    end
end

class MemoryAccess < State
    def run_state(context)
        sleep 1
        context.set_new_state(RegisterWriteback.new)
    end
end

class RegisterWriteback < State
    def run_state(context)
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

    def run_state
        @current_state.run_state self
    end
end

END {
    state_context = StateContext.new

    state_context.run_state
    state_context.run_state
    state_context.run_state
    state_context.run_state
    state_context.run_state
    state_context.run_state
}
