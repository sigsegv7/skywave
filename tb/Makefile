SV_FILES =				 	\
	../rtl/skywave.sv		\
	../rtl/cpu/pe.sv		\
	../rtl/uncore/rom.sv	\
	../rtl/uncore/busctl.sv

TB_FILES =				\
	test_core.cpp

.PHONY: all
all: obj vcd

.PHONY: obj
obj:
	verilator 				 \
		-Wall 				 \
		-DSKYWAVE_SIM		 \
		--trace 			 \
		-cc 				 \
		-I../hdl/inc		 \
		$(SV_FILES) 		 \
		--exe $(TB_FILES) 	 \
		--top-module skywave

.PHONY: vcd
vcd:
	make -C obj_dir/ -f Vskywave.mk Vskywave
	./obj_dir/Vskywave
