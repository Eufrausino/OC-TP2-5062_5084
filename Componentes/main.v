`include "alu_control.v"
`include "alu.v"
`include "and.v"
`include "Control.v"
`include "data_memory.v"
`include "immgen.v"
`include "instruction_memory.v"
`include "mux1.v"
`include "mux2.v"
`include "mux3.v"
`include "PC.v"
`include "regs.v"
`include "somadorMux.v"
`include "somadorPC.v"


module main();

    reg clock;
    reg reset;
    reg [3:0] contador;

    // fios
    wire [31:0] fio_enderecoPc;
    wire [31:0] fio_enderecoPcSaida;
    wire [31:0] fio_enderecoProxInst;
    wire [31:0] fio_enderecoDesvio;
    wire [6:0 ] fio_instruction6_0;
    wire [4:0 ] fio_instruction19_15;
    wire [4:0 ] fio_instruction24_20;
    wire [4:0 ] fio_instruction11_7;
    wire [31:0] fio_instruction31_0;
    wire [2:0] fio_instruction14_12;
    wire [31:0] fio_imm;
    wire [6:0] fio_funct7;
    wire [31:0] fio_readData1;
    wire [31:0] fio_readData2;
    wire [31:0] fio_mux2Saida;
    wire [31:0] fio_aluResult;
    wire [31:0] fio_readData;
    wire [31:0] fio_mux3Saida;

    //fios controle
    wire fio_branch;
    wire fio_memRead;
    wire fio_memtoReg;
    wire fio_memWrite;
    wire fio_aluSrc;
    wire fio_regWrite;
    wire [1:0] fio_aluOp;
    wire [3:0] fio_aluCtrlSaida;
    wire fio_zero;
    wire fio_and;

    //chamando os módulos

    PC pc(.clock(clock), .reset(reset), .prox_instrucao(fio_enderecoPc), .estado_pc(fio_enderecoPcSaida));
    somadorPC somadorPc(.clock(clock), .reset(reset), .estado_pc(fio_enderecoPcSaida), .endereco_soma(fio_enderecoProxInst));
    instruction_memory instruction_memory(.clock(clock), .reset(reset), .readAddress(fio_enderecoPcSaida), .instruction6_0(fio_instruction6_0), .instruction19_15(fio_instruction19_15), .instruction24_20(fio_instruction24_20),
    .instruction11_7(fio_instruction11_7), .instruction31_0(fio_instruction31_0), .instruction14_12(fio_instruction14_12));
    immgen immgem(.clock(clock), .reset(reset), .instrucao(fio_instruction31_0), .imediatoGerado(fio_imm));
    control control(.clock(clock), .reset(reset), .opcode(fio_instruction6_0), .branch(fio_branch), .memRead(fio_memRead), .memtoReg(fio_memtoReg), .aluOp(fio_aluOp), .memWrite(fio_memWrite), .aluSrc(fio_aluSrc), .regWrite(fio_regWrite));
    regs regs(.clock(clock), .reset(reset), .regWrite(fio_regWrite), .readReg1(fio_instruction19_15), .readReg2(fio_instruction24_20), .writeReg(fio_instruction11_7), .writeData(fio_mux3Saida), .readData1(fio_readData1), .readData2(fio_readData2));
    somadorMux somadorMux(.clock(clock), .reset(reset), .estado_pc(fio_enderecoPcSaida), .imm_gen(fio_imm), .entrada_mux(fio_enderecoDesvio));
    alu_control alu_control(.clock(clock), .reset(reset), .aluOp(fio_aluOp), .funct3(fio_instruction14_12), .saidaAluControl(fio_aluCtrlSaida));
    mux2 mux2(.clock(clock), .reset(reset), .aluSrc(fio_aluSrc), .readData2(fio_readData2), .imm(fio_imm), .saidaMux2(fio_mux2Saida));
    alu alu(.clock(clock), .reset(reset), .aluControl(fio_aluCtrlSaida), .readData1(fio_readData1), .readData2(fio_mux2Saida), .aluResult(fio_aluResult), .zero(fio_zero));
    and_module and_module(.clock(clock), .reset(reset), .branch(fio_branch), .alu_0(fio_zero), .saidaAnd(fio_and));
    data_memory data_memory(.clock(clock), .reset(reset), .memWrite(fio_memWrite), .memRead(fio_memRead), .address(fio_aluResult), .writeData(fio_readData2), .readData(fio_readData));
    mux1 mux1(.clock(clock), .reset(reset), .control(fio_and), .endereco1(fio_enderecoProxInst), .endereco2(fio_enderecoDesvio), .saidaMux1(fio_enderecoPc));
    mux3 mux3(.clock(clock), .reset(reset), .memtoReg(fio_memtoReg), .readData(fio_readData), .aluResult(fio_aluResult), .saidaMux3(fio_mux3Saida));

    //bloco always

    always #1 clock <= ~clock; //clock alterna seu estado a cada 1 unidade de tempo

    always@(posedge clock) begin
		  if (!reset) contador = (contador+ 1) % 10; //quando reset não está ativo, incrementa o contador
	  end
    initial begin
		
		$dumpfile("main.vcd");
		$dumpvars;
		contador = 0;
		clock = 1'b0;
		reset = 1'b1;
		#10 reset = 1'b0; //depois de 10 uni de tempo reset é desativado
		
		#400
		$display(
				"Registrador [ 0] = %32b\n", regs.regs[0],
				"Registrador [ 1] = %32b\n", regs.regs[1],
				"Registrador [ 2] = %32b\n", regs.regs[2],
				"Registrador [ 3] = %32b\n", regs.regs[3],
				"Registrador [ 4] = %32b\n", regs.regs[4],
				"Registrador [ 5] = %32b\n", regs.regs[5],
				"Registrador [ 6] = %32b\n", regs.regs[6],
				"Registrador [ 7] = %32b\n", regs.regs[7],
				"Registrador [ 8] = %32b\n", regs.regs[8],
				"Registrador [ 9] = %32b\n", regs.regs[9],
				"Registrador [10] = %32b\n", regs.regs[10],
				"Registrador [11] = %32b\n", regs.regs[11],
				"Registrador [12] = %32b\n", regs.regs[12],
				"Registrador [13] = %32b\n", regs.regs[13],
				"Registrador [14] = %32b\n", regs.regs[14],
				"Registrador [15] = %32b\n", regs.regs[15],
				"Registrador [16] = %32b\n", regs.regs[16],
				"Registrador [17] = %32b\n", regs.regs[17],
				"Registrador [18] = %32b\n", regs.regs[18],
				"Registrador [19] = %32b\n", regs.regs[19],
				"Registrador [20] = %32b\n", regs.regs[20],
				"Registrador [21] = %32b\n", regs.regs[21],
				"Registrador [22] = %32b\n", regs.regs[22],
				"Registrador [23] = %32b\n", regs.regs[23],
				"Registrador [24] = %32b\n", regs.regs[24],
				"Registrador [25] = %32b\n", regs.regs[25],
				"Registrador [26] = %32b\n", regs.regs[26],
				"Registrador [27] = %32b\n", regs.regs[27],
				"Registrador [28] = %32b\n", regs.regs[28],
				"Registrador [29] = %32b\n", regs.regs[29],
				"Registrador [30] = %32b\n", regs.regs[30],
				"Registrador [31] = %32b\n", regs.regs[31]		
				);
		
		$finish;
	end


endmodule