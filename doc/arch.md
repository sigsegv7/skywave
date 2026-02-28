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

Uncore)
    The uncore is the region around the processing elements that is unrelated to
    instruction execution and used for implementing off-core components (i.e., bus fabric,
    OPI, etc).
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

## SoC uncore

The uncore region within the SoC is to contain off-core components unrelated to
instruction execution, this section describes the components within.

#### Bus control unit

The bus control unit is responsible for routing read/write operations to external or on-chip peripherals
(e.g., DDR, device registers, etc) using memory-mapped I/O (MMIO).

#### Uncore ROM

The uncore contains internal ROM used to store stage 1 platform firmware. This ROM is to be
as small as possible while remaining adequate for stage 1 firmware to perform early platform
initialization before jumping to a stage 2 trampoline.

#### Operator panel interface (OPI)

The operator panel interface is an uncore component responsible for managing I/O between an
external operator-panel and on-chip functionality.

#### Indicator taps (ITAP)

The OPI contains an indicator tap unit responsible for managing the connections between on-chip
functionality and external indicators such as LEDs or monitoring hardware.

#### Power-up contract unit (PUC)

The OPI contains a power-up contract unit responsible for sampling external capability pins and
latching them upon reset. Externally, a single element within the PUC is known as a "capability pin"
and is typically interfaced with by using physical jumpers. Internally, these signals are known as
"power-up contracts". All power-up contracts are to be immutable upon reset until the next reset.

## Capability pins

The board containing the SoC chip is to have external pins dedicated to configuring
SoC capabilities. These are referred to as capability pins. While they may alter on-chip
behavior, they are not to affect the instruction set architecture in any way. The mapping
of these pins are specific to the board and are listed in the board specific documentation
(see the ``doc/board`` directory).

```
PIN         MNEMONIC   PURPOSE
-----------------------------------------------------
CAP[0]      EOH#       Exception overflow halt enable
CAP[1]      ITAP#      Indicator tap enable
CAP[2]      RSVD       RESERVED
CAP[3]      RSVD       RESERVED
CAP[4]      RSVD       RESERVED
-----------------------------------------------------

MNEMONIC   BEHAVIOR
-------------------------------------------------------------
EOH#   :   If asserted, unhandled exceptions result in all
|          processing elements halting, otherwise reset.
|
ITAP#  :   If asserted, external indicators are to be driven
|          by on-chip logic, otherwise logically isolated.
|
-------------------------------------------------------------
```

## Machine reset state

When the RESET# line is asserted, all general purpose and ABI registers are to be initialized to a value of
``0xAAAAAAAAAAAA``. The stack pointer, frame point and all control registers are to be initialized to a value
of zero.

## Platform memory map

```

START        END       Description
----------------------------------------------
0x000000   0x002000    Platform firmware ROM
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
