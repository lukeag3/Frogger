/*

 frog.sv

 Handles the movement of the frog based on player interaction with keyboard

 */

module frog(input logic clk, Reset, right, HardReset, gameOver,
			input logic [9:0]  startX, startY,
			input logic [7:0]  keycode,
			input logic [3:0]  speed,
			output logic [9:0] frogX, frogY,
			output logic [2:0] direction,
			output logic	   home0, home1, home2, home3, home4, allHome
			);
				
   //=======================================================
   //  CLK Divider: Based on https://electronics.stackexchange.com/questions/267010/verilog-code-for-frequency-divider
   //=======================================================
   logic [19:0]				   divCnt;
   logic					   div_clk;
   always_ff @(posedge clk) begin
	  divCnt <= divCnt + 1;
	  if(divCnt == 500000-(50000*speed)) begin
		 divCnt <= 0;
		 div_clk <=!div_clk;
	  end
   end

   logic [9:0] Frog_X_Pos, Frog_Y_Pos, Frog_Size;
   logic [7:0] Prev_Keycode;
   logic [2:0] Prev_Direction;
   //Frog size -- needs to be updated
   assign Frog_Size = 35;
   //default starting point for frog
   parameter [9:0] Frog_X_Start=320;  // Center position on the X axis
   parameter [9:0] Frog_Y_Start=428;  // Center position on the Y axis
   //walls
   parameter [9:0] Frog_X_Min=74;       // Leftmost point on the X axis
   parameter [9:0] Frog_X_Max=594;     // Rightmost point on the X axis
   parameter [9:0] Frog_Y_Min=60;       // Topmost point on the Y axis
   parameter [9:0] Frog_Y_Max=439;     // Bottommost point on the Y axis
   logic		   home0a, home1a, home2a, home3a, home4a;

   always_ff @ (posedge HardReset or posedge gameOver or posedge home0a or posedge home1a
				or posedge home2a or posedge home3a or posedge home4a or posedge div_clk)
	 begin: homes
		if (HardReset || gameOver)
		  begin
			 home0 <= 0;
			 home1 <= 0;
			 home2 <= 0;
			 home3 <= 0;
			 home4 <= 0;
			 allHome <= 0;
		  end
		else if(home0a)
		  begin
			 home0 <= 1;
		  end
		else if(home1a)
		  begin
			 home1 <= 1;
		  end
		else if(home2a)
		  begin
			 home2 <= 1;
		  end
		else if(home3a)
		  begin
			 home3 <= 1;
		  end
		else if(home4a)
		  begin
			 home4 <= 1;
		  end
		else if (home0 == 1'b1 && home1 == 1'b1 && home2 == 1'b1 && home3 == 1'b1 && home4 == 1'b1)
		  begin
			 home0 <= 0;
			 home1 <= 0;
			 home2 <= 0;
			 home3 <= 0;
			 home4 <= 0;
			 allHome <= 1;
		  end
		else
		  begin
			 allHome <= 0;
		  end
	 end
   always_ff @ (posedge Reset or posedge div_clk)
	 begin: Move_Frog
        if (Reset)  // Asynchronous Reset
          begin
			 Frog_Y_Pos <= Frog_Y_Start; //may change to use startX, startY params
			 Frog_X_Pos <= Frog_X_Start;
			 Prev_Direction <= 3'b000;
			 home0a <= 0;
			 home1a <= 0;
			 home2a <= 0;
			 home3a <= 0;
			 home4a <= 0;
          end
		else if(keycode != Prev_Keycode)
		  begin
			 Prev_Keycode <= keycode;
			 case (keycode)
			   8'h04 : begin //A
				  if ( !((Frog_X_Pos - Frog_Size) <= Frog_X_Min) )
					begin
					   Frog_X_Pos <= Frog_X_Pos -1*Frog_Size;
					   direction <= 3'b010;
					   Prev_Direction <= 3'b010;
					end
			   end

			   8'h07 : begin //D
				  if ( !((Frog_X_Pos + Frog_Size) >= Frog_X_Max) )
					begin
					   Frog_X_Pos <= Frog_X_Pos + 1*Frog_Size;
					   direction <= 3'b110;
					   Prev_Direction <= 3'b110;
					end
			   end

							  
			   8'h16 : begin //S
				  if ( !((Frog_Y_Pos + Frog_Size) >= Frog_Y_Max ))
					begin
					   Frog_Y_Pos <= Frog_Y_Pos + 1*Frog_Size;
					   direction <= 3'b100;
					   Prev_Direction <= 3'b100;
					end
			   end

			   8'h1A : begin //W
				  if ( !((Frog_Y_Pos - Frog_Size) <= Frog_Y_Min ) )
					begin
					   Frog_Y_Pos <= Frog_Y_Pos -1*Frog_Size;
					   direction <= 3'b000;
					   Prev_Direction <= 3'b000;
					end
				  else if(Frog_X_Pos < 140 && Frog_X_Pos > 100 && home0 == 1'b0)
					begin
					   Frog_Y_Pos <= Frog_Y_Pos -1*Frog_Size;
					   direction <= 3'b000;
					   Prev_Direction <= 3'b000;
					   home0a <= 1'b1;
					end
				  else if(Frog_X_Pos < 250 && Frog_X_Pos > 210 && home1 == 1'b0)
					begin
					   Frog_Y_Pos <= Frog_Y_Pos -1*Frog_Size;
					   direction <= 3'b000;
					   Prev_Direction <= 3'b000;
					   home1a <= 1'b1;
					end
				  else if(Frog_X_Pos < 360 && Frog_X_Pos > 320 && home2 == 1'b0)
					begin
					   Frog_Y_Pos <= Frog_Y_Pos -1*Frog_Size;
					   direction <= 3'b000;
					   Prev_Direction <= 3'b000;
					   home2a <= 1'b1;
					end
				  else if(Frog_X_Pos < 470 && Frog_X_Pos > 430 && home3 == 1'b0)
					begin
					   Frog_Y_Pos <= Frog_Y_Pos -1*Frog_Size;
					   direction <= 3'b000;
					   Prev_Direction <= 3'b000;
					   home3a <= 1'b1;
					end
				  else if(Frog_X_Pos < 580 && Frog_X_Pos > 540 && home4 == 1'b0)
					begin
					   Frog_Y_Pos <= Frog_Y_Pos -1*Frog_Size;
					   direction <= 3'b000;
					   Prev_Direction <= 3'b000;
					   home4a <= 1'b1;
					end
			   end
			   default:;
			 endcase
		  end
		else if(speed)
		  begin
			 if (right == 1'b1) begin
				Frog_X_Pos <= Frog_X_Pos + 1;
			 end
			 else begin
				Frog_X_Pos <= Frog_X_Pos - 1;
			 end
			 direction <= Prev_Direction;
			 Prev_Direction <= Prev_Direction;
		  end
		else
		  begin
			 direction <= Prev_Direction;
			 Prev_Direction <= Prev_Direction;
		  end
     end
   assign frogX = Frog_X_Pos;
   assign frogY = Frog_Y_Pos;

endmodule
