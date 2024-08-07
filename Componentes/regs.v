module regs(input[5:0] readReg1,
 input[4:0] readReg2,
 input[4:0] writeReg,
 input[31:0] writeData,
 input regWrite,
 input clock, input reset,
 output[31:0] readData1,
 output[31:0] readData2)
    //Pegar o conteúdo do readReg e colocar em readData
    //Salvar writeData em algum dos regs

    //reg[3:0] cont;
    reg[31:0] regs [0:31];
    reg[4:0] rd;
    reg[4:0] r1;
    reg[4:0] r2;
    integer i;

    initial begin
        $readmemb("regs.bin",(regs));
    end

    always@(posedge clock or posedge reset) begin
        //cont = (cont + 1) % 10;
        //if (cont % 10 == 0) begin
            // if (regwrite == 1)
            //     regs[rd_reg] <= write_data;
        //end
        //Se regwrite está ativo, é possível atualizar os registradores
        if (regwrite == 1) begin regs[rd] <= writeData; end

        //Registrador de destino recebe a entrada respectiva entrada
        rd <= writeReg;
        //rs1 e rs2 recebem também suas respectivas entradas
        r1 <= regs[readReg1];
        r2 <= regs[readReg2];

        if(reset) begin
            //Se reset = 1, coloca os registradores no seu estado original.
            //Então, reg1 = 32'b00000000000000000000000000000001 e assim sucessivamente.
            //cont = 0;
            r1 <= 32'b00000000000000000000000000000000;
            r2 <= 32'b00000000000000000000000000000000;
            initial begin
                for(i = 0; i < 32; i = i + 1) begin
                    regs[i] = i;
                end
            end
        end
    end
    assign readData1 = r1;
    assign readData2 = r2;
endmodule