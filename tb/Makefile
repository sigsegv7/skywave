SV_FILES =				 	\
	../rtl/skywave.sv		\
	../rtl/cpu/pe.sv		\
	../rtl/cpu/ctl.sv		\
	../rtl/uncore/rom.sv	\
	../rtl/uncore/busctl.sv

TB_FILES =				\
	test_core.cpp

.PHONY: all
all: rom obj vcd

.PHONY: rom
rom:
	rsync -avr ../firmware/*.mem .
	rsync -avr ../firmware/*.mem ../board/altera/5cseba6u23l7/

.PHONY: obj
obj:
	verilator 				 \
		-Wall 				 \
		-DSKYWAVE_SIM		 \
		--trace 			 \
		-cc 				 \
		-I../rtl/inc		 \
		$(SV_FILES) 		 \
		--exe $(TB_FILES) 	 \
		--top-module skywave

.PHONY: vcd
vcd:
	make -C obj_dir/ -f Vskywave.mk Vskywave
	./obj_dir/Vskywave
