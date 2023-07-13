/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module startROM
(
		input [11:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 4030 addresses
logic [3:0] mem [0:4029];


//=======================================================
//  Memory Structure
//=======================================================
// 130x31 Sprites
// start purple


initial
begin
	 $readmemh("sprite_bytes/startROM.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule