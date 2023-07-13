module clock(input logic clk, Reset, gameEnd, gameStart,
				 input logic [3:0] level,
				 output logic [5:0] tim );

//=======================================================
//  CLK Divider: Based on https://electronics.stackexchange.com/questions/267010/verilog-code-for-frequency-divider
//=======================================================
	 logic[31:0] time_internal;
	 logic [3:0] prevLevel;
	 
    always_ff @ (posedge Reset or posedge clk)
	 begin: countdown
        if (Reset)  // Asynchronous Reset
        begin 
				time_internal <= 3000000000;
				prevLevel <= 0;
        end
		  else if(level > prevLevel)
		  begin
				prevLevel <= level;
				time_internal <= 3000000000;
		  end
		  else if (gameStart == 1'b0 || gameEnd == 1'b1)
		  begin
				time_internal <= 3000000000;
		  end
		  else
		  begin
				if(time_internal == 0)
				begin
					time_internal <= 32'b0;
				end
				else
				begin
				time_internal <= time_internal - 1;
				end
		  end
	end 
	assign tim = time_internal/50000000;
endmodule 