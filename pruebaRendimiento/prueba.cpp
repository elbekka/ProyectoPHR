#include <iostream>
#include <ctime>


int main(int argc, char const *argv[])
{
    /* code */
    std::string cadena = "end";
    unsigned t0,t1;
    t0=clock();
   bool var = cadena == "end" ;
    t1=clock();
    double time = (double(t1-t0)/CLOCKS_PER_SEC);
    std::cout << "Execution Time: " << time << " bool : " << var;
    return 0;
}
