


; Unsigned_Selection_Sort.asm
; Author: Chris Mueller
; Student Number: 040884076
; Date:  March 28, 2020
; For Proc Arch Lab 10

        org     $1000
Elements        db      8,4,5,$0e,9,9,5,8,8,$0d
EndElements

LocationA       equ     EndElements+6   ;Location of A, the lowest value in the sub-array being search
LocationB       equ     EndElements+8   ;Location of B, the current search location
StartLocation   equ     Elements+10     ;Start of search location
EndLocation     equ     EndElements+12  ;End Location of the array. For some reason using #EndElements didn't want to work

STACK   equ     $2000
Start   lds     #STACK
        org     $2000

        ldy     #Elements
        sty     StartLocation   ;Assings the start location to the beginning of the Elements Array
        ldy     #EndElements
        sty     EndLocation     ;Same as above, but for the end of the Elements Array
        ;Beginning of the main loop. Sets up for the beginning of the comparision loop
StartBigLoop    ;Initilazes all the variables. Sets x to be the start location and y to be 1 further. Also sets the x and y in the Location A/B variables
        ldx     StartLocation
        ldy     StartLocation
        iny
        stx     LocationA
        sty     LocationB
        ldaa    0,x
        ldab    0,y

StartComparisonLoop     ;Beginning of the loop that compares the values to each other
        cpy     EndLocation
        beq     EndComparisonLoop
        cba     ;Compares A and B, if A is less than B it skips the SwitchVar label and increments y, then loops back up
        bhi     SwitchVar       ;Otherwise it goes down and sets A to B and saves the address, etc.
        iny              ;This is what happens if A is less than B
        sty     LocationB
        ldab    0,y
        bra     StartComparisonLoop

SwitchVar       ;Sets A to be the new lowest number, stores the location in LocationA and increments y to the next number to be compared
        sty     LocationA
        ldaa    0,y
        iny
        sty     LocationB
        ldab    0,y
        bra     StartComparisonLoop     ;End of loop to compare numbers
        
EndComparisonLoop       ;Swaps lowest value (a/x here) and current starting location (stored in b/y here)
        ldy     StartLocation
        ldx     LocationA
        ldab    0,y
        stab    0,x
        staa    0,y
        iny
        sty     StartLocation
        cpy     EndLocation     ;Compares the current start location to the end location. If they are the same, the sort is over and the program ends
        beq     End
        bra         StartBigLoop
        
        
End