# The Skywave-A architecture reference manual

The scope of this manual is to describe the architecture mechanics for developers of system software and chip
designers.

## Terminology

```
Processing element)
    A processing element (PE) is a single processor core [unit of execution]
    consisting of its own register bank, ALU, control unit, etc.

Bootstrap PE)
    The bootstrap processing element is the first processing element to be brought
    up when the system is powered up.

PC inhibit line)
    Describes an electrical connection to a processing element that results in
    the program counter being held if set.
```

## Processor registers

```
NAME  ID     SIZE   Description
---------------------------------------
G0 : 0x00 : 64-bits  General
G1 : 0x01 : 64-bits  General
G2 : 0x02 : 64-bits  General
G3 : 0x03 : 64-bits  General
G4 : 0x04 : 64-bits  General
G5 : 0x05 : 64-bits  General
G6 : 0x06 : 64-bits  General
G7 : 0x07 : 64-bits  General
A0 : 0x08 : 64-bits  ABI-defined
A1 : 0x09 : 64-bits  ABI-defined
A2 : 0x0A : 64-bits  ABI-defined
A3 : 0x0B : 64-bits  ABI-defined
A4 : 0x0C : 64-bits  ABI-defined
A5 : 0x0D : 64-bits  ABI-defined
A6 : 0x0E : 64-bits  ABI-defined
A7 : 0x0F : 64-bits  ABI-defined
TT : 0x10 : 64-bits  Translation table
SP : 0x11 : 64-bits  Stack pointer
FP : 0x12 : 64-bits  Frame pointer
---------------------------------------
```

## Machine reset state

When the RESET# line is asserted, all general purpose and ABI registers are to be initialized to a value of
``0xAAAAAAAAAAAA``. The stack pointer, frame point and all control registers are to be initialized to a value
of zero.

## Platform memory map

```

START        END       Description
----------------------------------------------
0x000000   0x100000    Platform firmware ROM
----------------------------------------------
```

## Instruction encoding types

### A-type instructions

```
+------------------------+
| Opcode     Reserved    |
|  7:0        31:8       |
+------------------------+
```

### B-type instructions

```
+------------------------------+
| Opcode     Register   Imm    |
|  7:0        15:8      31:16  |
+------------------------------+
```

## Instruction listing

```
NAME       OPCODE    Description          TYPE
-------------------------------------------------------
NOP        0x00      No-operation         [A]
HLT        0x01      Halt processor       [A]
MOV        0x02      Move IMM to reg      [B]
RSVD       0x03      Reserved             [N/A]
ADD        0x04      Add IMM to reg       [B]
-------------------------------------------------------
```
