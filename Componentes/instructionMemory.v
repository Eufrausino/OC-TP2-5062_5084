module instructionMemory(
    input[31:0] readAdress,
    input clock,
    input reset,
    output[31:0] instruction
)

    //clock e reset para sincronização do circuito e para estado de inicialização do mesmo
    always@(posedge clock or posedge reset) begin
    //Optei pela borda de subida por parecer ser mais intuitivo
      if(reset) begin instruction <= 32b'0 end;
      //Se reset for verdadeiro, então instrução aponta para o endereço 0x00000000
      else begin instruction <= readAdress end;
      //A memória de instrução coloca o endereço de pc para saída em 32 bits;
      //Optei por deixar em 32 bits para ser mais similar ao diagrama.
      //Os subvetores de bits de entrada para as entradas de outros componentes serão responsabilidades dos mesmos.
    end

endmodule