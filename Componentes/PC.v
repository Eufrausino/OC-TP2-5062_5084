module PC(input[31:0] prox_instrucao,
input clock,
input reset,
output reg[31:0] estado_pc)
    //clock e reset para sincronização do circuito e para estado de inicialização do mesmo
    always@(posedge clock or posedge reset) begin
    //Optei pela borda de subida por parecer ser mais intuitivo
      if(reset) begin estado_pc <= 32b'0 end;
      //Se reset for verdadeiro, então pc aponta para o endereço inicial 0x00000000
      else begin estado_pc <= prox_instrucao end;
      //Do contrário, pc recebe o endereço da próxima instrução
    end
    
endmodule
