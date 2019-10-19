cdef extern from "src/testCl.cuh":
    cdef cppclass ClasePrueba:
        int val
        ClasePrueba(int,int) except +
        int mult()
        int getA()
        void setA(int)
    cdef cppclass ClaseArray:
        ClaseArray(np.float64_t*,int)

cdef class ArrayTest:
    cdef ClaseArray *a
    cdef int dimA
    #Se transforma el array proveniente de python, en un punto flotante. Y luego se ejecuta el contructor de C
    def __cinit__(self,np.ndarray[ndim=1, dtype=np.float64_t] arr):
        self.dimA=len(arr)
        self.a = new ClaseArray(&arr[0], self.dimA)

#Este es un ejemplo simple de entradas de int y salidas de los mismos, si la clase tiene contructor, el trabajo de definir una representacion en python se hace sencilla
cdef class PyTest:
    cdef ClasePrueba *c_test
    def __cinit__(self, int a, int b):
        self.c_test = new ClasePrueba(a,b)
    def __dealloc__(self):
        del self.c_test
    def get_mult(self):
        return self.c_test.mult()
    def py_getA(self):
        return self.c_test.getA()
    def py_setA(self,int a):
        self.c_test.setA(a)
