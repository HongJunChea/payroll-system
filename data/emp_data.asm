.MODEL SMALL
.STACK 100
.DATA

	TITLE DB 'Employee Details', 10, '$'
    LINE DB '================', 10, '$'

    LINE2 DB 'Name	  Job Type	  Hourly Wage/h	  Monthly Salary  EPF  SOCSO  EIS', 10, '$'
    LINE3 DB '====    ========    =============   ==============  ===  =====  ===', 10, '$'

    ARRAY DB 'Alice	  FT	      N/A	          $4500	           Y	 Y	   Y', 10, '$'
          DB 'John	  FT	      N/A	          $4000	           Y	 Y	   Y', 10, '$'
          DB 'Alex	  PT	      $8.50           N/A 	           N	 N	   N', 10, '$'
          DB 'John	  PT	      $8.50	          N/A	           N	 N	   N', 10, '$'
          DB 'Bob	  PT	      $8.50           N/A 	           N	 N	   N', 10, '$'
          DB 'Smith	  FT	      N/A	          $3000	           Y	 Y	   Y', 10, '$'
          DB 'David   FT	      N/A	          $4000	           Y	 Y	   Y', 10, '$'
          DB 'Dany	  FT	      N/A	          $4000	           Y	 Y	   Y', 10, '$'
          DB 'Emily   PT	      $8.50           N/A 	           N	 N	   N', 10, '$'
          DB 'Eve	  PT	      $8.50           N/A 	           N	 N	   N', 10, '$'
          DB 'Lee	  FT	      N/A	          $4500	           Y	 Y	   Y', 10, '$'
          DB 'Jenny   FT	      N/A	          $4500	           Y	 Y	   Y', 10, '$'

    EMP_COUNT DW 11
    BUFFER DB 80 DUP('$)





.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
    PUTS TITLE
    PUTS LINE
    PUTS LINE2
    PUTS LINE3
    
    MOV SI, OFFSET ARRAY
    MOV CX, EMP_COUNT

PRINT_EMP_DETAILS:
    MOV DX, SI
    MOV AH, 09H
    INT 21H

    ADD SI, 47 ; Move to next employee (length of each record including newline)
    LOOP PRINT_EMP_DETAILS

    
    

	
	MOV AX,4C00H
	INT 21H
MAIN ENDP
END MAIN