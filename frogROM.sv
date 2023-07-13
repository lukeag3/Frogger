/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frogROM
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
// 40x40 Sprites
// UPFROG, UPJUMP, UPNUET, LEFTFROG, LEFTJUMP, LEFTNEUT
// LEFTCAR1, RIGHTCAR1, RIGHTCAR2


initial
begin
	 $readmemh("sprite_bytes/frogROM1.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule