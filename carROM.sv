/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  carROM
(
		input [10:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 1600 addresses
logic [3:0] mem [0:1599];


//=======================================================
//  Memory Structure
//=======================================================
// 40x40 Sprite
// car


initial
begin
	 $readmemh("sprite_bytes/carROM.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule