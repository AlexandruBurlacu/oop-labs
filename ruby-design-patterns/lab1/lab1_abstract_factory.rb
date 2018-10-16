class Storage
  def store
  end
end

class CPU
  def run
  end
end

class RAM
  def write
  end
end

###############################

class SSDStorage < Storage
  def store
    p "Storing shit fast"
  end
end

class HDDStorage < Storage
  def store
    p "Storing tons of shit slowly"
  end
end

class XPointStorage < Storage
  def store
    p "Feeling as a hipster"
  end
end

###############################

class IntelCPU < CPU
  def run  
    p "Being pseudo-innovative and bragging about More's law"
  end
end

class AMDCPU < CPU
  def run
    p "Being Intel's bitch, so that they don't get fucked for monopoly"
  end
end

class ARMCPU < CPU
  def run
    p "Doing some rad shit in computing efficiency"
  end
end

###############################

class DDR3RAM < RAM
  def write
    p "Who the fuck uses it anymore?"
  end
end

class DDR4RAM < RAM
  def write
    p "OK, nothing strange here"
  end
end

###############################

class ComputerFactory
  def makeStorage 
  end

  def makeCPU 
  end

  def makeRAM
  end
end

class HighEndComputerFactory < ComputerFactory
  def makeStorage 
    SSDStorage.new
  end

  def makeCPU 
    IntelCPU.new
  end

  def makeRAM
    DDR4RAM.new
  end
end

class LowBudgetComputerFactory < ComputerFactory
  def makeStorage 
    HDDStorage.new
  end

  def makeCPU 
    AMDCPU.new
  end

  def makeRAM
    DDR3RAM.new
  end
end

class EnergyEfficientComputerFactory < ComputerFactory
  def makeStorage 
    XPointStorage.new
  end

  def makeCPU 
    ARMCPU.new
  end

  def makeRAM
    DDR4RAM.new
  end
end

###############################

END {

  hp_comp = HighEndComputerFactory.new

  storage = hp_comp.makeStorage
  cpu = hp_comp.makeCPU
  ram = hp_comp.makeRAM

  p storage, cpu, ram

}

