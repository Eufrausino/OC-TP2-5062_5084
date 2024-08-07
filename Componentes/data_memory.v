module data_memory(clock, reset, memWrite, memRead, address, writeData, readData);
    input wire clock;
    input wire reset;
    input wire memWrite;
    input wire memRead;
    input wire[31:0] address;
    input wire[31:0] writeData;
    output wire[31:0] readData;

    reg[31:0] memoria[0:63];
    reg[31:0] readData_reg;

    initial begin
        $readmemb("data_memory.bin", (memoria));
    end

    always @(posedge clock) begin
        if(memWrite == 1'b1) begin
            memoria[address] <= writeData;
        end
        else if(memRead == 1'b1) begin
            readData_reg <= memoria[address];
        end
    end

    assign readData = readData_reg;

endmodule