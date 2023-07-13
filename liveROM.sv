/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  liveROM
(
		input [9:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 576 addresses
logic [3:0] mem [0:575];


//=======================================================
//  Memory Structure
//=======================================================
// 24x24 Sprites

initial
begin
	 $readmemh("sprite_bytes/liveROM.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule