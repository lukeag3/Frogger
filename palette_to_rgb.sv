/*

 palette_to_rgb.sv

 Convert palette index to RGB Values and report if transparent.

 */

module palette_to_rgb(
					   input logic [3:0]  palette,
					   output logic		  transparent,
					   output logic [7:0] red, green, blue
					   );
   //=======================================================
   //  Sprite Palette
   //=======================================================
   //'0x000000','0xdfdef5', '0xc37059', '0xd93629', '0xdb582d', //brown removed'0x8b6c56', '0xfbfe55', '0xb8fc4f', '0x7eda43', '0x85dbf4', '0x0d0348', '0x3a1ced', '0x8a29ee', '0xde3bef', '0xe05bf0'
   //'0x000000','0xdfdef5', '0xc37059', '0xd93629', '0xdb582d', '0x8b6c56', '0xfbfe55', '0xb8fc4f', '0x7eda43', '0x85dbf4', '0x0d0348', '0x3a1ced', '0x8a29ee', '0xde3bef', '0xe05bf0']

   always_comb begin
	  case (palette)
		4'h0 :
		  begin
			 red <= 8'h00;
			 green <= 8'h00;
			 blue <= 8'h00;
			 transparent <= 1'b1;
		  end
		4'h1 :
		  begin
			 red <= 8'hDF;
			 green <= 8'hDE;
			 blue <= 8'hF5;
			 transparent <= 1'b0;
		  end
		4'h2 :
		  begin
			 red <= 8'hC3;
			 green <= 8'h70;
			 blue <= 8'h59;
			 transparent <= 1'b0;
		  end
		4'h3 :
		  begin
			 red <= 8'hD9;
			 green <= 8'h36;
			 blue <= 8'h29;
			 transparent <= 1'b0;
		  end
		4'h4 :
		  begin
			 red <= 8'hDB;
			 green <= 8'h58;
			 blue <= 8'h2D;
			 transparent <= 1'b0;
		  end
		4'h5 :
		  begin
			 red <= 8'hFB;
			 green <= 8'hFE;
			 blue <= 8'h55;
			 transparent <= 1'b0;
		  end
		4'h6 :
		  begin
			 red <= 8'hB8;
			 green <= 8'hFC;
			 blue <= 8'h4F;
			 transparent <= 1'b0;
		  end
		4'h7 :
		  begin
			 red <= 8'h7E;
			 green <= 8'hDA;
			 blue <= 8'h43;
			 transparent <= 1'b0;
		  end
		4'h8 :
		  begin
			 red <= 8'h85;
			 green <= 8'hDB;
			 blue <= 8'hF4;
			 transparent <= 1'b0;
		  end
		4'h9 :
		  begin
			 red <= 8'h0D;
			 green <= 8'h03;
			 blue <= 8'h48;
			 transparent <= 1'b0;
		  end
		4'hA :
		  begin
			 red <= 8'h3A;
			 green <= 8'h1C;
			 blue <= 8'hED;
			 transparent <= 1'b0;
		  end
		4'hB :
		  begin
			 red <= 8'h8A;
			 green <= 8'h29;
			 blue <= 8'hEE;
			 transparent <= 1'b0;
		  end
		4'hC :
		  begin
			 red <= 8'hDE;
			 green <= 8'h3B;
			 blue <= 8'hEF;
			 transparent <= 1'b0;
		  end
		4'hD :
		  begin
			 red <= 8'hE0;
			 green <= 8'h5B;
			 blue <= 8'hF0;
			 transparent <= 1'b0;
		  end
		default:
		  begin //if default return white
			 red <= 8'hFF;
			 green <= 8'hFF;
			 blue <= 8'hFF;
			 transparent <= 1'b0;
		  end
	  endcase
   end
endmodule
