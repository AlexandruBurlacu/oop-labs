class SuperuserAuthProxy
    def initialize(target)
        @target = target
    end

    def run(user)
        if user.admin
            @target.run
        else
            raise 'You need admin credentials to use this method'
        end
    end
end

class LoggerProxy
    def initialize(target)
        @target = target
    end

    def method_missing(method, *args, &block)
        p "Method #{method} was called on #{@target.class}"
        @target.send(method, *args, &block)
    end
end

class NormalObject
    def initialize(some_value)
        @some_value = some_value
    end

    def run
        @some_value * 2
    end
end

END {
    norm_obj = NormalObject.new 32
    p norm_obj.run

    protected_norm_obj = SuperuserAuthProxy.new norm_obj
    p protected_norm_obj.run Struct.new(:admin).new(true)

    obj_with_logs = LoggerProxy.new norm_obj
    p obj_with_logs.run
}
