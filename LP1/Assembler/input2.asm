	START	100
A	DS	3
L1	MOVER	AREG	B
	ADD	AREG	C
	MOVEM	AREG	D
	MOVER	AREG	='10'
D	EQU	A+1
L2	PRINT	D
	ORIGIN	99
C	DC	'5'
	ORIGIN	107
	STOP
B	DC	'9'
	MOVER	AREG	='5'
	LTORG
	ADD	AREG	C
	MOVEM	AREG	D
	END	L1
	
