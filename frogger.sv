//-------------------------------------------------------------------------
//      frogger.sv                                             			 --
//      Luke Granger, Ben Thuma                                          --
//      11-09-2022                                                       --
// 	  For use with ECE 385 Final Project                     			 --
//      																						 --
//																								 --
//		  Handles the drawing, and gameplay of frogger 							 --
//-------------------------------------------------------------------------
module  frogger(
				input				CLK, MAX10_CLK1_50, ResetIn,
				input [9:0]			DrawX, DrawY,
				input logic [7:0]	keycode,
				input logic [9:0]	SW,
				output logic [7:0]	Red, Green, Blue,
				output logic [15:0]	score);
								
   logic							Reset;
   always_ff @ (posedge MAX10_CLK1_50 or posedge ResetIn or posedge ResetLevel )
	 begin
		if(ResetIn == 1'b1 || ResetLevel == 1'b1)
	 	  Reset <= 1'b1;
		else
		  Reset <= 1'b0;
	 end
   //=======================================================
   //  Game Start/End Controls
   //=======================================================
   logic gameStart;
   logic gameEnd;
   logic [7:0] Prev_Keycode;
   always_ff @ (posedge ResetIn or posedge MAX10_CLK1_50 )
     begin: GameSTARTend
        if (ResetIn)  // Asynchronous Reset
          begin
             Prev_Keycode <= 8'h00;
             gameStart <= 1'b0;
             gameEnd <= 1'b0;
          end
        else if(Lives == 3'b000 || tim <= 5'b00000)
          begin
             gameEnd <= 1'b1;
          end
		else if( SW[0] == 1'b1)
		  begin
			 gameStart <= 1'b1;
			 gameEnd <= 1'b0;
		  end
		//          else if(keycode != Prev_Keycode)
		//          begin
		//                Prev_Keycode <= keycode;
		//                case (keycode)
		//                    8'h28 : begin //ENTER - Start Game
		//                                    gameStart <= 1'b1;
		//                                    gameEnd <= 1'b0;
		//                              end
		//                    default:;
		//         endcase
		//        end
     end

   integer CAROFF, LOGOFF;
   assign CAROFF = 20;
   assign LOGOFF = 40;
   //=======================================================
   //  Log Positions
   //=======================================================
   int	   log0startX, log0startY,log1startX, log1startY,log2startX, log2startY,log3startX, log3startY, log4startX,log4startY;
   int	   log5startX, log5startY,log6startX, log6startY,log7startX, log7startY,log8startX, log8startY, log9startX,log9startY;
   int	   log10startX, log10startY,log11startX, log11startY,log12startX, log12startY,log13startX, log13startY, log14startX,log14startY;
   logic [9:0] log0_X, log0_Y, log1_X, log1_Y, log2_X, log2_Y, log3_X, log3_Y, log4_X, log4_Y;
   logic [9:0] log5_X, log5_Y, log6_X, log6_Y, log7_X, log7_Y, log8_X, log8_Y, log9_X, log9_Y;
   logic [9:0] log10_X, log10_Y, log11_X, log11_Y, log12_X, log12_Y, log13_X, log13_Y, log14_X, log14_Y;

   always_comb begin
	  log0startX <= log0_X - LOGOFF;
	  log0startY <= log0_Y - CAROFF;
	  log1startX <= log1_X - LOGOFF;
	  log1startY <= log1_Y - CAROFF;
	  log2startX <= log2_X - LOGOFF;
	  log2startY <= log2_Y - CAROFF;
	  log3startX <= log3_X - LOGOFF;
	  log3startY <= log3_Y - CAROFF;
	  log4startX <= log4_X - LOGOFF;
	  log4startY <= log4_Y - CAROFF;
	  log5startX <= log5_X - LOGOFF;
	  log5startY <= log5_Y - CAROFF;
	  log6startX <= log6_X - LOGOFF;
	  log6startY <= log6_Y - CAROFF;
	  log7startX <= log7_X - LOGOFF;
	  log7startY <= log7_Y - CAROFF;
	  log8startX <= log8_X - LOGOFF;
	  log8startY <= log8_Y - CAROFF;
	  log9startX <= log9_X - LOGOFF;
	  log9startY <= log9_Y - CAROFF;
	  log10startX <= log10_X - LOGOFF;
	  log10startY <= log10_Y - CAROFF;
	  log11startX <= log11_X - LOGOFF;
	  log11startY <= log11_Y - CAROFF;
	  log12startX <= log12_X - LOGOFF;
	  log12startY <= log12_Y - CAROFF;
	  log13startX <= log13_X - LOGOFF;
	  log13startY <= log13_Y - CAROFF;
	  log14startX <= log14_X - LOGOFF;
	  log14startY <= log14_Y - CAROFF;
   end
   //=======================================================
   //  Car Positions
   //=======================================================
   int car0startX, car0startY,car1startX, car1startY,car2startX, car2startY,car3startX, car3startY,car4startX, car4startY;
   int car5startX, car5startY,car6startX, car6startY,car7startX, car7startY,car8startX, car8startY,car9startX, car9startY;
   logic [9:0] Car0_X, Car0_Y, Car1_X, Car1_Y, Car2_X, Car2_Y, Car3_X, Car3_Y, Car4_X, Car4_Y;
   logic [9:0] Car5_X, Car5_Y, Car6_X, Car6_Y, Car7_X, Car7_Y, Car8_X, Car8_Y, Car9_X, Car9_Y;
   always_comb begin
	  car0startX <= Car0_X - CAROFF;
	  car0startY <= Car0_Y - CAROFF;
	  car1startX <= Car1_X - CAROFF;
	  car1startY <= Car1_Y - CAROFF;
	  car2startX <= Car2_X - CAROFF;
	  car2startY <= Car2_Y - CAROFF;
	  car3startX <= Car3_X - CAROFF;
	  car3startY <= Car3_Y - CAROFF;
	  car4startX <= Car4_X - CAROFF;
	  car4startY <= Car4_Y - CAROFF;
	  car5startX <= Car5_X - CAROFF;
	  car5startY <= Car5_Y - CAROFF;
	  car6startX <= Car6_X - CAROFF;
	  car6startY <= Car6_Y - CAROFF;
	  car7startX <= Car7_X - CAROFF;
	  car7startY <= Car7_Y - CAROFF;
	  car8startX <= Car8_X - CAROFF;
	  car8startY <= Car8_Y - CAROFF;
	  car9startX <= Car9_X - CAROFF;
	  car9startY <= Car9_Y - CAROFF;
   end
   //=======================================================
   //  Frog Collisions and Water Interaction
   //=======================================================
   logic Collision, Splash, log0mov, log1mov, log2mov, log3mov;
   always_ff @ (posedge MAX10_CLK1_50 or posedge Reset )
     begin
		if (Reset)
		  begin
			 Collision <= 1'b0;
			 Splash <= 1'b0;
			 log0mov <= 1'b0;
			 log1mov <= 1'b0;
			 log2mov <= 1'b0;
			 log3mov <= 1'b0;
		  end
		else if ((Frog_on == 1'b1) && ((Car0_on == 1'b1) || (Car1_on == 1'b1) || (Car2_on == 1'b1) || (Car3_on == 1'b1) ||
									   (Car4_on == 1'b1) || (Car5_on == 1'b1) || (Car6_on == 1'b1) || (Car5_on == 1'b1) ||
									   (Car6_on == 1'b1) || (Car7_on == 1'b1) || (Car8_on == 1'b1) || (Car9_on == 1'b1)) && (is_frog_transparent == 1'b0) &&
				 (is_car_transparent == 1'b0))
		  begin
             Collision <= 1'b1;
			 log0mov <= 1'b0;
			 log1mov <= 1'b0;
			 log2mov <= 1'b0;
			 log3mov <= 1'b0;
		  end
		else if((FrogY > 60 && FrogY < 200))
		  begin
			 if(Frog_on == 1'b1 && (is_frog_transparent == 1'b0) && !(log0_on == 1'b1 || log1_on == 1'b1 || log2_on == 1'b1 || log3_on == 1'b1 ||
																	  log4_on == 1'b1 || log5_on == 1'b1 || log6_on == 1'b1 || log7_on == 1'b1 ||
																	  log8_on == 1'b1 || log9_on == 1'b1 || log10_on == 1'b1 || log11_on == 1'b1 ||
																	  log12_on == 1'b1 || log13_on == 1'b1 || log14_on == 1'b1))
			   begin
				  Splash <= 1'b1;
				  log0mov <= 1'b0;
				  log1mov <= 1'b0;
				  log2mov <= 1'b0;
				  log3mov <= 1'b0;
			   end
			 else if((FrogX > 74 && FrogX < 594) && (Frog_on == 1'b1) && (log0_on == 1'b1 || log4_on == 1'b1 || log8_on == 1'b1) && (is_log_transparent == 1'b0))
			   begin
				  log0mov <= 1'b1;
				  log1mov <= 1'b0;
				  log2mov <= 1'b0;
				  log3mov <= 1'b0;
			   end
			 else if((FrogX > 74 && FrogX < 594) && (Frog_on == 1'b1) && (log1_on == 1'b1 || log5_on == 1'b1 || log9_on == 1'b1) && (is_log_transparent == 1'b0))
			   begin
				  log0mov <= 1'b0;
				  log1mov <= 1'b1;
				  log2mov <= 1'b0;
				  log3mov <= 1'b0;
			   end
			 else if((FrogX > 74 && FrogX < 594) && (Frog_on == 1'b1) && (log2_on == 1'b1 || log6_on == 1'b1 || log10_on == 1'b1) && (is_log_transparent == 1'b0))
			   begin
				  log0mov <= 1'b0;
				  log1mov <= 1'b0;
				  log2mov <= 1'b1;
				  log3mov <= 1'b0;
			   end
			 else if((FrogX > 74 && FrogX < 594) && (Frog_on == 1'b1) && (log3_on == 1'b1 || log7_on == 1'b1 || log11_on == 1'b1) && (is_log_transparent == 1'b0))
			   begin
				  log0mov <= 1'b0;
				  log1mov <= 1'b0;
				  log2mov <= 1'b0;
				  log3mov <= 1'b1;
			   end
			 else if(!(FrogX > 74 && FrogX < 594))
			   begin
				  log0mov <= 1'b0;
				  log1mov <= 1'b0;
				  log2mov <= 1'b0;
				  log3mov <= 1'b0;
			   end
		  end
		else 
		  begin
			 Collision <= 1'b0;
			 Splash <= 1'b0;
			 log0mov <= 1'b0;
			 log1mov <= 1'b0;
			 log2mov <= 1'b0;
			 log3mov <= 1'b0;
		  end
	 end
   //=======================================================
   //  Game Mechanics
   //=======================================================
   logic [3:0] Level, Lives;
   logic	   ResetLevel;
   always_ff @ (posedge MAX10_CLK1_50 or posedge ResetIn or posedge gameOver)
     begin
		if (ResetIn || gameOver)
		  begin
			 Level <= 0;
			 Lives <= 5;
			 ResetLevel <= 1;
		  end
		else if(FrogY < 60)
		  begin
			 Level <= Level + 1;
			 ResetLevel <= 1;
		  end
		else if(Collision == 1'b1 || Splash == 1'b1)
		  begin
			 Lives <= Lives - 1;
			ResetLevel <= 1;
		  end
		else
		  begin
			 ResetLevel <= 0;
		  end
	 end

   logic gameOver;
   always_ff @ (posedge MAX10_CLK1_50 or posedge gameEnd)
	 begin
		if (gameEnd)
		  begin
			 gameOver <= 1;
		  end
		else
		  begin
			 gameOver <= 0;
		  end
	 end
   //=======================================================
   //  Frog Movement on Logs
   //=======================================================
   always_ff @ (posedge MAX10_CLK1_50 or posedge Reset )
	 begin
		if (Reset)
		  begin
			 frogSpeed <= 4'b0000;
			 frogRight <= 1'b0;
		  end
		else if(log0mov == 1'b1)
		  begin
			 frogSpeed <= log0speed + Level;
			 frogRight <= 1'b1;
		  end
		else if(log1mov == 1'b1 )
		  begin
			 frogSpeed <= log1speed + Level;
			 frogRight <= 1'b0;
		  end
		else if(log2mov == 1'b1)
		  begin
			 frogSpeed <= log2speed + Level;
			 frogRight <= 1'b1;
		  end
		else if(log3mov == 1'b1)
		  begin
			 frogSpeed <= log3speed + Level;
			 frogRight <= 1'b0;
		  end
		else
		  begin
			 frogSpeed <= 4'b0000;
			 frogRight <= 1'b0;
		  end
	 end
   //=======================================================
   //  Initialize ROMs
   //=======================================================
   logic roadROM_out;
   logic [3:0] frogROM_out, carROM_out, logROM_out, backgroundROM_out, liveROM_out, timeROM_out, startROM_out, victROM_out;
   logic [11:0]	addr_read_frog;
   logic [11:0]	addr_read_car, addr_read_log, addr_read_start;
   logic [12:0]	roadROM_addr;
   logic [20:0]	addr_read_background;
   logic [9:0]	addr_read_live;
   logic [8:0]	addr_read_time, addr_read_vict;

   //spriteROM #(.ADDR_WIDTH(12), .DATA_WIDTH(4030), .FILE_NAME("sprite_bytes/startROM.txt"))frogROM fROM(.read_address(addr_read_frog), .Clk(CLK),.data_Out(frogROM_out));
   //spriteROM #(.ADDR_WIDTH(12), .DATA_WIDTH(4030), .FILE_NAME("sprite_bytes/startROM.txt"))carROM cROM(.*, .read_address(addr_read_car), .Clk(CLK), .data_Out(carROM_out));
   //spriteROM #(.ADDR_WIDTH(12), .DATA_WIDTH(4030), .FILE_NAME("sprite_bytes/startROM.txt"))logROM lrom(.*, .read_address(addr_read_log), .Clk(CLK), .data_Out(logROM_out));
   //spriteROM #(.ADDR_WIDTH(12), .DATA_WIDTH(4030), .FILE_NAME("sprite_bytes/startROM.txt"))titleROM trom(.*, .read_address(addr_read_title), .Clk(CLK), .data_Out(titleROM_out));
   //spriteROM #(.ADDR_WIDTH(12), .DATA_WIDTH(4030), .FILE_NAME("sprite_bytes/startROM.txt")) loseROM lorom(.*, .read_address(addr_read_lose), .Clk(CLK), .data_Out(loseROM_out));
   //spriteROM #(.ADDR_WIDTH(12), .DATA_WIDTH(4030), .FILE_NAME("sprite_bytes/startROM.txt")) liveROM lirom(.*, .read_address(addr_read_live), .Clk(CLK), .data_Out(liveROM_out));
   //spriteROM #(.ADDR_WIDTH(12), .DATA_WIDTH(4030), .FILE_NAME("sprite_bytes/startROM.txt")) timeROM tirom(.*, .read_address(addr_read_time), .Clk(CLK), .data_Out(timeROM_out));
   spriteROM #(.ADDR_WIDTH(17), .DATA_WIDTH(114688), .FILE_NAME("sprite_bytes/backgroundROM.txt"))
   backgroundROM(
				 .read_address(addr_read_background), .Clk(CLK), .data_Out(backgroundROM_out)
				 );
   //spriteROM #(.ADDR_WIDTH(12), .DATA_WIDTH(4030), .FILE_NAME("sprite_bytes/startROM.txt")) virom(.*, .read_address(addr_read_vict), .Clk(CLK), .data_Out(victROM_out));
   //=======================================================
   //  CLK Divider for sprites: Based on https://electronics.stackexchange.com/questions/267010/verilog-code-for-frequency-divider
   //=======================================================
   logic [19:0]	divCnt;
   logic		sprite_div_clk;
   always_ff @(posedge MAX10_CLK1_50) begin
	  divCnt <= divCnt + 1;
	  if(divCnt == 500000) begin
		 divCnt <= 0;
		 sprite_div_clk <=!sprite_div_clk;
	  end
   end
   //=======================================================
   //  Initialize clock and score
   //=======================================================
   logic [5:0] tim;
   clock clock0(.*,.clk(MAX10_CLK1_50), .Reset(ResetIn), .gameEnd(gameEnd), .gameStart(gameStart), .tim(tim), .level(Level));
   score score0(.*,.clk(MAX10_CLK1_50), .Reset(ResetIn), .gameOver(gameOver), .tim(tim), .level(Level), .score(score), .allHome(allHome));
   //=======================================================
   //  Initialize frog
   //=======================================================
   logic [9:0] FrogX, FrogY, Frog_size;
   logic [2:0] direction;
   logic [3:0] frogSpeed;
   logic	   allHome;
   logic	   frogRight, home0, home1, home2, home3, home4;
   frog f0(.*,.Reset(Reset), .clk(MAX10_CLK1_50), .keycode(keycode), .speed(frogSpeed), .right(frogRight), .HardReset(ResetIn),
           .startX(0), .startY(0), .frogX(FrogX), .frogY(FrogY), .direction(direction), .gameOver(gameOver),
           .home0(home0), .home1(home1), .home2(home2), .home3(home3), .home4(home4), .allHome(allHome));
   //=======================================================
   //  Initialize logs
   //=======================================================
   int		   log0speed, log1speed, log2speed, log3speed;
   assign log0speed = 1;
   assign log1speed = 3;
   assign log2speed = 2;
   assign log3speed = 4;
   //top line
   carlog log0(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(log0speed + Level),
			   .Car_Y_Start(80), .Car_X_Start(0), .CarX(log0_X), .CarY(log0_Y), .isLog(1'b1));
   carlog log4(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(log0speed + Level),
			   .Car_Y_Start(80), .Car_X_Start(180), .CarX(log4_X), .CarY(log4_Y), .isLog(1'b1));
   carlog log8(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(log0speed + Level),
			   .Car_Y_Start(80), .Car_X_Start(260), .CarX(log8_X), .CarY(log8_Y), .isLog(1'b1));
   //second line
   carlog log1(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(log1speed + Level),
			   .Car_Y_Start(115), .Car_X_Start(190), .CarX(log1_X), .CarY(log1_Y), .isLog(1'b1));
   carlog log5(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(log1speed + Level),
			   .Car_Y_Start(115), .Car_X_Start(0), .CarX(log5_X), .CarY(log5_Y), .isLog(1'b1));
   carlog log9(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(log1speed + Level),
			   .Car_Y_Start(115), .Car_X_Start(280), .CarX(log9_X), .CarY(log9_Y), .isLog(1'b1));
   //third line
   carlog log2(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(log2speed + Level),
			   .Car_Y_Start(150), .Car_X_Start(120), .CarX(log2_X), .CarY(log2_Y), .isLog(1'b1));
   carlog log6(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(log2speed + Level),
			   .Car_Y_Start(150), .Car_X_Start(0), .CarX(log6_X), .CarY(log6_Y), .isLog(1'b1));
   carlog log10(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(log2speed + Level),
				.Car_Y_Start(150), .Car_X_Start(230), .CarX(log10_X), .CarY(log10_Y), .isLog(1'b1));
   //fourth line
   carlog log3(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(log3speed + Level),
			   .Car_Y_Start(185), .Car_X_Start(0), .CarX(log3_X), .CarY(log3_Y), .isLog(1'b1));
   carlog log7(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(log3speed + Level),
			   .Car_Y_Start(185), .Car_X_Start(110), .CarX(log7_X), .CarY(log7_Y), .isLog(1'b1));
   carlog log11(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(log3speed + Level),
				.Car_Y_Start(185), .Car_X_Start(240), .CarX(log11_X), .CarY(log11_Y), .isLog(1'b1));
   //	carlog log12(.Reset(Reset), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(log3speed),
   //				.Car_Y_Start(185), .Car_X_Start(400), .CarX(log12_X), .CarY(log12_Y), .isLog(1'b1));
   //=======================================================
   //  Initialize cars
   //=======================================================
   //top line
   carlog car0(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(3 + Level),
			   .Car_Y_Start(255), .Car_X_Start(45), .CarX(Car0_X), .CarY(Car0_Y), .isLog(1'b0));
   carlog car5(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(3 + Level),
			   .Car_Y_Start(255), .Car_X_Start(280), .CarX(Car5_X), .CarY(Car5_Y), .isLog(1'b0));
   //second line
   carlog car1(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(2 + Level),
			   .Car_Y_Start(290), .Car_X_Start(0), .CarX(Car1_X), .CarY(Car1_Y), .isLog(1'b0));
   carlog car6(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(2 + Level),
			   .Car_Y_Start(290), .Car_X_Start(130), .CarX(Car6_X), .CarY(Car6_Y), .isLog(1'b0));
   //third line
   carlog car2(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(1 + Level),
			   .Car_Y_Start(325), .Car_X_Start(20), .CarX(Car2_X), .CarY(Car2_Y), .isLog(1'b0));
   carlog car7(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(1 + Level),
			   .Car_Y_Start(325), .Car_X_Start(217), .CarX(Car7_X), .CarY(Car7_Y), .isLog(1'b0));
   //fourth line
   carlog car3(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(3 + Level),
			   .Car_Y_Start(360), .Car_X_Start(78), .CarX(Car3_X), .CarY(Car3_Y), .isLog(1'b0));
   carlog car8(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b1), .Speed(3 + Level),
			   .Car_Y_Start(360), .Car_X_Start(300), .CarX(Car8_X), .CarY(Car8_Y), .isLog(1'b0));
   //fifth line
   carlog car4(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(2 + Level),
			   .Car_Y_Start(395), .Car_X_Start(22), .CarX(Car4_X), .CarY(Car4_Y), .isLog(1'b0));
   carlog car9(.Reset(ResetIn), .frame_clk(MAX10_CLK1_50), .Right(1'b0), .Speed(2 + Level),
			   .Car_Y_Start(395), .Car_X_Start(199), .CarX(Car9_X), .CarY(Car9_Y), .isLog(1'b0));

   //=======================================================
   //  Convert ROMdata to colors
   //=======================================================
   logic	   is_frog__transparent, is_car_transparent, is_log_transparent, is_vict_transparent; //active high
   logic [7:0] car_red, car_green, car_blue, frog_red, frog_green, frog_blue, log_red, log_green,
			   log_blue, title_red, title_blue, title_green, lose_red, lose_blue, lose_green,
			   live_blue, live_red, live_green, time_red, time_blue, time_green,
			   start_blue, start_green, start_red, vict_red, vict_green, vict_blue;

   palette_to_rgb rgbfrogs(.palette(frogROM_out), .transparent(is_frog_transparent),
						   .red(frog_red), .green(frog_green), .blue(frog_blue));
   palette_to_rgb rgbcars(.palette(carROM_out), .transparent(is_car_transparent),
						  .red(car_red), .green(car_green), .blue(car_blue));
   palette_to_rgb rgblogs(.palette(logROM_out), .transparent(is_log_transparent),
						  .red(log_red), .green(log_green), .blue(log_blue));
   palette_to_rgb rgbtitle(.palette(backgroundROM_out), .transparent(),
						   .red(title_red), .green(title_green), .blue(title_blue));
   palette_to_rgb rgblose(.palette(backgroundROM_out), .transparent(),
						  .red(lose_red), .green(lose_green), .blue(lose_blue));
   palette_to_rgb rgblive(.palette(liveROM_out), .transparent(),
						  .red(live_red), .green(live_green), .blue(live_blue));
   palette_to_rgb rgbtime(.palette(timeROM_out), .transparent(),
						  .red(time_red), .green(time_green), .blue(time_blue));
   palette_to_rgb rgbstart(.palette(startROM_out), .transparent(),
						   .red(start_red), .green(start_green), .blue(start_blue));
   palette_to_rgb rgbvict(.palette(victROM_out), .transparent(is_vict_transparent),
						  .red(vict_red), .green(vict_green), .blue(vict_blue));
   //=======================================================
   //  Frog Drawing Determination
   //=======================================================
   logic	   Frog_on;
   integer	   FROGOFF;
   assign FROGOFF = 20;
   int		   startX, startY;
   assign startX = FrogX - FROGOFF;
   assign startY = FrogY - FROGOFF;
   always_comb
     begin:Frog_on_proc
        if ((DrawX > (FrogX - FROGOFF)) && (DrawX < (FrogX + FROGOFF)) && (DrawY > (FrogY - FROGOFF)) && (DrawY < (FrogY + FROGOFF))) begin
           Frog_on <= 1'b1;
		   case(direction)
			 3'b000:
			   addr_read_frog <= ((DrawX-startX) + (DrawY-startY)*40);
			 3'b001:
			   addr_read_frog <= ((DrawX-startX) + (DrawY-startY)*40);
			 3'b010:
			   addr_read_frog <= ((DrawX-startX) + (DrawY-startY)*40)+1600;
			 3'b011:
			   addr_read_frog <= ((DrawX-startX) + (DrawY-startY)*40)+1600;
			 3'b100:
			   addr_read_frog <= ((DrawX-startX) + (39-(DrawY-startY))*40);
			 3'b101:
			   addr_read_frog <= ((DrawX-startX) + (39-(DrawY-startY))*40);
			 3'b110:
			   addr_read_frog <= (39-(DrawX-startX) + (DrawY-startY)*40)+1600;
			 3'b111:
			   addr_read_frog <= (39-(DrawX-startX) + (DrawY-startY)*40)+1600;
		   endcase
		end
        else 
		  begin
             Frog_on <= 1'b0;
			 addr_read_frog <= 0;
		  end
     end
   //=======================================================
   //  Car Drawing Determination
   //=======================================================
   logic Car0_on, Car1_on, Car2_on, Car3_on, Car4_on, Car5_on, Car6_on, Car7_on, Car8_on, Car9_on;
   always_comb
	 begin:Car_on_proc
		if ((DrawX > (Car0_X - CAROFF)) && (DrawX < (Car0_X + CAROFF)) && (DrawY > (Car0_Y - CAROFF)) && (DrawY < (Car0_Y + CAROFF))) begin
		   addr_read_car <= ((DrawX-car0startX) + (DrawY-car0startY)*40);
		   Car0_on <= 1'b1;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		end
		else if ((DrawX > (Car1_X - CAROFF)) && (DrawX < (Car1_X + CAROFF)) && (DrawY > (Car1_Y - CAROFF)) && (DrawY < (Car1_Y + CAROFF))) begin
		   addr_read_car <= (39-(DrawX-car1startX) + (DrawY-car1startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b1;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		end
		else if ((DrawX > (Car2_X - CAROFF)) && (DrawX < (Car2_X + CAROFF)) && (DrawY > (Car2_Y - CAROFF)) && (DrawY < (Car2_Y + CAROFF))) begin
		   addr_read_car <= (39-(DrawX-car2startX) + (DrawY-car2startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b1;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		end
		else if ((DrawX > (Car3_X - CAROFF)) && (DrawX < (Car3_X + CAROFF)) && (DrawY > (Car3_Y - CAROFF)) && (DrawY < (Car3_Y + CAROFF))) begin
		   addr_read_car <= ((DrawX-car3startX) + (DrawY-car3startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b1;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		end
		else if ((DrawX > (Car4_X - CAROFF)) && (DrawX < (Car4_X + CAROFF)) && (DrawY > (Car4_Y - CAROFF)) && (DrawY < (Car4_Y + CAROFF))) begin
		   addr_read_car <= (39-(DrawX-car4startX) + (DrawY-car4startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b1;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		end
		else if ((DrawX > (Car5_X - CAROFF)) && (DrawX < (Car5_X + CAROFF)) && (DrawY > (Car5_Y - CAROFF)) && (DrawY < (Car5_Y + CAROFF))) begin
		   addr_read_car <= ((DrawX-car5startX) + (DrawY-car5startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b1;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		end
		else if ((DrawX > (Car6_X - CAROFF)) && (DrawX < (Car6_X + CAROFF)) && (DrawY > (Car6_Y - CAROFF)) && (DrawY < (Car6_Y + CAROFF))) begin
		   addr_read_car <= (39-(DrawX-car6startX) + (DrawY-car6startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b1;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		end
		else if ((DrawX > (Car7_X - CAROFF)) && (DrawX < (Car7_X + CAROFF)) && (DrawY > (Car7_Y - CAROFF)) && (DrawY < (Car7_Y + CAROFF))) begin
		   addr_read_car <= (39-(DrawX-car7startX) + (DrawY-car7startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b1;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		  end
		else if ((DrawX > (Car8_X - CAROFF)) && (DrawX < (Car8_X + CAROFF)) && (DrawY > (Car8_Y - CAROFF)) && (DrawY < (Car8_Y + CAROFF))) begin
		   addr_read_car <= ((DrawX-car8startX) + (DrawY-car8startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b1;
		   Car9_on <= 1'b0;
		end
		else if ((DrawX > (Car9_X - CAROFF)) && (DrawX < (Car9_X + CAROFF)) && (DrawY > (Car9_Y - CAROFF)) && (DrawY < (Car9_Y + CAROFF))) begin
		   addr_read_car <= (39-(DrawX-car9startX) + (DrawY-car9startY)*40);
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b1;
		end
		else begin
		   addr_read_car <= 0;
		   Car0_on <= 1'b0;
		   Car1_on <= 1'b0;
		   Car2_on <= 1'b0;
		   Car3_on <= 1'b0;
		   Car4_on <= 1'b0;
		   Car5_on <= 1'b0;
		   Car6_on <= 1'b0;
		   Car7_on <= 1'b0;
		   Car8_on <= 1'b0;
		   Car9_on <= 1'b0;
		end
		
	 end
   //=======================================================
   //  log Drawing Determination
   //=======================================================
   logic log0_on, log1_on, log2_on, log3_on, log4_on, log5_on, log6_on, log7_on, log8_on, log9_on, log10_on, log11_on, log12_on, log13_on, log14_on;
   always_comb
	 begin:log_on_proc
		if ((DrawX > (log0_X - LOGOFF)) && (DrawX < (log0_X + LOGOFF)) && (DrawY > (log0_Y - CAROFF)) && (DrawY < (log0_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log0startX) + (DrawY-log0startY)*80);
		   log0_on <= 1'b1;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		  end
		else if ((DrawX > (log1_X - LOGOFF)) && (DrawX < (log1_X + LOGOFF)) && (DrawY > (log1_Y - CAROFF)) && (DrawY < (log1_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log1startX) + (DrawY-log1startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b1;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log2_X - LOGOFF)) && (DrawX < (log2_X + LOGOFF)) && (DrawY > (log2_Y - CAROFF)) && (DrawY < (log2_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log2startX) + (DrawY-log2startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b1;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log3_X - LOGOFF)) && (DrawX < (log3_X + LOGOFF)) && (DrawY > (log3_Y - CAROFF)) && (DrawY < (log3_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log3startX) + (DrawY-log3startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b1;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log4_X - LOGOFF)) && (DrawX < (log4_X + LOGOFF)) && (DrawY > (log4_Y - CAROFF)) && (DrawY < (log4_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log4startX) + (DrawY-log4startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b1;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log5_X - LOGOFF)) && (DrawX < (log5_X + LOGOFF)) && (DrawY > (log5_Y - CAROFF)) && (DrawY < (log5_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log5startX) + (DrawY-log5startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b1;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log6_X - LOGOFF)) && (DrawX < (log6_X + LOGOFF)) && (DrawY > (log6_Y - CAROFF)) && (DrawY < (log6_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log6startX) + (DrawY-log6startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b1;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log7_X - LOGOFF)) && (DrawX < (log7_X + LOGOFF)) && (DrawY > (log7_Y - CAROFF)) && (DrawY < (log7_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log7startX) + (DrawY-log7startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b1;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log8_X - LOGOFF)) && (DrawX < (log8_X + LOGOFF)) && (DrawY > (log8_Y - CAROFF)) && (DrawY < (log8_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log8startX) + (DrawY-log8startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b1;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log9_X - LOGOFF)) && (DrawX < (log9_X + LOGOFF)) && (DrawY > (log9_Y - CAROFF)) && (DrawY < (log9_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log9startX) + (DrawY-log9startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b1;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log10_X - LOGOFF)) && (DrawX < (log10_X + LOGOFF)) && (DrawY > (log10_Y - CAROFF)) && (DrawY < (log10_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log10startX) + (DrawY-log10startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b1;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log11_X - LOGOFF)) && (DrawX < (log11_X + LOGOFF)) && (DrawY > (log11_Y - CAROFF)) && (DrawY < (log11_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log11startX) + (DrawY-log11startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b1;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log9_X - LOGOFF)) && (DrawX < (log12_X + LOGOFF)) && (DrawY > (log12_Y - CAROFF)) && (DrawY < (log12_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log12startX) + (DrawY-log12startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b1;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log13_X - LOGOFF)) && (DrawX < (log13_X + LOGOFF)) && (DrawY > (log13_Y - CAROFF)) && (DrawY < (log13_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log13startX) + (DrawY-log13startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b1;
		   log14_on <= 1'b0;
		end
		else if ((DrawX > (log14_X - LOGOFF)) && (DrawX < (log14_X + LOGOFF)) && (DrawY > (log14_Y - CAROFF)) && (DrawY < (log14_Y + CAROFF))) begin
		   addr_read_log <= ((DrawX-log14startX) + (DrawY-log14startY)*80);
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b1;
		end
		else begin
		   addr_read_log <= 0;
		   log0_on <= 1'b0;
		   log1_on <= 1'b0;
		   log2_on <= 1'b0;
		   log3_on <= 1'b0;
		   log4_on <= 1'b0;
		   log5_on <= 1'b0;
		   log6_on <= 1'b0;
		   log7_on <= 1'b0;
		   log8_on <= 1'b0;
		   log9_on <= 1'b0;
		   log10_on <= 1'b0;
		   log11_on <= 1'b0;
		   log12_on <= 1'b0;
		   log13_on <= 1'b0;
		   log14_on <= 1'b0;
		end
	 end
   //=======================================================
   //  Title/Lose Screen Drawing
   //=======================================================
   always_comb begin
	  if(DrawX >= 208 && DrawX < 432 && DrawY >= 112 && DrawY < 368)
		begin
		   if(gameStart == 1'b0)
			 addr_read_background <= ((DrawX-208) + (DrawY-112)*224);
		   else if(gameEnd == 1'b1)
			 addr_read_background <= ((DrawX-208) + (DrawY-112)*224)+57344;
		   else
			 addr_read_background <= 0;
		end
	  else
		begin
		   addr_read_background <= 0;
		end
   end

   //=======================================================
   //  Start Screen Drawing
   //=======================================================
   logic start_on;
   always_comb begin
	  if (DrawX >= 80 && DrawX < 310 && DrawY >= 412 && DrawY < 443)
		begin
		   addr_read_start <= ((DrawX-80) + (DrawY-412)*130);
		end
	  else if (DrawX >= 310 && DrawX < 440 && DrawY >= 412 && DrawY < 443)
		begin
		   addr_read_start <= ((DrawX-310) + (DrawY-412)*130);
		end
	  else if (DrawX >= 440 && DrawX < 520 && DrawY >= 412 && DrawY < 443)
		begin
		   addr_read_start <= ((DrawX-440) + (DrawY-412)*130);
		end
	  else if (DrawX >= 520 && DrawX < 600 && DrawY >= 412 && DrawY < 443)
		begin
		   addr_read_start <= ((DrawX-520) + (DrawY-412)*130);
		end
	  else if (DrawX >= 80 && DrawX < 310 && DrawY >= 202 && DrawY < 233)
		begin
		   addr_read_start <= ((DrawX-80) + (129-(DrawY-202))*130);
		end
	  else if (DrawX >= 310 && DrawX < 440 && DrawY >= 202 && DrawY < 233)
		begin
		   addr_read_start <= ((DrawX-310) + (129-(DrawY-202))*130);
		end
	  else if (DrawX >= 440 && DrawX < 520 && DrawY >= 202 && DrawY < 233)
		begin
		   addr_read_start <= ((DrawX-440) + (129-(DrawY-202))*130);
		end
	  else if (DrawX >= 520 && DrawX < 600 && DrawY >= 202 && DrawY < 233)
		begin
		   addr_read_start <= ((DrawX-520) + (129-(DrawY-202))*130);
		end
	  else
		begin
		   addr_read_start <= 0;
		end

   end
   //=======================================================
   //  Victory Frogs Drawing Determination
   //=======================================================
   logic vict_on;
   int	 victOFF;
   assign victOFF = 16;
   int	 vict0startX, vict0startY,vict1startX, vict1startY,vict2startX, vict2startY,vict3startX, vict3startY, vict4startX,vict4startY;
   always_comb begin
	  vict0startX <= 120 - victOFF;
	  vict0startY <= 45 - victOFF;
	  vict1startX <= 230 - victOFF;
	  vict1startY <= 45 - victOFF;
	  vict2startX <= 340 - victOFF;
	  vict2startY <= 45 - victOFF;
	  vict3startX <= 450 - victOFF;
	  vict3startY <= 45 - victOFF;
	  vict4startX <= 560 - victOFF;
	  vict4startY <= 45 - victOFF;
   end
   always_comb begin
	  if ((home0 == 1'b1) &&(DrawX > (120 - victOFF)) && (DrawX < (120 + victOFF)) && (DrawY > (45 - victOFF)) && (DrawY < (45 + victOFF))) begin
         vict_on <= 1'b1;
		 addr_read_vict <= ((DrawX-vict0startX)/2 + (DrawY-vict0startY)/2*16);
	  end
	  else if ((home1 == 1'b1) &&(DrawX > (230 - victOFF)) && (DrawX < (230 + victOFF)) && (DrawY > (45 - victOFF)) && (DrawY < (45 + victOFF))) begin
         vict_on <= 1'b1;
		 addr_read_vict <= ((DrawX-vict1startX)/2 + (DrawY-vict1startY)/2*16);
	  end
	  else if ((home2 == 1'b1) &&(DrawX > (340 - victOFF)) && (DrawX < (340 + victOFF)) && (DrawY > (45 - victOFF)) && (DrawY < (45 + victOFF))) begin
         vict_on <= 1'b1;
		 addr_read_vict <= ((DrawX-vict2startX)/2 + (DrawY-vict2startY)/2*16);
	  end
	  else if ((home3 == 1'b1) &&(DrawX > (450 - victOFF)) && (DrawX < (450 + victOFF)) && (DrawY > (45 - victOFF)) && (DrawY < (45 + victOFF))) begin
         vict_on <= 1'b1;
		 addr_read_vict <= ((DrawX-vict3startX)/2 + (DrawY-vict3startY)/2*16);
	  end
	  else if ((home4 == 1'b1) &&(DrawX > (560 - victOFF)) && (DrawX < (560 + victOFF)) && (DrawY > (45 - victOFF)) && (DrawY < (45 + victOFF))) begin
         vict_on <= 1'b1;
		 addr_read_vict <= ((DrawX-vict4startX)/2 + (DrawY-vict4startY)/2*16);
	  end
	  else
		begin
		   vict_on <= 1'b0;
		   addr_read_vict <= 0;
		end

   end
   //=======================================================
   //  Lives Drawing Determination
   //=======================================================
   logic live_on;
   int	 liveOFF;
   assign liveOFF = 12;
   int	 live0startX, live0startY,live1startX, live1startY,live2startX, live2startY,live3startX, live3startY, live4startX,live4startY;
   always_comb begin
	  live0startX <= 92 - liveOFF;
	  live0startY <= 455 - liveOFF;
	  live1startX <= 116 - liveOFF;
	  live1startY <= 455 - liveOFF;
	  live2startX <= 140 - liveOFF;
	  live2startY <= 455 - liveOFF;
	  live3startX <= 164 - liveOFF;
	  live3startY <= 455 - liveOFF;
	  live4startX <= 188 - liveOFF;
	  live4startY <= 455 - liveOFF;
   end
   always_comb begin
	  if ((Lives >= 1) && (DrawX > (92 - liveOFF)) && (DrawX < (92 + liveOFF)) && (DrawY > (455 - liveOFF)) && (DrawY < (455 + liveOFF))) begin
         live_on <= 1'b1;
		 addr_read_live <= ((DrawX-live0startX) + (DrawY-live0startY)*24);
	  end
	  else if ((Lives >= 2) &&(DrawX > (116 - liveOFF)) && (DrawX < (116 + liveOFF)) && (DrawY > (455 - liveOFF)) && (DrawY < (455 + liveOFF))) begin
         live_on <= 1'b1;
		 addr_read_live <= ((DrawX-live1startX) + (DrawY-live1startY)*24);
	  end
	  else if ((Lives >= 3) &&(DrawX > (140 - liveOFF)) && (DrawX < (140 + liveOFF)) && (DrawY > (455 - liveOFF)) && (DrawY < (455 + liveOFF))) begin
         live_on <= 1'b1;
		 addr_read_live <= ((DrawX-live2startX) + (DrawY-live2startY)*24);
	  end
	  else if ((Lives >= 4) &&(DrawX > (164 - liveOFF)) && (DrawX < (164 + liveOFF)) && (DrawY > (455 - liveOFF)) && (DrawY < (455 + liveOFF))) begin
         live_on <= 1'b1;
		 addr_read_live <= ((DrawX-live3startX) + (DrawY-live3startY)*24);
	  end
	  else if ((Lives >= 5) &&(DrawX > (188 - liveOFF)) && (DrawX < (188 + liveOFF)) && (DrawY > (455 - liveOFF)) && (DrawY < (455 + liveOFF))) begin
         live_on <= 1'b1;
		 addr_read_live <= ((DrawX-live4startX) + (DrawY-live4startY)*24);
	  end
	  else
		begin
		   live_on <= 1'b0;
		   addr_read_live <= 0;
		end

   end
   //=======================================================
   //  Timer Drawing Determination
   //=======================================================
   logic time_on, time_word_on;
   logic [8:0] timeR, timeG, timeB;
   always_comb begin
	  if(DrawY > 441 && DrawY < 469)
		begin
		   if((tim >= 60) && (DrawX>=460 && DrawX <580))
			 begin
				time_on <= 1'b1;
				timeR <= 8'h7E;
				timeG <= 8'hDA;
				timeB <= 8'h43;
			 end
		   else if((tim >= 50) && (DrawX>=460 && DrawX <560))
			 begin
				time_on <= 1'b1;
				timeR <= 8'h7E;
				timeG <= 8'hDA;
				timeB <= 8'h43;
			 end
		   else if((tim >= 40) && (DrawX>=460 && DrawX <540))
			 begin
				time_on <= 1'b1;
				timeR <= 8'h7E;
				timeG <= 8'hDA;
				timeB <= 8'h43;
			 end
		   else if((tim >= 30) && (DrawX>=460 && DrawX <520))
			 begin
				time_on <= 1'b1;
				timeR <= 8'h7E;
				timeG <= 8'hDA;
				timeB <= 8'h43;
			 end
		   else if((tim >= 20) && (DrawX>=460 && DrawX <500))
			 begin
				time_on <= 1'b1;
				timeR <= 8'h7E;
				timeG <= 8'hDA;
				timeB <= 8'h43;
			 end
		   else if((tim >= 10) && (DrawX>=460 && DrawX <480))
			 begin
				time_on <= 1'b1;
				timeR <= 8'h7E;
				timeG <= 8'hDA;
				timeB <= 8'h43;
			 end
		   else if((tim >= 5) && (DrawX>=460 && DrawX <470))
			 begin
				time_on <= 1'b1;
				timeR <= 8'h7E;
				timeG <= 8'hDA;
				timeB <= 8'h43;
			 end
		   else if((tim >= 1) && (DrawX>=460 && DrawX <462))
			 begin
				time_on <= 1'b1;
				timeR <= 8'h7E;
				timeG <= 8'hDA;
				timeB <= 8'h43;
			 end

		   else
			 begin
				time_on <= 1'b0;
				timeR <= 8'h00;
				timeG <= 8'h00;
				timeB <= 8'h00;
			 end
		end
	  else
		begin
		   time_on <= 1'b0;
		   timeR <= 8'h00;
		   timeG <= 8'h00;
		   timeB <= 8'h00;
		end
   end
   //=======================================================
   //  Time word Drawing Determination
   //=======================================================
   always_comb begin
	  if(DrawX >= 386 && DrawX < 454 && DrawY >= 445 && DrawY < 462)
		begin
		   time_word_on <= 1'b1;
		   addr_read_time <= ((DrawX-386)/2 + (DrawY-445)/2*34);
		end
	  else
		begin
		   time_word_on <= 1'b0;
		   addr_read_time <= 0;
		end
   end
   //=======================================================
   //  Color Mapping to display
   //=======================================================
   always_comb
     begin:RGB_Display
		if(DrawX < 80 || DrawX > 600)
          begin
			 Red = 8'h00;
			 Green = 8'h00;
			 Blue = 8'h00;
		  end
		else if (DrawX >= 80 && DrawX <= 600 && DrawY>=0 && DrawY<443)
		  begin
			 if(gameStart == 1'b0)
			   begin
				  Red = title_red;
				  Green = title_green;
				  Blue  = title_blue;
			   end
			 else if(gameEnd == 1'b1)
			   begin
				  Red = lose_red;
				  Green = lose_green;
				  Blue  = lose_blue;
			   end
			 else if ((Frog_on == 1'b1) && (is_frog_transparent == 1'b0))
			   begin
				  Red <= frog_red;
				  Green <= frog_green;
				  Blue <= frog_blue;
			   end
			 //=======================================================
			 //  Log Mapping to display
			 //=======================================================
			 else if((log0_on== 1'b1 || log1_on== 1'b1 || log2_on== 1'b1 || log3_on== 1'b1 ||
		         	  log4_on== 1'b1 || log5_on== 1'b1 || log6_on== 1'b1 || log7_on== 1'b1 ||
					  log8_on== 1'b1 || log9_on== 1'b1 || log10_on== 1'b1 || log11_on== 1'b1 ||
					  log12_on== 1'b1 || log13_on== 1'b1 || log14_on== 1'b1) &&  (is_log_transparent == 1'b0))
			   begin
				  Red <= log_red;
				  Green <= log_green;
				  Blue <= log_blue;
			   end
			 //=======================================================
			 //  Car Mapping to display
			 //=======================================================
			 else if((Car0_on== 1'b1 || Car1_on== 1'b1 || Car2_on== 1'b1 || Car3_on== 1'b1 ||
		         	  Car4_on== 1'b1 || Car5_on== 1'b1 || Car6_on== 1'b1 || Car7_on== 1'b1 ||
					  Car8_on== 1'b1 || Car9_on== 1'b1) &&  (is_car_transparent == 1'b0))
			   begin
				  Red <= car_red;
				  Green <= car_green;
				  Blue <= car_blue;
			   end
             else if(DrawY < 26)
               begin
				  Red <= 8'h00;
                  Green <= 8'h00;
                  Blue <= 8'h00;
               end
			 //win zone
			 else if( is_vict_transparent == 1'b0 && vict_on == 1'b1)
			   begin
				  Red <= vict_red;
				  Green <= vict_green;
				  Blue <= vict_blue;
			   end
             else if(DrawY >= 26 && DrawY < 30)
               begin
				  Red <= 8'h00;
                  Green <= 8'h90;
                  Blue <= 8'h00;
               end
             else if(DrawY >= 30 && DrawY < 60)
               begin
                  if((DrawX < 140 && DrawX > 100)||
                     (DrawX < 250 && DrawX > 210)||
                     (DrawX < 360 && DrawX > 320)||
                     (DrawX < 470 && DrawX > 430)||
                     (DrawX < 580 && DrawX > 540))
					begin
                       Red <= 8'h00;
                       Green <= 8'h00;
                       Blue <= 8'h7f;
					end
                  else
					begin
					   Red <= 8'h00;
                       Green <= 8'h90;
                       Blue <= 8'h00;
					end
               end
			 // ROAD
			 else if(DrawY >= 205 && DrawY < 208)
			   begin
				  Red <= 8'h8a;
				  Green <= 8'h29;
				  Blue <= 8'hee;
			   end
			 
			 else if(DrawY >= 208 && DrawY < 233)
			   begin
				  Red <= start_red;
				  Green <= start_green;
				  Blue <= start_blue;
			   end
			 else if(DrawY >=  233 && DrawY < 412)
			   begin
				  Red <= 8'h00;
				  Green <= 8'h00;
				  Blue <= 8'h00;
			   end
			 //start position
			 else if(DrawY >= 412 && DrawY < 443)
			   begin
				  Red <= start_red;
				  Green <= start_green;
				  Blue <= start_blue;
			   end
			 //water
			 else
			   begin
				  Red <= 8'h00;
				  Green <= 8'h00;
				  Blue <= 8'h7f;
			   end
		  end
		else if(gameStart == 1'b1 && gameEnd == 1'b0)
		  begin
			 if(live_on == 1'b1)
			   begin
				  Red <= live_red;
				  Green <= live_green;
				  Blue <= live_blue;
			   end
			 else if(time_on == 1'b1)
			   begin
				  Red <= timeR;
				  Green <= timeG;
				  Blue <= timeB;
			   end
			 else if(time_word_on == 1'b1)
			   begin
				  Red <= time_red;
				  Green <= time_green;
				  Blue <= time_blue;
			   end
			 else
			   begin
				  Red <= 8'h00;
				  Green <= 8'h00;
				  Blue <= 8'h00;
			   end
		  end
		else
		  begin
			 Red <= 8'h00;
			 Green <= 8'h00;
			 Blue <= 8'h00;
		  end
     end

endmodule
