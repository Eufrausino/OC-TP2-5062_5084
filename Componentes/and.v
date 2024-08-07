module and(input branch, input alu_0,
    input clock, input reset,
    output saidaAnd)

    //reg[3:0] cont;
   reg AND;
   always@(posedge clock or posedge reset) begin
    if(reset) begin//Se reset for 1, temos que a saída produzida será 0
        //cont <= 0;
        AND <= 1'b0;
    end 
    else begin
        //cont <= (cont + 1) % 10;
        //Do contrário, ocorrerá a operação lógica entre a entrada do sinal branch e saída 0 da ALU
        AND <= branch & alu_0;
    end
   end
   assign saidaAnd = AND;
endmodule