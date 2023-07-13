/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  victoryROM
(
		input [8:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 256 addresses
logic [3:0] mem [0:255];


//=======================================================
//  Memory Structure
//=======================================================
// 16x16 Sprite
// car


initial
begin
	 $readmemh("sprite_bytes/victoryROM.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule