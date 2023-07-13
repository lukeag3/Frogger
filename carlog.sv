//-------------------------------------------------------------------------
//      carlog                                                   			 --
//      Luke Granger, Ben Thuma                                          --
//      11-09-2022                                                       --
// 	  For use with ECE 385 Final Project                     			 --
//      							                                              --
//-------------------------------------------------------------------------


module  carlog ( input Reset, frame_clk, Right, isLog,
					input [9:0] Car_X_Start, Car_Y_Start,
					input [3:0] Speed,
               output [9:0]  CarX, CarY);
					
    parameter [9:0] Car_X_Min=39;       // Leftmost point on the X axis
    parameter [9:0] Car_X_Max=599;     // Rightmost point on the X axis
	 
//=======================================================
//  CLK Divider for sprites: Based on https://electronics.stackexchange.com/questions/267010/verilog-code-for-frequency-divider
//=======================================================
	 logic[19:0] divCnt;
	 logic sprite_div_clk;
	 always_ff @(posedge frame_clk) begin
		divCnt <= divCnt + 1;
		if(divCnt == 500000-(50000*Speed)) begin
			divCnt <= 0;
			sprite_div_clk <=!sprite_div_clk;
		end
	 end
//=======================================================
//  Choose between car and log
//=======================================================
    always_comb begin
		if(isLog == 1'b1)
			Car_Size <= 80;
		else
			Car_Size <= 40;
	 end
//=======================================================
//  Position and movement
//======================================================= 
	logic [9:0] Car_X_Pos, Car_Y_Pos, Car_Size;
	
    always_ff @ (posedge Reset or posedge sprite_div_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
		  begin 
//				if(Right == 1'b1)
					Car_X_Pos <= Car_X_Start;
//				else
//					Car_X_Pos <= Car_X_Max;
        end           
        else 
        begin 
				if (Right == 1'b0 && (Car_X_Pos == 0)) begin  //Left edge
					  Car_X_Pos <= Car_X_Max + Car_Size;
				end
				else if (Right == 1'b1 && (Car_X_Pos >= (Car_X_Max + Car_Size))) begin  //Right edge
					  Car_X_Pos <= 0;
				end
				else if (Right == 1'b1) begin
					  Car_X_Pos <= Car_X_Pos + 1;
				end
				else begin
					  Car_X_Pos <= Car_X_Pos - 1;			
				end
			end	
    end
//=======================================================
//  Assign Outputs
//=======================================================     
    assign CarX = Car_X_Pos;
    assign CarY = Car_Y_Start;
endmodule 