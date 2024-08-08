module and_module(
    input wire clock,
    input wire reset,
    input wire branch, 
    input wire alu_0,
    output wire saidaAnd
    );

    reg[3:0] cont;
    reg AND;
    always@(posedge clock or posedge reset) begin
        if(reset) begin//Se reset for 1, temos que a saída produzida será 0
            cont <= 0;
            AND <= 1'b0;
        end 
        else begin
            cont <= (cont + 1) % 10;
            //Do contrário, ocorrerá a operação lógica entre a entrada do sinal branch e saída 0 da ALU
            if(cont == 4) begin   
             AND <= branch & alu_0;
            end
        end
    end
   assign saidaAnd = AND;
endmodule