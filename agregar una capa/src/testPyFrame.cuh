#include "frprmn.cuh"
#include "directioncosines.cuh"
#include <time.h>

//Otra solucion, con el fin de minizar los cambios existentes en gpuvmem, es agregar una "capa adicional" para externalizar sin los problemas de
//de incompatibilidad, ya sea por fuuncionalidades que no aplican en Python o Cython o por que simplemente no existe la api para cierto tipo de funciones (ej:decoradores __host__ __device__)
enum {MFS}; // Synthesizer
enum {Chi2, Entropy, Laplacian, QuadraticPenalization, TotalVariation, TotalSquaredVariation, L1Norm}; // Fi
enum {Gridding}; // Filter
enum {CG, LBFGS}; // Optimizator
enum {DefaultObjectiveFunction}; // ObjectiveFunction
enum {MS}; // Io
enum {SecondDerivative}; // Error calculation

//El problema de esto es que generaria clases python que obtienen sus funcionalidades de gpuvmem
//Esta seria la solucion más viable, la he podido probar en la generacion de clases con funciones de entradas y salidas basicas (int, etc)
//Solucionando los problemas del assembler deberia funcionar tecnicamente de esta froma. Pero debido a la gran cantidad de distintos formatos y tipos de datos de gpuvmem
//quizas podria fallar

//De esta forma lo ideal seria cambiar lso contructores de las clases de esta forma: agregando una capa instanciando el objeto
Synthesizer* synthPy(int i){
    Synthesizer* sy=Singleton<SynthesizerFactory>::Instance().CreateSynthesizer(i);
    return sy;
}
//Y las funciones con decoradores
void setDeviceCapaPy(){
    return __host__ virtual void setDevice() = 0;
}
//Cabe destacar que las funciones mostradas mas arriba, tienen que pertenecer a la declaracion de la clase, de otra forma en cython no existira una forma de bindear las funciones a la clase, es decir , al objeto
/*class Synthesizer{
    public:
        synthPy(int i){
        ..........
        }
        setDeviceCapaPy(){}
    private:
        //++++++++
}