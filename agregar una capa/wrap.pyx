#Si la clase se define como el archivo en src, se pasarian por alto la conversion de datos y funcionalidades inexistentes en cython
cdef extern from "src/testPyFrame.cuh":
    cdef cppclass Synthesizer:
        Synthesizer* synthPy(int)
        void setDeviceCapaPy()
cdef class PySynth:
    cdef Synthesizer *sy
    def __cinit__(self):
        self.sy=synthPy()
    def py_setDevice(self):
        self.sy.setDeviceCapaPy()