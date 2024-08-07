module somadorMux(
    input [31:0] estado_pc,
    input [31:0] imm_gen,
    input clock,
    input reset,
    output reg [31:0] entrada_mux
);
    //reg[3:0] cont;
    reg[31:0] soma;
    always @(posedge clock or posedge reset) begin
        //cont = (cont + 7) % 10;
        if (reset) begin
            soma <= 32'b00000000000000000000000000000000;
            //cont <= 0;
        end 
        else begin
            //if(cont % 10 == 4) begin
            //Caso reset = 0, temos que a saída do somador será igual ao endereço atual de PC
            //somado ao deslocamente gerado pelo imediato. É dividido por 4 em função do deslocamento
            //Por exemplo, se imediato = 8, então, a saída do somador será PC + 2 deslocamentos
            soma <= estado_pc + (imm_gen/4);
            //end
        end
    end
    assign entrada_mux = soma;  
endmodule