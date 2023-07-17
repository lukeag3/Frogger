//-------------------------------------------------------------------------
//                                                                       --
//      Based on LAB62 top module                                        --
//      For use with ECE 385 Lab 62                                      --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module finalTop (

                 ///////// Clocks /////////
                 input         MAX10_CLK1_50,

                 ///////// KEY /////////
                 input [1:0]   KEY,

                 ///////// SW /////////
                 input [9:0]   SW,

                 ///////// LEDR /////////
                 output [9:0]  LEDR,

                 ///////// HEX /////////
                 output [7:0]  HEX0,
                 output [7:0]  HEX1,
                 output [7:0]  HEX2,
                 output [7:0]  HEX3,
                 output [7:0]  HEX4,
                 output [7:0]  HEX5,

                 ///////// VGA /////////
                 output        VGA_HS,
                 output        VGA_VS,
                 output [3:0]  VGA_R,
                 output [3:0]  VGA_G,
                 output [3:0]  VGA_B,


                 ///////// ARDUINO /////////
                 inout [15:0]  ARDUINO_IO,
                 inout         ARDUINO_RESET_N

);

   logic Reset_h, vssig, blank, sync, VGA_Clk, Reset_2;


//=======================================================
//  REG/WIRE declarations
//=======================================================
   //logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
   logic [3:0] hex_num_4, hex_num_3, hex_num_2, hex_num_1, hex_num_0; //4 bit input hex digits
   logic [1:0] signs;
   logic [1:0] hundreds;
   logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
   logic [7:0] Red, Blue, Green;
   logic [7:0] keycode;
   logic [15:0] score;
   logic [15:0] highScore;
   logic [15:0] scoreOut;

   //HEX drivers
   HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
   HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
   HexDriver hex_driver2 (hex_num_2, HEX2[6:0]);
   HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
   HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);

   assign HEX0[7] = 1'b1;
   assign HEX1[7] = 1'b1;
   assign HEX2[7] = 1'b1;
   assign HEX3[7] = 1'b1;
   assign HEX4[7] = 1'b1;

   //Assign one button to reset
   assign {Reset_h}=~ (KEY[0]);

   //A/D converter is only 12 bit
   assign VGA_R = Red[7:4];
   assign VGA_B = Blue[7:4];
   assign VGA_G = Green[7:4];


   always_ff @ (posedge MAX10_CLK1_50 or posedge Reset_h )
     begin
        if(Reset_h)
          Reset_2 <= 1'b1;
        else if(keycode == 8'h29)
          Reset_2 <= 1'b1;
        else
          Reset_2 <= 1'b0;
     end

   always_ff @ (posedge MAX10_CLK1_50 or posedge Reset_2 )
     begin
        if(Reset_2)
          begin
             highScore <= 16'b0000000000000000;
          end
        else if (score > highScore)
          begin
             highScore <= score;
          end
     end
   always_ff @ (posedge MAX10_CLK1_50)
     begin
        if(keycode == 8'h0b)
          begin
             scoreOut <= highScore;
             HEX5 <= 8'b10001001;
          end
        else
          begin
             scoreOut <= score;
             HEX5 <= 8'b11111111;
          end
     end

   // Module Instantiation

   vga_controller vg0(.*,.Clk(MAX10_CLK1_50),.Reset(Reset_h),.hs(VGA_HS),
                      .vs(VGA_VS), .pixel_clk(VGA_Clk), .blank(blank),
                      .sync(sync), .DrawX(drawxsig), .DrawY(drawysig));
   frogger c0(.*, .CLK(VGA_Clk),.DrawX(drawxsig), .DrawY(drawysig), .keycode(keycode),
              .MAX10_CLK1_50(MAX10_CLK1_50), .ResetIn(Reset_2),
              .Red(Red), .Green(Green), .Blue(Blue), .score(score));
   score_to_hex s0(.hex_num_4(hex_num_4), .hex_num_3(hex_num_3), .hex_num_2(hex_num_2),
                   .hex_num_1(hex_num_1), .hex_num_0(hex_num_0), .score(scoreOut));

endmodule
