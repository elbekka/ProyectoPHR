#include <iostream>
#include <ctime>


int main(int argc, char const *argv[])
{
    /* code */
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
    return 0;
}
