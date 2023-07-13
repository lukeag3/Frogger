/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  titleROM
(
		input [15:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 57344 addresses
logic [3:0] mem [0:57343];


//=======================================================
//  Memory Structure
//=======================================================
// 224X256

initial
begin
	 $readmemh("sprite_bytes/titleROM.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule