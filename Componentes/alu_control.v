module alu_control(clock, reset, aluOp, funct3, saidaAluControl);
    input wire clock;
    input wire reset;
    input wire [1:0] aluOp;
    input wire [2:0] funct3;

    output wire [3:0] saidaAluControl;

    reg [2:0] funct3_reg;
    reg [3:0] alu_control_reg;

    always@(posedge clock)begin
        if(funct3 == 3'b000 | funct3 == 3'b111 | funct3 == 3'b110 | funct3 == 3'b001)begin
            funct3_reg <= funct3;
        end
        //lb e sb
        if(aluOp == 2'b00)begin
            alu_control_reg <= 4'b0010;
        end
        // bne
        else if(aluOp == 2'b01) begin
            alu_control_reg <= 4'b0110;
        end
        //add, and, ori, sll
        else if(aluOp == 2'b10) begin
            //add
            if(funct3_reg == 3'b000)begin
                alu_control_reg <= 4'b0010;
            end 
            //and
            if(funct3_reg == 3'b111)begin
                alu_control_reg <= 4'b0000;
            end 
            //ori
            if(funct3_reg == 3'b110)begin
                alu_control_reg <= 4'b0001;
            end 
            //sll
            if(funct3_reg == 3'b000)begin
                alu_control_reg <= 4'b0100;
            end 
        end   
    end 

    assign saidaAluControl = alu_control_reg;

endmodule