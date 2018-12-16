`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:51:37 11/30/2018 
// Design Name: 
// Module Name:    VGA_display 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VGA_display(
    input clk,   // 100 MHz
	 input up,
	 input down,
	 input left,
	 input right,
	 input click,
    output hsync,
    output vsync,
	 output reg[7:0] rgb
    );
	 
	 reg clk25;
	 reg clk100000;
	 reg[17:0] clk100000_counter;
	 reg[1:0] clk_counter;
	 reg[9:0] hCount;
	 reg[9:0] vCount;
	 
	 parameter max_horizontal = 10'd800;
	 parameter max_vertical = 10'd525;
	 parameter RED = 8'b111_000_00;
	 parameter GREEN = 8'b000_111_00;
	 parameter BLACK = 8'b000_000_00;
	 
	 parameter Gimpy = 13'd7225;
	 parameter GimpyXY = 7'd85;
	 
	 reg [7:0] COLOUR_OUT;	//Colours that go to VGA
	 reg [7:0] COLOUR_DATA1 [0:Gimpy-1];	//data of colours   7225
	 reg [7:0] COLOUR_DATA2 [0:Gimpy-1];	//data of colours
	 //reg [7:0] COLOUR_DATA3 [0:Gimpy-1];	//data of colours

	 
	 reg [1:0] image_selection_matrix [2:0][2:0];
	 reg first_select;

	 
	 reg [3:0] flashing;
	 reg [3:0] clicked;
	 
	 
	 wire [12:0] STATE1;	
	 wire [12:0] STATE2;
	 //wire [12:0] STATE3;
	 //wire [12:0] STATE4;
	 //wire [12:0] STATE5;
	 
	 parameter X1 = 10'd293;
	 parameter Y1 = 10'd104;
	 parameter X2 = 10'd378;
	 parameter Y2 = 10'd104;



	 
	 parameter X6 = 10'd293;
	 parameter Y6 = 10'd189;
	 parameter X7 = 10'd378;
	 parameter Y7 = 10'd189;



	 
	 parameter X11 = 10'd293;
	 parameter Y11 = 10'd274;
	 parameter X12 = 10'd378;
	 parameter Y12 = 10'd274;





	 

	 
	 
	 reg [10:0] cursor_horizontal;
	 reg [10:0] cursor_vertical;
	 
	 integer d;
	 integer i;	 
	 integer j;
	 
	 
	 
	 initial begin // Set all of them initially to 0
		clk25 = 0;
		rgb = RED;
		clk_counter = 0;
		hCount = 0;
		vCount = 0;
		//d = $random;
		cursor_horizontal = 10'd444;
		cursor_vertical = 10'd330;
		

	end
	 
	 always @ (posedge clk)
		begin
		    if (clk_counter < 1)
			     clk_counter <= clk_counter + 1;
			 else
		        begin
				      clk_counter <= 0;
				      clk25 <= ~clk25;
				  end
		end
		
	  always @ (posedge clk)
		begin
		    if (clk100000_counter < 200000)
			     clk100000_counter <= clk100000_counter + 1;
			 else
		        begin
				      clk100000_counter <= 0;
				      clk100000 <= ~clk100000;
				  end
		end

	 

	 
	 always @ (posedge clk25)
		begin
		if (hCount < max_horizontal)
			begin
			    hCount <= hCount + 1;
			end
		else if (vCount < max_vertical)
			begin
			    hCount <= 0;
			    vCount <= vCount + 1;
			end
		else
			begin
			    hCount <= 0;
			    vCount <= 0;
			end
			
		end
	 
	
	 
	 
    assign hsync = (hCount < 96) ? 1'b1:1'b0;
	 assign vsync = (vCount < 2) ? 1'b1:1'b0;
	 
	 initial begin
		first_select = 1;
		$readmemh ("Blue.list", COLOUR_DATA1);
		$readmemh ("Green.list", COLOUR_DATA2);
		//$readmemh ("Orange.list", COLOUR_DATA3);
		//$readmemh ("Red.list", COLOUR_DATA3);
		
		
		for (i = 0; i < 4; i = i + 1)
			flashing[i] = 1;
			
		for (i = 0; i < 4; i = i + 1)
			clicked[i] = 0;
		
		for (i = 0; i < 2; i = i + 1) begin
			for (j = 0; j < 2; j = j + 1) begin
				image_selection_matrix[i][j] = j;
			end
		end
		
	 end
	
	 assign STATE1 = (hCount-X1)*GimpyXY+vCount-Y1;	//apply formula
	 assign STATE2 = (hCount-X2)*GimpyXY+vCount-Y2;	//apply formula
	 //assign STATE3 = (hCount-X3)*GimpyXY+vCount-Y3;	//apply formula
	 //assign STATE4 = (hCount-X4)*GimpyXY+vCount-Y4;	//apply formula
	 //assign STATE5 = (hCount-X5)*GimpyXY+vCount-Y5;	//apply formula
	
	 always @(posedge clk25) begin
		if (hCount>=X1 && hCount<X1+GimpyXY && vCount>=Y1 && vCount<Y1+GimpyXY && flashing[0]) begin
			if (image_selection_matrix[0][0] == 0)
				rgb <= COLOUR_DATA1[{STATE1}];
			else if (image_selection_matrix[0][0] == 1)
				rgb <= COLOUR_DATA2[{STATE1}];


		end
		else if (hCount>=X2 && hCount<X2+GimpyXY && vCount>=Y2 && vCount<Y2+GimpyXY && flashing[1]) begin
			if (image_selection_matrix[0][1] == 0)
				rgb <= COLOUR_DATA1[{STATE2}];
			else if (image_selection_matrix[0][1] == 1)
				rgb <= COLOUR_DATA2[{STATE2}];


		end


		else if (hCount>=X6 && hCount<X6+GimpyXY && vCount>=Y6 && vCount<Y6+GimpyXY && flashing[2]) begin
			if (image_selection_matrix[1][0] == 0)
				rgb <= COLOUR_DATA1[{STATE1}];
			else if (image_selection_matrix[1][0] == 1)
				rgb <= COLOUR_DATA2[{STATE1}];



		end
		else if (hCount>=X7 && hCount<X7+GimpyXY && vCount>=Y7 && vCount<Y7+GimpyXY && flashing[3]) begin
			if (image_selection_matrix[1][1] == 0)
				rgb <= COLOUR_DATA1[{STATE2}];
			else if (image_selection_matrix[1][1] == 1)
				rgb <= COLOUR_DATA2[{STATE2}];



		end
		



		else
				rgb <= BLACK;
				
		if (hCount > cursor_horizontal - 15 && hCount < cursor_horizontal + 15 && vCount > cursor_vertical - 15 && vCount < cursor_vertical + 15)
			    rgb <= GREEN;
		
		
	end
	
	reg image_number;
	reg row;
	reg col;
	
	
	always @ (posedge vsync) begin
		if (up)
			cursor_vertical <= cursor_vertical - 2;
		
		if (down)
			cursor_vertical <= cursor_vertical + 2;
		
		if (left)
			cursor_horizontal <= cursor_horizontal - 2;
		
		if (right)
			cursor_horizontal <= cursor_horizontal + 2;
			
		if (click) begin
			if (cursor_horizontal > 293 && cursor_horizontal < 378 && cursor_vertical > 104 && cursor_vertical < 189) begin
				for (i = 0; i < 4; i = i + 1)
					clicked[i] = 0;
				clicked[0] = 1;
				if (first_select) begin
					image_number = image_selection_matrix[0][0];
					row = 0;
					col = 0;
					first_select = 0;
				end
				else begin
					image_selection_matrix[row][col] = image_selection_matrix[0][0];
					image_selection_matrix[0][0] = image_number;
					first_select = 1;
					end
			   end
			else if (cursor_horizontal > 378 && cursor_horizontal < 463 && cursor_vertical > 104 && cursor_vertical < 189) begin
				for (i = 0; i < 4; i = i + 1)
					clicked[i] = 0;
				clicked[1] = 1;
				if (first_select) begin
					image_number = image_selection_matrix[0][1];
					row = 0;
					col = 1;
					first_select = 0;
				end
				else begin
					image_selection_matrix[0][1] = image_selection_matrix[row][col];
					image_selection_matrix[row][col] = image_number;
					first_select = 1;
					end
			   end


			else if (cursor_horizontal > 293 && cursor_horizontal < 378 && cursor_vertical > 189 && cursor_vertical < 274) begin
				for (i = 0; i < 4; i = i + 1)
					clicked[i] = 0;
				clicked[2] = 1;
				if (first_select) begin
					image_number = image_selection_matrix[1][0];
					row = 1;
					col = 0;
					first_select = 0;
				end
				else begin
					image_selection_matrix[1][0] = image_selection_matrix[row][col];
					image_selection_matrix[row][col] = image_number;
					first_select = 1;
					end
			end
			else if (cursor_horizontal > 378 && cursor_horizontal < 463 && cursor_vertical > 189 && cursor_vertical < 274) begin
				for (i = 0; i < 4; i = i + 1)
					clicked[i] = 0;
				clicked[3] = 1;
				if (first_select) begin
					image_number = image_selection_matrix[1][1];
					row = 1;
					col = 1;
					first_select = 0;
				end
				else begin
					image_selection_matrix[1][1] = image_selection_matrix[row][col];
					image_selection_matrix[row][col] = image_number;
					first_select = 1;
					end
			end
			



		end
	
	end
	
	always @ (posedge clk100000) begin
		for (i = 0; i < 4 ; i = i + 1) begin
			if (clicked[i]) begin
				if (flashing[i] == 0)
					flashing[i] <= 1;
				else
					flashing[i] <= 0;
					end
			else
				flashing[i] <= 1;
			
		end
	end



endmodule
