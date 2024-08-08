module control(clock, reset, opcode, branch, memRead, memtoReg, aluOp, memWrite, aluSrc, regWrite);
    input wire clock;
    input wire reset;
    input wire[6:0] opcode;
    
    output wire branch;
    output wire memRead;
    output wire memtoReg;
    output wire [1:0] aluOp;
    output wire memWrite;
    output wire aluSrc;
    output wire regWrite;

    reg [6:0] opcode_reg;
    reg branch_reg;
    reg memWrite_reg;
    reg aluSrc_reg;
    reg memRead_reg;
    reg memtoReg_reg;
    reg regWrite_reg;
    reg [1:0] aluOp_reg;

    reg[3:0] cont;
    
    always @(posedge clock) begin
        if(reset) begin
            cont <= 0;
            branch_reg <= 0;
            memRead_reg <= 0;
            memtoReg_reg <= 0;
            aluOp_reg <= 2'b00;
            memWrite_reg <= 0;
            aluSrc_reg <= 0;
            regWrite_reg <= 0;
        end
        else begin
            cont <= (cont+1)%10;
            if(cont%10 == 2) begin //1º teste
                // Tipo I:
                // opcode lb: 7'b0000011 
                if(opcode == 7'b0000011) begin
                    branch_reg <= 0;
                    memRead_reg <= 1;
                    memtoReg_reg <= 1;
                    aluOp_reg <= 2'b00;
                    memWrite_reg <= 0;
                    aluSrc_reg <= 1;
                    regWrite_reg <= 1;
                end

                    //opcode ori: 7'b0010011 
                if(opcode == 7'b0000011) begin
                    branch_reg <= 0;
                    memRead_reg <= 0;
                    memtoReg_reg <= 0;
                    aluOp_reg <= 2'b10;
                    memWrite_reg <= 0;
                    aluSrc_reg <= 1;
                    regWrite_reg <= 1;
                end

                //opcode Tipo S: 7'b0100011
                //sb
                else if(opcode == 7'b0100011) begin
                    branch_reg <= 0;
                    memRead_reg <= 0;
                    memtoReg_reg <= 0;
                    aluOp_reg <= 2'b00;
                    memWrite_reg <= 1;
                    aluSrc_reg <= 1;
                    regWrite_reg <= 0;
                end

                //opcode Tipo R: 7'b0110011
                // add, and, sll
                else if(opcode == 7'b0110011) begin
                    branch_reg <= 0;
                    memRead_reg <= 0;
                    memtoReg_reg <= 0;
                    aluOp_reg <= 2'b10;
                    memWrite_reg <= 0;
                    aluSrc_reg <= 0;
                    regWrite_reg <= 1;
                end

                //opcode Tipo SB: 7'b1100011
                //bne
                else if(opcode == 7'b1100011) begin
                    branch_reg <= 1;
                    memRead_reg <= 0;
                    memtoReg_reg <= 0;
                    aluOp_reg <= 2'b10;
                    memWrite_reg <= 0;
                    aluSrc_reg <= 0;
                    regWrite_reg <= 0;
                end
            end
        end
    end

    assign branch = branch_reg;
    assign memRead = memRead_reg;
    assign memtoReg = memtoReg_reg;
    assign aluOp = aluOp_reg;
    assign memWrite = memWrite_reg;
    assign aluSrc = aluSrc_reg;
    assign regWrite = regWrite_reg;
    
endmodule