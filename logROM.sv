/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  logROM
(
		input [11:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 3200 addresses
logic [3:0] mem [0:3199];


//=======================================================
//  Memory Structure
//=======================================================
// 40x80 Sprite
// log


initial
begin
	 $readmemh("sprite_bytes/logROM.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule