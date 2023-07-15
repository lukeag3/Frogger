module spriteROM #(parameter ADDR_WIDTH, DATA_WIDTH, FILE_NAME)
   (
    input [ADDR_WIDTH-1:0] read_address,
    input                  Clk,
    output logic [3:0]     data_Out
    );

   logic [3:0]             mem [0:DATA_WIDTH-1];
   // read file into memory
   initial
     begin
        $readmemh(FILE_NAME, mem);
     end
   // read data from memory
   always_ff @ (posedge Clk)
     begin
        data_Out <= mem[read_address];
     end
endmodule
