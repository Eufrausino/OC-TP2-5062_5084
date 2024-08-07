module immgen(
    input wire clock, 
    input wire reset, 
    input wire [31:0] instrucao, 
    output wire [31:0] imediatoGerado);

    reg [31:0] imm;

    always@(posedge clock or posedge reset) begin
        if(reset) begin
            imm <= 32'b00000000000000000000000000000000;
        end
        else begin
            if(instrucao[6:4] == 3'b000 || instrucao[6:4] == 3'b010 || instrucao[6:4] == 3'b110
            || instrucao[6:4] == 3'b001) begin
                if((instrucao[6:0] == 7'b0000011 & instrucao[14:12] == 3'b000) ||
                (instrucao[6:0] == 7'b0010011 & instrucao[14:12] == 3'b110)) begin
                    imm <= instrucao[31:20];
                end
                else if(instrucao[6:0] == 7'b0100011 & instrucao[14:12] == 3'b000) begin
                    imm <= {instrucao[31:25],instrucao[11:7]};
                end
                else if(instrucao[6:0] == 7'b1100011 & instrucao[14:12] == 3'b001) begin
                    imm <= {instrucao[31],instrucao[30:25],instrucao[11:8],instrucao[7]};
                end
            end
        end
    end
    assign imediatoGerado = imm;
endmodule