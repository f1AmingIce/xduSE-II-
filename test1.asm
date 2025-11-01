_STACK SEGMENT STACK
    DB 100 DUP(?)
_STACK ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
    MSG1 DB 'PLEASE INPUT YOUR ID:$'
    MSG2 DB '23009201050$'
    MSG3 DB 'PLEASE INPUT YOUR NAME:$'
    MSG4 DB 'Wangzhaohan$'
    MSG5 DB 'PLEASE SHOW YOUR GIVEN STRING IN ASCII:$'
    MSG6 DB 'Camellia$'
    MSG7 DB 'PLEASE INPUT A CHAR:$'
    MSG8 DB 'ASCII:$'
    MSG9 DB 'THE ORIGINAL SRING IS:$'
    BUFFER DB '$'
_DATA ENDS

CODE SEGMENT PARA 'CODE'
ASSUME DS:_DATA,SS:_STACK,CS:CODE
START:
    MOV AX,_DATA
    MOV DS,AX
    MOV ES,AX;不知道这个有什么用
    
    ;显示自己的学号
    MOV AH,09H
    MOV DX,OFFSET MSG1
    INT 21H
    
    MOV AH,09H
    MOV DX,OFFSET MSG2
    INT 21H
    
    ;回车换行
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
   
    ;显示自己的姓名
    MOV AH,09H
    MOV DX,OFFSET MSG3
    INT 21H
    
    MOV AH,09H
    MOV DX,OFFSET MSG4
    INT 21H
    
    ;将指定数据区的字符串数据以ASCII码形式显示在屏幕上
    ;回车换行
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    
    MOV AH,09H
    MOV DX,OFFSET MSG5
    INT 21H
    
    ;回车换行
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    
    MOV AH,09H
    MOV DX,OFFSET MSG9
    INT 21H
    
    
    MOV AH,09H
    MOV DX,OFFSET MSG6
    INT 21H
    
    ;回车换行
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    
    MOV AH,09H
    MOV DX,OFFSET MSG8
    INT 21H
    
    MOV SI,OFFSET MSG6
PRINT_STRING:
    MOV AL,[SI]
    CMP AL,'$'
    JE PRINT_CHAR
    
    MOV BL,AL
    MOV BH,AL
    
    INC SI
    
    AND BL,0F0H  ;取高4位
    MOV CL,4    
    ;右移4位
    SHR BL,CL
    CMP BL,9
    ;比9大就是字符，跳转到CHAR1
    JA CHAR1_1
NUM1_1:
    ;高4位数字转换为ASCII码
    ADD BL,30H
    MOV DL,BL
    MOV AH,02H
    INT 21H
    JMP LOW4_1
CHAR1_1:
    ;高4位字符数字转换为ASCII码
    ADD BL,37H
    MOV DL,BL
    MOV AH,02H
    INT 21H
LOW4_1:
    ;取低4位
    AND BH,0FH
    CMP BH,9
    ;比9大就是字符，跳转到CHAR2
    JA CHAR2_1
NUM2_1:
    ;低4位数字转换为ASCII码
    ADD BH,30H
    MOV DL,BH
    MOV AH,02H
    INT 21H
    JMP PRINT_STRING ;循环判断
CHAR2_1:
    ADD BH,37H
    MOV DL,BH
    MOV AH,02H
    INT 21H
    JMP PRINT_STRING ;循环判断
    
    ;循环从键盘读入字符并回显在屏幕上，并显示出对应字符的ASCII，直到输入'Q'或'q'时结束
    
    
    
    
PRINT_CHAR:
    ;回车换行
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    
    ;显示提示输入字符串
    MOV AH,09H
    MOV DX,OFFSET MSG7
    INT 21H
    
    ;输入一个字符并回显
    MOV AH,01H
    MOV AL,00H
    INT 21H
    
    
    CMP AL,'q'
    ;若等于q，则跳转到ENDING
    JE ENDING
    ;若等于Q，则跳转到ENDING
    CMP AL,'Q'
    JE ENDING
    
    
    ;低8位BL
    MOV BL,AL
    ;高8位BH
    MOV BH,AL
    
    ;回车换行
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    
    MOV AH,09H
    MOV DX,OFFSET MSG8
    INT 21H
    
    AND BL,0F0H  ;取高4位
    MOV CL,4    
    ;右移4位
    SHR BL,CL
    CMP BL,9
    ;比9大就是字符，跳转到CHAR1
    JA CHAR1_2
NUM1_2:
    ;高4位数字转换为ASCII码
    ADD BL,30H
    MOV DL,BL
    MOV AH,02H
    INT 21H
    JMP LOW4_2
CHAR1_2:
    ;高4位字符数字转换为ASCII码
    ADD BL,37H
    MOV DL,BL
    MOV AH,02H
    INT 21H
LOW4_2:
    ;取低4位
    AND BH,0FH
    CMP BH,9
    ;比9大就是字符，跳转到CHAR2
    JA CHAR2_2
NUM2_2:
    ;低4位数字转换为ASCII码
    ADD BH,30H
    MOV DL,BH
    MOV AH,02H
    INT 21H
    JMP PRINT_CHAR ;循环判断
CHAR2_2:
    ADD BH,37H
    MOV DL,BH
    MOV AH,02H
    INT 21H
    JMP PRINT_CHAR ;循环判断
    
ENDING:
    ;回车换行
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    
    MOV AX,4C00H
    INT 21H
CODE ENDS
END START
