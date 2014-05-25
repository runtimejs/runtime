
ifndef ASL
ASL=../../../libraries/iasl
endif

SRCS=dsdt.asl     dsdt0.asl    dsdt1.asl    dsdt2.asl    gpev0000.asl \
     hdwr0015.asl hdwr0018.asl hdwr0019.asl hdwr0020.asl \
     hdwr0022.asl hndl0000.asl hndl0015.asl hndl0016.asl \
     hndl0038.asl hndl0115.asl init0030.asl init0032.asl init0034.asl \
     init0058.asl init0066.asl init0121.asl init1065.asl \
     nmsp0000.asl nmsp0010.asl nmsp0011.asl nmsp0012.asl \
     nmsp0013.asl nmsp0014.asl nmsp0015.asl nmsp0016.asl \
     nmsp0017.asl nmsp0018.asl nmsp0019.asl nmsp0020.asl \
     nmsp0021.asl nmsp0022.asl nmsp0023.asl nmsp0025.asl \
     nmsp0037.asl nmsp0038.asl nmsp0074.asl nmsp0089.asl \
     nmsp0126.asl rt0000.asl   rt0035.asl   rt0036.asl   ssdt1.asl \
     ssdt2.asl    init0059.asl tblm0037.asl tblm0047.asl\
	 tblm0058.asl hdwr0040.asl hdwr0041.asl

ASLFLAGS= -f

ALL : $(patsubst %.asl,%.aml,$(SRCS))
	@echo ASL compilation done!

%.aml :
	mkdir -p ../tmp/aml
	$(ASL) $(ASLFLAGS) $(subst .aml,.asl,$(@));\
	mv $(@) ../tmp/aml

clean : 
	rm -f $(patsubst %.asl,../tmp/aml/%.aml,$(SRCS))

