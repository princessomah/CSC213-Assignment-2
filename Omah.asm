.data
A_value:.asciiz "\nenter any number for (A):"
B_value:.asciiz "\nenter any number for (B):"
C_value:.asciiz "\nenter any number for (C):"
error_error:.asciiz "\nThis is a complex root, Sorry "
ans:.asciiz "\nThe value of X1 and X2 are:\n"
And:.asciiz "\nAnd\n"
value_of_two: .float 2.0
value_of_four: .float 4.0
checker:.float 0.0

.text
Starting_:
lwc1 $f1,value_of_two                   #$f1  holds 2.0
lwc1 $f2,value_of_four                  #$f2  holds 4.0
lwc1 $f3,checker       		  #$f3  holds 0.0 

la $a0,A_value                       #this is asking user for value of A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f4,$f0                       #A is held in $f4

la $a0,B_value                       #this is asking user to enter value of B
li $v0,4
syscall
li $v0,6
syscall
mov.s $f5,$f0                       #B is held in $f5

la $a0,C_value                       #this is asking user to enter value of C
li $v0,4
syscall
li $v0,6
syscall
mov.s $f6,$f0                       #C is held in $f6



mul.s $f7,$f5,$f5                  #$f7 = b^2
mul.s $f8,$f2,$f4                  #$f8 = 4*a
mul.s $f8,$f8,$f6                  #$f8 = 4*a*c
sub.s $f8,$f7,$f8                  #$f8 = d = b^2-4*a*c
mfc1 $t1,$f8                       #this copies the value in $f8 to $t1 in other for us to check if dis less than zero
mul.s $f1,$f1,$f4                  #$f1 holds 2*a
blez $t1,error              	   #tjis is checking if d is less than zero
sqrt.s $f10,$f8                    #$f10 holds the square root of d

#root solver                     
sub.s $f9,$f3,$f5                      #this is changing b to -b
add.s $f23,$f9,$f10                #-b+sqrt(d)
sub.s $f25,$f9,$f10                #-b-sqrt(d)

div.s $f24,$f23,$f1                #this divides -b+sqrtd by 2*a
div.s $f26,$f25,$f1                #this divides -b-sqrtd by 2*a
la $a0,ans
li $v0,4
syscall

mov.s $f12,$f24				#this prints out x1
li $v0,2
syscall

la $a0,And
li $v0,4
syscall

mov.s $f12,$f26				#this prints ot x2
li $v0,2
syscall

b exit

error:
la $a0,error_error  			# this prints out complex roots
li $v0,4
syscall

b exit
exit:
li $v0,10
syscall
