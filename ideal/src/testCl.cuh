#include <unistd.h>
//Lo ideal es que cada clase tenga su propio constructor, de esta forma es posible definirlos y tranformarlos en objetos python. 
//Asi operar de forma A=lib.ClasePrueba(1,2)
class ClasePrueba
{
public:
    ClasePrueba(int in,int en){
        this->A=in;
        this->B=en;
    };
    int mult(){
        int product=(this->A)*(this->B);
        return product;
    };
    int getA(){
        return this->A;
    }
    void setA(int i){
        this->A=i;
    }
private:
    int A;
    int B;
};
//Lo mas complejo de este trabajo es buscar el reemplazo para entradas y salidas que tiene C. Por ejemplo un puntero float en C no es lo mismo que un array en python
//En este caso en el archivo wrap se hace la conversion para que la funcion utilizable en python
//pueda resivir un array y transformarlo en un opuntero flotante de 1 dimension con me moria para flotantes.
class ClaseArray
{
public:
    ClaseArray(float* image_in, int i){
        this->image=image_in;
        this->val=i;
    }
private:
    float* image;
    int val;
}