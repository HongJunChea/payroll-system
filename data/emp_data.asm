.MODEL SMALL
.STACK 100
.DATA

	TITLE DB 'Employee Details', 10, '$'
    LINE DB '================', 10, '$'
    LINE2 DB 'Name	  Job Type	  Hourly Wage/h	  Monthly Salary  EPF  SOCSO  EIS', 10, '$'
    LINE3 DB '====    ========    =============   ==============  ===  =====  ===', 10, '$'
    LINE4 DB 'Alice	  FT	      N/A	          $4500	           Y	 Y	   Y', 10, '$'
    LINE5 DB 'John	  FT	      N/A	          $4000	           Y	 Y	   Y', 10, '$'
    LINE6 DB 'Alex	  PT	      $8.50           N/A 	           N	 N	   N', 10, '$'
    LINE7 DB 'John	  PT	      $8.50	          N/A	           N	 N	   N', 10, '$'
    LINE8 DB 'Bob	  PT	      $8.50           N/A 	           N	 N	   N', 10, '$'
    LINE9 DB 'Smith	  FT	      N/A	          $3000	           Y	 Y	   Y', 10, '$'
    LINE10 DB 'David  FT	      N/A	          $4000	           Y	 Y	   Y', 10, '$'
    LINE11 DB 'Dany	  FT	      N/A	          $4000	           Y	 Y	   Y', 10, '$'
    LINE12 DB 'Emily  PT	      $8.50           N/A 	           N	 N	   N', 10, '$'
    LINE13 DB 'Eve	  PT	      $8.50           N/A 	           N	 N	   N', 10, '$'
    LINE14 DB 'Lee	  FT	      N/A	          $4500	           Y	 Y	   Y', 10, '$'
    LINE15 DB 'Jenny  FT	      N/A	          $4500	           Y	 Y	   Y', 10, '$'





.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
    PUTS TITLE
    PUTC 10
    PUTS LINE
    PUTC 10
    PUTS LINE2
    PUTC 10
    PUTS LINE3
    PUTC 10
    PUTS LINE4
    PUTC 10
    PUTS LINE5
    PUTC 10
    PUTS LINE6
    PUTC 10
    PUTS LINE7
    PUTC 10
    PUTS LINE8
    PUTC 10
    PUTS LINE9
    PUTC 10
    PUTS LINE10
    PUTC 10
    PUTS LINE11
    PUTC 10
    PUTS LINE12
    PUTC 10
    PUTS LINE13
    PUTC 10
    PUTS LINE14
    PUTC 10
    PUTS LINE15
    PUTC 10
	
	MOV AX,4C00H
	INT 21H
MAIN ENDP
END MAIN