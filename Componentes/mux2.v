module mux2(clock, reset, aluSrc, readData2, imm, saidaMux2);
    input wire clock;
    input wire reset;
    input wire aluSrc;
    input wire [31:0] readData2;
    input wire [31:0] imm;

    output wire [31:0] saidaMux2;

    reg [31:0] saidaMux2_reg;
    reg[3:0] cont;

    always@(posedge clock) begin
        if(reset) begin
            cont <= 0;
            saidaMux2_reg <= 32'b00000000000000000000000000000000;
        end
        else begin
            cont <= (cont + 1) %10;
            if (cont % 10 == 4) begin
                if(aluSrc == 1'b0)begin
                    saidaMux2_reg <= readData2;
                end
                else begin
                    saidaMux2_reg <= imm;
                end
            end
        end
    end

    assign saidaMux2 = saidaMux2_reg;

endmodule