module(input[31:0] estado_pc,
input[31:0] imm_gen,
input clock,
input reset,
output[31:0] soma,
output carryOut)

    function [32:0] somador;//33 bits função do carry out
        input [31:0] a,b;
        reg [31:0] resultado, cin;
        integer i;
        resultado = 33b'0;
        cin = 32b'0;
        begin
            for(i = 0; i < 32; i = i + 1) begin
                if((a[i] == 1 & b[i] == 1)|(a[i]==1 & cin[i]==1)|(b[i]==1 & cin[i]==1))
                begin cin[i] = 1; end;//se há pelos 2 bits iguais a 1, carry in recebe 1
                resultado[i] = a[i] ^ b[i] ^ cin[i];
                resultado[i+1] = ((a[i]&b[i])|(a[i]&cin[i])|(b[i]&cin[i]));
            end;
            somador = resultado;
        end;
    endfunction;

    always@(posedge clock or posedge reset) begin
      if(reset) begin
        soma <= 0;
        carryOut <= 0;
      end

      else begin
        {carryOut,soma} = somador(estado_pc,imm_gen);//opera a função do somador completo
      end
    end
        
endmodule