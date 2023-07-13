/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module roadROM
(
		input [12:0] read_address,
		input Clk,
		output logic data_Out
);

// mem has width of 4 bits and a total of 5400 addresses
logic mem [0:5399];


//=======================================================
//  Memory Structure
//=======================================================
// 135x40 Sprites
// Road


initial
begin
	 $readmemb("sprite_bytes/roadROM.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule