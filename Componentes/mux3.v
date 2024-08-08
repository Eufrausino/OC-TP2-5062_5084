module mux3(clock, reset, memtoReg, readData, aluResult, saidaMux3);

    input wire clock;
    input wire reset;
    input wire memtoReg;
    input wire [31:0] readData;
    input wire [31:0] aluResult;

    output wire [31:0] saidaMux3;

    reg [31:0] readData_reg;
    reg [31:0] aluResult_reg;
    reg [31:0] saidaMux3_reg;

    reg [3:0] cont;

    always@(posedge clock) begin
        cont = (cont + 1) % 10;
        readData_reg <= readData;
        aluResult_reg <= aluResult;
        if (cont % 10 == 5) begin
            if(memtoReg == 1'b1)begin
                saidaMux3_reg = readData_reg;
            end
            else begin
                saidaMux3_reg <= aluResult_reg;
            end
        end
        if(reset) begin
            cont <= 0;
            saidaMux3_reg <= 32'b00000000000000000000000000000000;
        end
    end

    assign saidaMux3 = saidaMux3_reg;

endmodule