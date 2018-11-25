require_relative 'decorator'

Certificate = Struct.new(:admin)

class SuperuserAuthProxy
    def initialize
        @target = SimpleComputer.new
        @cert = Certificate.new(false)
    end

    def set_new_target(new_target)
        @target = new_target
    end

    def set_admin_certificate(cert)
        @cert = cert
    end

    def run_task(task)
        if @cert.admin
            @target.run_task task
        else
            raise 'You need admin credentials to use this method'
        end
    end
end

class LoggerProxy
    def initialize
        @target = SimpleComputer.new
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

    comp_with_logs = LoggerProxy.new
    comp_with_logs.run_task task

    protected_comp = SuperuserAuthProxy.new
    protected_comp.set_new_target comp_with_logs
    protected_comp.set_admin_certificate Certificate.new(true)
    protected_comp.run_task task
end
