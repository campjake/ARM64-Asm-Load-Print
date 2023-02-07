// Programmer   : Jacob Campbell
// Lab #        : 5
// Purpose      : Loading and printing
// Date         : 2/2/2023

        .data

                iA:     .quad   100
                iB:     .quad   10000
                iC:     .quad   10000000
                iD:     .quad   10000000000
                szPlus: .asciz  " + "
                szEqual:.asciz  " = "
                szA:    .skip   21              // "100"
                szB:    .skip   21              // "10000"
                szC:    .skip   21              // "10000000"
                szD:    .skip   21              // "10000000000"
                dbSum:  .quad   0               // Signed int 10010010100
                szSum:  .skip   21              // "10010010100"
                chLF:   .byte   0xa             // Line feed

        .global _start
        .text

_start:
// 1) Convert 100 to ascii and store it at X11
        LDR     X0,=iA          // *X0 = iA
        LDR     X0, [X0]        // Dereference to get value
        LDR     X1,=szA         // *X1 = szA
        BL      int64asc        // String "100" is in X1

        MOV     X11, X1         // Save it at X11 for output

// 2) Convert 10000 to ascii and store it at X12
        LDR     X0,=iB          // *X0 = iB
        LDR     X0, [X0]        // Dereference to get value
        LDR     X1,=szB         // *X1 = szB
        BL      int64asc        // String "10000" is in X1

        MOV     X12, X1         // Save it at X12 for output

// 3) Convert 10000000 to ascii and store it at X13
        LDR     X0,=iC          // *X0 = iC
        LDR     X0, [X0]        // Dereference to get value
        LDR     X1,=szC         // *X1 = szC
        BL      int64asc        // String "10000000" is in X1

        MOV     X13, X1         // Save it at X13 for output

// 4) Convert 10000000000 to ascii and store it at X14
        LDR     X0,=iD          // *X0 = iC
        LDR     X0, [X0]        // Dereference to get value
        LDR     X1,=szD         // *X1 = szD
        BL      int64asc        // String "10000000000" is in X1

        MOV     X14, X1         // Save it at X14 for output

// 5) Add, convert, and store for output
        LDR     X0,=dbSum       // *X0 = 0
        LDR     X1,=iA          // *X1 = iA
        LDR     X1, [X1]
        LDR     X2,=iB          // *X2 = iB
        LDR     X2, [X2]

        ADD     X0, X1, X2      // X0 = 100 + 10000

        LDR     X1,=iC          // *X1 = iC
        LDR     X1, [X1]
        LDR     X2,=iD          // *X2 = iD
        LDR     X2, [X2]

        ADD     X0, X0, X1      // 10100 += 10000000
        ADD     X0, X0, X2      // 10010100 += 10000000000

        // Convert to ascii
        LDR     X1,=szSum       // String for fcn requirements
        BL      int64asc        // *X1 points to string "10010010100"

// 6) Output to terminal
        LDR     X0,=szA         // Print "100"
        BL      putstring

        LDR     X0,=szPlus      // Print " + "
        BL      putstring

        LDR     X0,=szB         // Print "10000"
        BL      putstring

        LDR     X0,=szPlus      // Print " + "
        BL      putstring

        LDR     X0,=szC         // Print "10000000"
        BL      putstring

        LDR     X0,=szPlus      // Print " + "
        BL      putstring

        LDR     X0,=szD         // Print "10000000000"
        BL      putstring

        LDR     X0,=szEqual     // Print " = "
        BL      putstring

        LDR     X0,=szSum       // Print "10010010100"
        BL      putstring

        LDR     X0,=chLF        // Line Feed
        BL      putch

// Setup parameters to exit program and call Linux to do it
        MOV     X0, #0          // Use return code 0
        MOV     X8, #93         // Service command code 93
		SVC     0               // Bye-bye :)