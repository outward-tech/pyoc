REM 160926 Bo Sundman update
REM 151210 Mathias original

REM You must have compiled the OC software without parallelization
REM to obtain liboceq.a and liboceqplus.mod
REM These files are copied here together with
REM the F90 source library liboctq.F90 
REM liboctqisoc.F90 is the OC/TQ library that can be called from C++

REM The copy commands assume we are at 
REM TQ4lib/Cpp/isoC-matthias/ below OC
copy ..\..\..\liboceq.a .
copy ..\..\..\liboceqplus.mod .

REM This is the Fortran part of TQ library for C++
copy ..\liboctq.F90 .
gfortran -I.\ -c liboctq.F90

REM This the C++ TQ library which calls the F90 library
gfortran -I.\ -c liboctqisoc.F90

REM This is linking all together
g++ -o tqcpptest1 -lstdc++ tqcpptest1.cpp liboctqisoc.o liboctq.o liboceq.a -lgfortran -lm -lquadmath

