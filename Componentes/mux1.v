module mux1(clock, reset, control, endereco1, endereco2, saidaMux1);

    input wire clock;
    input wire reset;
    input wire control;
    input wire [31:0] endereco1;
    input wire [31:0] endereco2;

    output wire [31:0] saidaMux1;

    reg [31:0] saidaMux1_reg;
    reg [3:0] cont;
 
    always@(posedge clock) begin
        cont = (cont + 1) % 10;
        if (cont % 10 == 4) begin
            if(control == 1'b0)begin
                saidaMux1_reg <= endereco1;
            end
            else begin
                saidaMux1_reg <= endereco2;
            end
        end
        if(reset) begin
            cont <= 0;
            saidaMux1_reg <= 32'b00000000000000000000000000000000;
        end
    end

    assign saidaMux1 = saidaMux1_reg;
endmodule