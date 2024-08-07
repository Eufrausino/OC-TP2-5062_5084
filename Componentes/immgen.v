module immgen(input[31:0] instrucao, input clock, input reset, output[11:0] imediatoGerado)
    reg[11:0] imm;
    always@(posedge clock or posedge reset) begin
        if(reset) begin
            imediatoGerado <= 11b'000000000000;
        end
        else begin
            if(instrucao[6:4] == 3'b000 or instrucao[6:4] == 3'b010 or instrucao[6:4] == 3'b110
            or instrucao[6:4] == 3'b001) begin
                if((instrucao[6:0] == 7'b0000011 and instrucao[14:12] == 3'000) or 
                (instrucao[6:0] == 7'b0010011 and instrucao[14:12] == 3'110)) begin
                    imm <= instrucao[31:20];
                end
                else if(instrucao[6:0] == 7'b0100011 and instrucao[14:12] == 3'000) begin
                    assign imm = {instrucao[31:25],instrucao[11:7]};
                end
                else if(instrucao[6:0] == 7'b1100011 and instrucao[14:12] == 3'001) begin
                    assign imm = {instrucao[31],instrucao[30:25],instrucao[11:8],instrucao[7]};
                end
            end
        end
    end
    assign imediatoGerado = imm;
endmodule