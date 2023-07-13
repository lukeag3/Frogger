/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  timeROM
(
		input [8:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 272 addresses
logic [3:0] mem [0:271];


//=======================================================
//  Memory Structure
//=======================================================
// 34x8 Sprites

initial
begin
	 $readmemh("sprite_bytes/timeROM.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule