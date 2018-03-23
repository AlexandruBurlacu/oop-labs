from __future__ import print_function

class Stage(object):
    def __init__(self):
        self._next_stage = None

    def set_next_stage(self, next_st):
        self._next_stage = next_st

    def execute(self, data):
        return NotImplemented

class Input(Stage):
    def __init__(self):
        super(Input, self).__init__()

class Output(Stage):
    def __init__(self):
        super(Output, self).__init__()

class Transformation(Stage):
    def __init__(self):
        super(Transformation, self).__init__()
        self.data = None

    def get_data(self):
        return self.data

    def load_data(self, data):
        self.data = data

class StdinInput(Input):
    def __init__(self):
        super(StdinInput, self).__init__()

    def execute(self, data=None):
        # self._next_stage.load_data(data)
        while True:
            data = raw_input()
            self._next_stage.execute(data)

class StdoutOutput(Input):
    def __init__(self):
        super(StdoutOutput, self).__init__()

    def execute(self, data):
        # data = self._next_stage.get_data()
        print(data)

class UppercaseTransformation(Transformation):
    def __init__(self):
        super(UppercaseTransformation, self).__init__()

    def execute(self, data):
        # self.load_data(self.data.upper())
        self._next_stage.execute(data.upper())

if __name__ == "__main__":
    inp = StdinInput()
    out = StdoutOutput()
    tr1 = UppercaseTransformation()

    inp.set_next_stage(tr1)
    tr1.set_next_stage(out)

    inp.execute()

