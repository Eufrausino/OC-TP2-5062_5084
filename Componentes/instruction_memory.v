module instruction_memory(clock, reset, readAddress, instruction6_0, instruction19_15, instruction24_20, instruction11_7, instruction31_0, instruction14_12);
    input wire clock;
    input wire reset;
    input wire [31:0] readAddress;

    output wire [6:0] instruction6_0;
    output wire [4:0] instruction19_15;
    output wire [4:0] instruction24_20;
    output wire [4:0] instruction11_7;
	output wire [31:0] instruction31_0;
    output wire [2:0] instruction14_12;


    reg [31:0] memoriaInstrucao [0: 10];
    reg [31:0] instrucao_reg;
    reg[3:0] cont;

    initial $readmemb("entrada.bin", (memoriaInstrucao));

    always@(posedge clock)begin
        cont = (cont+1)%10;
        if(cont == 1) begin
            instrucao_reg <= memoriaInstrucao[readAddress];
        end
        if(reset) begin
            cont <= 0;
            instrucao_reg <= 32'b00000000000000000000000000000000;
        end
    end

    assign instruction6_0 = instrucao_reg[6:0];
    assign instruction19_15 = instrucao_reg[19:15];
    assign instruction24_20 = instrucao_reg[24:20];
    assign instruction11_7 = instrucao_reg[11:7];
    assign instruction14_12 = instrucao_reg[14:12];
    assign instruction31_0 = instrucao_reg;

endmodule
