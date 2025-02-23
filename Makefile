OBJS=metlib3.o oclablas.o ocnum.o gtp3.o matsmin.o lmdif1lib.o smp2.o pmon6.o  
EXE=oc4A
FF=gfortran
MAKE=make
RM=rm
ARLIB = ar
FFOPT = -fbounds-check  -finit-local-zero -fPIC

all:
	$(FF) -o linkoc linkocdate.F90
	./linkoc
	$(MAKE) $(EXE)


metlib3.o:	utilities/metlib3.F90
	$(FF) -c $(FFOPT) utilities/metlib3.F90

oclablas.o:	numlib/oclablas.F90
	$(FF) -c $(FFOPT) numlib/oclablas.F90

ocnum.o:	numlib/ocnum.F90
	$(FF) -c  $(FFOPT) numlib/ocnum.F90

lmdif1lib.o:      numlib/lmdif1lib.F90
	$(FF) -c  $(FFOPT) numlib/lmdif1lib.F90  

gtp3.o:	models/gtp3.F90
	$(FF) -c $(FFOPT) models/gtp3.F90

matsmin.o:	minimizer/matsmin.F90
	$(FF) -c $(FFOPT) minimizer/matsmin.F90

smp2.o:		stepmapplot/smp2.F90
	$(FF) -c $(FFOPT) stepmapplot/smp2.F90

pmon6.o:	userif/pmon6.F90
	$(FF) -c $(FFOPT) userif/pmon6.F90

 

$(EXE): 
	$(MAKE) $(OBJS)
# liboceq.a
	$(ARLIB) sq liboceq.a metlib3.o oclablas.o ocnum.o gtp3.o matsmin.o lmdif1lib.o 
# oc4A
	$(FF) -o $(EXE) -fbounds-check  pmain1.F90 pmon6.o smp2.o liboceq.a

clean:
	$(RM)  *.o *.mod linkoc liboceq.a oc4A  
