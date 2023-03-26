#include "static_lib_part1.h"
#include "dynamic_lib_part1.h"

int main()
{
#ifndef NO_EXPLICIT_DEPENDENCY
    static_part1_routine();
    dynamic_part1_routine();
#endif
}