module HighEndComputerFactory
  extend self

  def make_computer
    cpu = CPU.new
    ram = RAM.new.add_amount(96).add_channels(6)

    [cpu, ram]
  end

  class RAM
    def add_amount(amm)
      @amount = amm
      self
    end

    def add_channels(chs)
      @num_of_channels = chs
      self
    end

    def write
      p "DDR4 2666MHz RAM with #{@amount} GB and #{@num_of_channels} channels"
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
    ram = RAM.new.add_amount(8).add_channels(2)

    [cpu, ram]
  end

  class RAM

    def add_amount(amm)
      @amount = amm
      self
    end

    def add_channels(chs)
      @num_of_channels = chs
      self
    end

    def write
      p "DDR3 1600MHz RAM with #{@amount} GB and #{@num_of_channels} channels"
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
    ram = RAM.new.add_amount(8).add_channels(4)

    [cpu, ram]
  end

  class RAM
    def add_amount(amm)
      @amount = amm
      self
    end

    def add_channels(chs)
      @num_of_channels = chs
      self
    end

    def write
      p "DDR4L 1600MHz RAM with #{@amount} GB and #{@num_of_channels} channels"
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

Application.new(EnergyEfficientComputerFactory)
