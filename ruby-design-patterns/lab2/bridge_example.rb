"""
  Check: https://medium.com/kkempin/bridge-design-pattern-in-ruby-5e0273f5a48e
  Check: https://medium.com/@dljerome/design-patterns-in-ruby-bridge-7aebb1b7bbc6
"""

require_relative 'visitor_example'

class ComputingDevice
	def initialize(implementation)
		@implementation = implementation
	end

	def run(visitor)
		raise NotImplementedError.new
	end
end

# Concrete Abstractions

class Mobile < ComputingDevice
	def run(visitor)
		sleep(3)
		@implementation.accept(visitor)
	end
end

class HomePCDevice < ComputingDevice
	def run(visitor)
		sleep(5)
		@implementation.accept(visitor)
	end
end

class AFuckinWorkstation < ComputingDevice
	def run(visitor)
		sleep(1)
		@implementation.accept(visitor)
	end
end

# Concrete Implementors

class Components
	include Visitable

	attr_reader :cpu, :gpu, :storage, :ram
end

class EnergyEfficientComponents < Components
	def initialize
		@cpu = "ARM CPU"
		@gpu = "Adreno GPU"
		@storage = "Micron SD"
		@ram = "6 LPDDR4"
	end
end

class LowBudgetComponents < Components
	def initialize
		@cpu = "AMD CPU"
		@gpu = "AMD GPU"
		@storage = "Samsung HDD"
		@ram = "16 DDR3"
	end
end

class HighEndComponents < Components
	def initialize
		@cpu = "Intel CPU"
		@gpu = "Nvidia GPU"
		@storage = "Samsung SSD"
		@ram = "64 DDR4"
	end
end

END {
	if __FILE__ == "bridge_example.rb"
		computing_device = Mobile.new(EnergyEfficientComponents.new)

		p computing_device.run EditSomePhotos.new
		p computing_device.run PlaySomeGames.new
		p computing_device.run ExplodeComputer.new
		p computing_device.run EvaluateForthExpression.new("+ - 12 2 / 54 2")
	end
}