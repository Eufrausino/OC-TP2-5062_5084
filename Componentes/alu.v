module alu(clock, reset, aluControl, readData1, readData2, aluResult, zero);
    input wire clock;
    input wire reset;
    input wire[3:0] aluControl;
    input wire[31:0] readData1;
    input wire[31:0] readData2;

    output wire[31:0] aluResult;
    output wire zero;

    reg[31:0] aluResult_reg;
    reg zero_reg;

    always@(posedge clock)begin
        if(aluControl == 4'b0010)begin
            aluResult_reg <= readData1 + readData2;
            zero_reg <= 1'b0;
        end
        if(aluControl == 4'b0000)begin
            aluResult_reg <= readData1 & readData2;
            zero_reg <= 1'b0;
        end
         if(aluControl == 4'b0001)begin
            aluResult_reg <= readData1 | readData2;
            zero_reg <= 1'b0;
        end
         if(aluControl == 4'b0110)begin
            aluResult_reg <= readData1 << readData2;
            zero_reg <= 1'b0;
        end
         if(aluControl == 4'b1000)begin
            aluResult_reg <= readData1 - readData2;
            zero_reg <= 1'b1;
        end
    end
    
    assign aluResult = aluResult_reg;
    assign zero = zero_reg;


endmodule