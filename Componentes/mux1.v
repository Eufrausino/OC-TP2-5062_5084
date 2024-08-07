module mux1(clock, reset, control, endereco1, endereco2, saidaMux1);

    input wire clock;
    input wire reset;
    input wire control;
    input wire [31:0] endereco1;
    input wire [31:0] endereco2;

    output wire [31:0] saidaMux1;

    reg [31:0] saidaMux1_reg;
 
    always@(posedge clock) begin

        if(control == 1'b0)begin
            saidaMux1_reg = endereco1;
        end
        else begin
            saidaMux1_reg = endereco2;
        end
    end

    assign saidaMux1 = saidaMux1_reg;
endmodule