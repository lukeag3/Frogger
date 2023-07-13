module score(input logic clk, Reset, gameOver, allHome,
				 input logic [5:0] tim,
				 input logic [3:0] level,
				 output logic [15:0] score);
logic [3:0] prevLevel;
logic [5:0] prevTim;
always_ff @ (posedge Reset or posedge clk or posedge gameOver)
begin
        if (Reset || gameOver)  // Asynchronous Reset
        begin 
				prevLevel <= 0;
				score <= 0;
				prevTim <= 60;
        end
		  else if(level > prevLevel)
		  begin
				prevLevel <= level;
				score <= score + (level*50) + (prevTim*10);
				prevTim <= 60;
		  end
		  else if(allHome == 1'b1)
		  begin
				score <= score + 1000;
		  end
		  else if(tim < prevTim)
		  begin
				prevTim <= tim;
		  end
end
endmodule 