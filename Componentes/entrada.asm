lb x2, 0(x10)
sb x2, 4(x0)
add x1, x2, x0
and x1, x1, x2
ori x1, x1, 0
sll x2, x2, x31
bne x1, x2, 10
add x1, x1, x1
sb x1, 4(x0)
ori x1, x1, 0
sb x1, 0(x0)
