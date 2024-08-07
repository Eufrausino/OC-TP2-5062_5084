module somadorPC(input[31:0] estado_pc,
input clock,
input reset,
output[31:0] endereco_soma)

    //reg [3:0] cont;
    reg[31:0] soma;
    always@(posedge clock or posedge reset) begin
      //cont = (cont+1)%10;
      if(reset) begin
        //cont <= 0;
        soma <= 32'b00000000000000000000000000000001;
      end

      else begin
        //if(cont % 10 == 1) begin
        soma <= estado_pc + 32'b00000000000000000000000000000001;
        //end
      end
    end
    assign endereco_soma = soma;   
endmodule