#include <iostream>
#include <ctime>


int main(int argc, char const *argv[])
{
    /* code */
<<<<<<< HEAD
    std::string cadena = "end";
    unsigned t0,t1;
    t0=clock();
   bool var = cadena == "end" ;
    t1=clock();
    double time = (double(t1-t0)/CLOCKS_PER_SEC);
    std::cout << "Execution Time: " << time << " bool : " << var;
=======
    char letraE,letraN,letraD;
    std::string cadena= "end";
    unsigned t0,t1;
    t0=clock();
    if(cadena[0]=='e')
        if(cadena[1]=='n')
            if(cadena[2]=='d')
                std::cout << "end correcto";
    t1=clock();
    double time = (double(t1-t0)/CLOCKS_PER_SEC);
    std::cout << "Execution Time: " << time;
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
    return 0;
}
