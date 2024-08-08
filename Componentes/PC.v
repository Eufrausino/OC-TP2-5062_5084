module PC(
    input clock,
    input reset,
    input [31:0] prox_instrucao,
    output [31:0] estado_pc
);
    reg[31:0] endereco;
    
    reg [3:0] cont;
    // clock e reset para sincronização do circuito e para estado de inicialização do mesmo
    always @(posedge clock) begin
        cont = (cont + 1) % 10;
        if (reset) begin
            // Se reset for verdadeiro, então pc aponta para o endereço inicial 0x00000000
            cont = 0;
            endereco <= 32'b00000000000000000000000000000000;
        end 
        else begin
            // Do contrário, pc recebe o endereço da próxima instrução
            //cont = (cont + 1) % 10;
            if (cont % 10 == 0) begin
                endereco <= prox_instrucao;
            end
        end
    end
    assign estado_pc = endereco;
endmodule

