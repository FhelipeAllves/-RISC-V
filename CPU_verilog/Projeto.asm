init:
lb x1, 0xFF(x0) #Carrega a primeira entrada paralela no registrador 1
lb x2, 0xFF(x0) #Carrega a segunda entrada paralela no registrador 2

add x3, x1, x2
sub x4, x1, x2
mul x5, x1, x2
div x6, x1, x2

lb x7, 0xFF(x0) #Condição de parada
bne x7, x0, init