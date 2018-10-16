module HighEndComputerFactory
  extend self

  def make_computer
    cpu = CPU.new
    ram = RAM.new

    [cpu, ram]
  end

  class RAM
    def write
      p "OK, nothing strange here"
    end
  end

  class CPU
    def run
      p "Being pseudo-innovative and bragging about More's law"
    end
  end

end

module LowBudgetComputerFactory
  extend self

  def make_computer
    cpu = CPU.new
    ram = RAM.new

    [cpu, ram]
  end

  class RAM
    def write
      p "Who the fuck uses it anymore?"
    end
  end

  class CPU
    def run
      p "Being Intel's bitch, so that they don't get fucked for monopoly"
    end
  end

end

module EnergyEfficientComputerFactory
  extend self

  def make_computer
    cpu = CPU.new
    ram = RAM.new

    [cpu, ram]
  end

  class RAM
    def write
      p "OK, nothing strange here"
    end
  end

  class CPU
    def run
      p "Doing some rad shit in computing efficiency"
    end
  end
end

class Application
  def initialize(factory)
    cpu, ram = factory.make_computer
    cpu.run
    ram.write
  end
end

END {
  Application.new(EnergyEfficientComputerFactory)
}
