module score_to_hex(input logic [15:0] score,
						  output logic [3:0] hex_num_4, hex_num_3, hex_num_2, hex_num_1, hex_num_0);
always_comb begin
		hex_num_0 <= score%10;
		hex_num_1 <= (score/10)%10;
		hex_num_2 <= (score/100)%10;
		hex_num_3 <= (score/1000)%10;
		hex_num_4 <= (score/10000)%10;
end
endmodule 