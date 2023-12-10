module CarDodge(
CLOCK_50, 
SW, 
KEY,
HEX0, 
HEX1,
HEX2,
HEX3,
HEX4,
HEX5,
HEX6,
HEX7,
wire_out_keyboard,
VGA_CLK,
VGA_HS,
VGA_VS,
VGA_BLANK_N, 
VGA_SYNC_N, 
VGA_R,
VGA_G, 
VGA_B,
PS2_CLK,
      PS2_DAT,
      counter_val
);

input CLOCK_50;
input [3:0] KEY;
input [9:0] SW;
output VGA_CLK;
output VGA_HS;
output VGA_VS;
output VGA_BLANK_N;
output VGA_SYNC_N;
output [7:0] VGA_R; 
output [7:0] VGA_G;
output [7:0] VGA_B; 
output [7:0] HEX0;
output [7:0] HEX7;
output wire [3:0] counter_val;
output [7:0] HEX1;

output [7:0] HEX2;

output [7:0] HEX3;

output [7:0] HEX4;

output [7:0] HEX5;

output [7:0] HEX6;
output [7:0] wire_out_keyboard;


inout                   PS2_CLK;
inout                   PS2_DAT;

PS2_Demo Keyboard (
      // Inputs
      .CLOCK_50(CLOCK_50),
      .KEY(KEY),

      // Bidirectionals
      .PS2_CLK(PS2_CLK),
      .PS2_DAT(PS2_DAT),
      
      // Outputs
      .HEX0(HEX0),
      .HEX1(HEX1),
      .HEX2(HEX2),
      .HEX3(HEX3),
      .HEX4(HEX4),
      .HEX5(HEX5),
      .HEX6(HEX6),
      .HEX7(HEX7),
      .wireout(wire_out_keyboard)
);
wire [7:0] keyboard_signal;
assign keyboard_signal=wire_out_keyboard;
wire resetn1;


wire resetn2;


wire resetn3;

wire resetn4;

wire resetn5;

wire resetn6;

wire resetn7;

wire rom_address;


wire move_left;
wire move_right;
wire move_lock;

assign move_left = SW[7];
assign move_right = SW[8];
assign move_lock = SW[9];




wire vga_clock;
assign vga_clock = VGA_CLK;

wire vga_hs;
assign vga_hs = VGA_HS;

wire vga_vs;
assign vga_vs = VGA_VS;

wire vga_blank;
assign vga_blank = VGA_BLANK_N;

wire vga_sync;
assign vga_sync = VGA_SYNC_N;

 wire [7:0] vga_r;
assign vga_r[7:0] = VGA_R;

wire [7:0] vga_g;
assign vga_g = VGA_G;

wire [7:0] vga_b;
assign vga_b = VGA_B;

/*
All of the following are for different object control and data paths
these are to be wired to the VGA
*/
wire [2:0] colour1;
wire [7:0] x1;
wire [6:0] y1;

wire [2:0] colour2;
wire [7:0] x2;
wire [6:0] y2;

wire [2:0] colour3;
wire [7:0] x3;
wire [6:0] y3;

wire [2:0] colour4;
wire [7:0] x4;
wire [6:0] y4;

wire [2:0] colour5;
wire [7:0] x5;
wire [6:0] y5;

wire [2:0] colour6;
wire [7:0] x6;
wire [6:0] y6;

wire [2:0] colour7;
wire [7:0] x7;
wire [6:0] y7;


//Wires for communication between control and datapath
wire reset1, next1, erase1, plot_enable1, update1;
assign resetn1 = KEY[0];
wire [6:0] y_count1;
wire [7:0] x_count1;
wire [25:0] freq1;
wire [5:0] plot_count1;



wire reset2, next2, erase2, plot_enable2, update2;
assign resetn2 = KEY[0];
wire [5:0] plot_count2;
wire [7:0] x_count2;
wire [25:0] freq2;

wire reset3, next3, erase3, plot_enable3, update3;
assign resetn3 = KEY[0];
wire [7:0] x_count3;
wire [25:0] freq3;
wire [5:0] plot_count3;


wire reset4, next4, erase4, plot_enable4, update4;
assign resetn4 = KEY[0];
wire [7:0] x_count4;
wire [25:0] freq4;
wire [5:0] plot_count4;


wire reset5, next5, erase5, plot_enable5, update5;
assign resetn5 = KEY[0];
wire [7:0] x_count5;
wire [25:0] freq5;
wire [5:0] plot_count5;


wire reset6, next6, erase6, plot_enable6, update6;
assign resetn6 = KEY[0];
wire [7:0] x_count6;
wire [25:0] freq6;
wire [5:0] plot_count6;


wire reset7, next7, erase7, plot_enable7, update7;
assign resetn7 = KEY[0];
wire [6:0] y_count7;
wire [25:0] freq7;
wire [5:0] plot_count7;


wire [2:0] player_colour;
wire [4:0] mif_address;


vga_adapter VGA(
.resetn(resetn),
.clock(CLOCK_50),
.colour(colour),
.x(display_val_x),
.y(display_val_y), //try changing to specific location
.plot(next),
.VGA_R(VGA_R),
.VGA_G(VGA_G),
.VGA_B(VGA_B),
.VGA_HS(VGA_HS),
.VGA_VS(VGA_VS),
.VGA_BLANK(VGA_BLANK_N),
.VGA_SYNC(VGA_SYNC_N),
.VGA_CLK(VGA_CLK));
defparam VGA.RESOLUTION = "160x120";
defparam VGA.MONOCHROME = "FALSE";
defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
defparam VGA.BACKGROUND_IMAGE = "newroadw.mif";

controlPath c(.clk(CLOCK_50),//clk//
 .resetn(resetn1), .plot_count(mif_address),
.x_count(x_count1), .y_count(y_count1), .freq(freq1),
.next(next1), .erase(erase1), .update(update1), .plot_enable(plot_enable1), .reset(reset1));//y_count


controlPath c1(.clk(CLOCK_50),//clk//
 .resetn(resetn2), .plot_count(plot_count2),
.x_count(x_count2), .freq(freq2),
.next(next2), .erase(erase2), .update(update2), .plot_enable(plot_enable2), .reset(reset2));

controlPath c2(.clk(CLOCK_50),//clk//
 .resetn(resetn3), .plot_count(plot_count3),
.x_count(x_count3), .freq(freq3),
.next(next3), .erase(erase3), .update(update3), .plot_enable(plot_enable3), .reset(reset3));

controlPath_left c3(.clk(CLOCK_50),//clk//
 .resetn(resetn4), .plot_count(plot_count4),
.x_count(x_count4), .freq(freq4),
.next(next4), .erase(erase4), .update(update4), .plot_enable(plot_enable4), .reset(reset4));




controlPath_left c4(.clk(CLOCK_50),//clk//
 .resetn(resetn5), .plot_count(plot_count5),
.x_count(x_count5), .freq(freq5),
.next(next5), .erase(erase5), .update(update5), .plot_enable(plot_enable5), .reset(reset5));

controlPath_left c5(.clk(CLOCK_50),//clk//
 .resetn(resetn6), .plot_count(plot_count6),
.x_count(x_count6), .freq(freq6),
.next(next6), .erase(erase6), .update(update6), .plot_enable(plot_enable6), .reset(reset6));



controlPath_up c6(.clk(CLOCK_50),//clk//
 .resetn(resetn7), .plot_count(plot_count7),
.y_count(y_count7), .freq(freq7),
.next(next7), .erase(erase7), .update(update7), .plot_enable(plot_enable7), .reset(reset7));





block_one B1(//clk
CLOCK_50, resetn1, plot_enable1, next1, erase1, update1, reset1,
x1, y1 , colour1, mif_address, x_count1, freq1, player_colour, y_count1);

/*
block_one B2(//clk
CLOCK_50, resetn2, plot_enable2, next2, erase2, update2, reset2, SW[2:0],
x2, y2 , colour2, plot_count2, x_count2,   freq2 );

block_one B3(//clk
CLOCK_50, resetn3, plot_enable3, next3, erase3, update3, reset3,
x3, y3 , colour3, plot_count3, x_count3,  freq3);//y, y_count,
*/
block_left B4(//clk
CLOCK_50, resetn4, plot_enable4, next4, erase4, update4, reset4,
x4, y4 , colour4, plot_count4, x_count4, freq4);




block_left B5(//clk
CLOCK_50, resetn5, plot_enable5, next5, erase5, update5, reset5,
x5, y5 , colour5, plot_count5, x_count5,  freq5);

block_left B6(//clk
CLOCK_50, resetn6, plot_enable6, next6, erase6, update6, reset6,
x6, y6 , colour6, plot_count6, x_count6,  freq6);

block_up B7(//clk
CLOCK_50, resetn7, plot_enable7, next7, erase7, update7, reset7,
x7, y7 , colour7, plot_count7, y_count7,  freq7, keyboard_signal);//y, y_count,

car2 ca2(.address(mif_address), .clock(CLOCK_50), .q(player_colour));

reg resetn, next, colour;

/*
wire [7:0] x_out_one;
wire [6:0] y_out_one;

wire [7:0] x_out_two;
wire [6:0] y_out_two;

wire [7:0] x_out_three;
wire [6:0] y_out_three;
*/

reg [7:0] display_val_x;
reg [6:0] display_val_y;


localparam case_1 = 3'd0,
                    case_2 = 3'd1,
                    case_3 = 3'd2,
                    case_4 = 3'd3,
                    case_5 = 3'd4,
                    case_6 = 3'd5,
                    case_7 = 3'd6,
                    case_8 = 3'd7;
                    
reg [2:0] current_state, next_state;

reg [7:0] current_x_coord_block;
reg [7:0] prev_x_coord;

reg [7:0] block_1_x;
reg [6:0] block_1_y;

reg [7:0] block_2_x;
reg [6:0] block_2_y;

reg [7:0] block_3_x;
reg [6:0] block_3_y;



always @(*)
      begin
            case(current_state)
                  case_1: begin
                        display_val_x = x1;
                        //display_val_y = 7'd35;
                        display_val_y = y1;
                        block_1_x = x1;
                        //block_1_y = 7'd35;
                        block_1_y = y1;
                        next = next1;
                        colour = colour1;
                        resetn = resetn1;
                        next_state = case_2; //case2

                  end
                  case_2: begin
                        display_val_x = x6;
                        display_val_y = 7'd90;
                        block_2_x = x6;
                        block_2_y = 7'd90;
                        next = next6;
                        colour = colour6;
                        resetn = resetn6;
                        next_state = case_3;
                  end
                  case_3: begin
                        if(!move_lock)begin
                              display_val_x = 8'd80;
                              prev_x_coord = 8'd80;
                        end

                        display_val_y = y7;
                        block_3_x = 8'd80;
                        block_3_y = y7;
                        
                        next = next7;
                        colour = colour7;
                        resetn = resetn7;
                        next_state = case_1;
                  end
                  /*
                  case_4: begin
                        if(move_lock)begin
                              if(move_left) begin
                                    display_val_x <= prev_x_coord;
                                    prev_x_coord <= prev_x_coord;
                              end
                              if(!move_left)begin
                                    display_val_x <= prev_x_coord + 8'd1;
                                    prev_x_coord <= prev_x_coord + 8'd1;
                              end
                  end*/
                  /*
                  case_5:begin
                        if(block_1_x == block_3_x && block_1_y == block_3_y) begin
                              display_val_x = 8'b10;
                              display_val_y = 7'b10;
                        end
                        if(block_2_x == block_3_x && block_2_y == block_3_y) begin
                              display_val_x = 8'b10;
                              display_val_y = 7'b10;
                        end
                        
                        next_state = case_6;
                  end
                  */
                  default: next_state = case_1;
            endcase
      
      end

always@(posedge CLOCK_50)
      begin
            if(!resetn)
                  current_state <= case_1;
            else
                  current_state <= next_state;
      end


//module get_coordinates (address_a,address_b,clock,data_a,data_b,wren_a,wren_b,q_a,q_b);


/*get_coordinates ram_three_read(.address_a(5'd2), .address_b(5'd2), .clock(CLOCK_50), .data_a(x2), .data_b(y2), .wren_a(1'b1), .wren_b(1'b1),
.q_a(x_out_three), .q_b(y_out_three));*/
//get_coordinates ram_one_write(.address_a(5'd0), .address_b(5'd0), .clock(CLOCK_50), .data_a(x), .data_b(y), .wren_a(1'b0), .wren_b(1'b0), .q_a(x_out), .q_b(y_out));


endmodule


module controlPath(
      input clk,
      output reg next, 
      output reg erase_temp, 
      output reg update_temp , 
      output reg plot_enable, 
      output reg new_reset,
      input resetn,
      input [7:0] plot_count,
      input [7:0] x_count,
      input [6:0] y_count,
      input [25:0] freq
);
      
      
      reg [2:0] current_state, next_state;
      localparam reset = 3'b0,
      write = 3'b001,
      idle_state = 3'b010,
      erase = 3'b011,
      update = 3'b100,
      clear = 3'b101;

      always @(*)
      begin
            case(current_state)
            reset: 
            begin
                next_state = write;
            end

            write: begin
            if (plot_count <= 5'd19) //Count for depth of 20 possible addresses in CAR ROM
                begin
                next_state = write;
                end
            else 
                begin
                next_state = idle_state;
                end
            end
            idle_state: begin
            if (freq < 26'd12499999) 
            begin
                next_state = idle_state;
            end
            else 
            begin
                next_state = erase;
            end
            end
            erase: begin
            if (plot_count <= 5'd19) //We want to erase the same amount of ROM bits that we drew
            begin
                next_state = erase;
            end
            else
            begin
                next_state = update;
            end
            end
            update: 
            begin
                next_state = write;
            end
            clear: 
            begin
            if(x_count == 8'd160 && y_count == 7'd120) 
                begin
                    next_state = reset
                end
                else 
                begin
                    next_state = clear
                end
            end

            default: next_state = reset;
            endcase
      end

      always @(*)
            begin
                  update_temp = 1'b0;
                  next = 1'b0;
                  plot_enable = 1'b0;
                  new_reset = 1'b0;
                  erase_temp = 1'b0;

                  case(current_state)
                      reset: 
                      begin
                        new_reset = 1'b1;
                      end

                      write: 
                      begin
                            next = 1'b1;
                            erase_temp = 1'b0;
                            plot_enable = 1'b1;
                      end

                      erase: 
                      begin
                            next = 1'b1;
                            erase_temp = 1'b1;
                            plot_enable = 1'b1;
                      end

                      update:
                      begin
                      update_temp  = 1'b1;
                      end

                      clear: 
                      begin
                      erase_temp = 1'b1;
                      next = 1'b1;
                      end

                  endcase
      end

      // Control current state
      always @(posedge clk)
      begin
      if (resetn == 1'b0) 
        begin
            current_state <= clear;
        end
      else 
        begin
            current_state <= next_state;
        end
      end
endmodule








module controlPath_left(
input clk, 
output reg next, 
output reg erase_temp, 
output reg update_temp ,
output reg plot_enable, 
output reg new_resetreset 
input resetn,
input [5:0] plot_count,
input [7:0] x_count,
input [25:0] freq,
);


reg [2:0] current_state, next_state;

localparam reset = 3'b0,
write = 3'b001,
idle_state = 3'b010,
erase = 3'b011,
update = 3'b100,
clear = 3'b101;


always @(*)
begin
    case(current_state)
    reset: 
        begin
            next_state = write;
        end

    
    write: begin
    if (plot_count <= 6'd15) 
        begin
            next_state = write;
        end
    else 
        begin
            next_state = idle_state;
        end
    end

    idle_state: 
        begin
            if (freq < 26'd12499999) 
            begin
                next_state = idle_state;
            end
            else
            begin
                next_state = erase;
            end
        end

    erase: 
        begin
        if (plot_count <= 6'd15) 
            begin
                next_state = erase;
            end
        else 
            begin
                next_state = update;
            end
        end

    update: 
        begin
            next_state = write;
        end
    clear: 
        begin
        if(x_count == 8'b00000000) 
            begin
                next_state = reset
            end
            else 
            begin
                next_state = clear
            end
        end
    default: next_state = reset;
endcase
end

always @(*)
            begin
                  update_temp = 1'b0;
                  next = 1'b0;
                  plot_enable = 1'b0;
                  new_reset = 1'b0;
                  erase_temp = 1'b0;

                  case(current_state)
                      reset: 
                      begin
                        new_reset = 1'b1;
                      end

                      write: 
                      begin
                            next = 1'b1;
                            erase_temp = 1'b0;
                            plot_enable = 1'b1;
                      end

                      erase: 
                      begin
                            next = 1'b1;
                            erase_temp = 1'b1;
                            plot_enable = 1'b1;
                      end

                      update:
                      begin
                      update_temp  = 1'b1;
                      end

                      clear: 
                      begin
                      erase_temp = 1'b1;
                      next = 1'b1;
                      end
    
                  endcase
      end

always @(posedge clk)
      begin
      if (resetn == 1'b0) 
        begin
            current_state <= clear;
        end
      else 
        begin
            current_state <= next_state;
        end
      end
endmodule




module controlPath_up(
input clk, 
output reg next, 
output reg erase_temp, 
output reg update_temp , 
output reg plot_enable, 
output reg new_reset,
input resetn,
input [5:0] plot_count,
input [6:0] y_count,
input [25:0] freq,
);


reg [2:0] current_state, next_state;

localparam reset = 3'b0,
write = 3'b001,
idle_state = 3'b010,
erase = 3'b011,
update = 3'b100,
clear = 3'b101;


always @(*)
begin
    case(current_state)
    reset: 
        begin
            next_state = write;
        end

    
    write: begin
    if (plot_count <= 6'd15) 
        begin
            next_state = write;
        end
    else 
        begin
            next_state = idle_state;
        end
    end

    idle_state: 
        begin
            if (freq < 26'd12499999) 
            begin
                next_state = idle_state;
            end
            else
            begin
                next_state = erase;
            end
        end

    erase: 
        begin
        if (plot_count <= 6'd15) 
            begin
                next_state = erase;
            end
        else 
            begin
                next_state = update;
            end
        end

    update: 
        begin
            next_state = write;
        end
    clear: 
        begin
        if(y_count == 7'b00000000) 
            begin
                next_state = reset
            end
            else 
            begin
                next_state = clear
            end
        end
    default: next_state = reset;
endcase
end


always @(*)
            begin
                  update_temp = 1'b0;
                  next = 1'b0;
                  plot_enable = 1'b0;
                  new_reset = 1'b0;
                  erase_temp = 1'b0;

                  case(current_state)
                      reset: 
                      begin
                        new_reset = 1'b1;
                      end

                      write: 
                      begin
                            next = 1'b1;
                            erase_temp = 1'b0;
                            plot_enable = 1'b1;
                      end

                      erase: 
                      begin
                            next = 1'b1;
                            erase_temp = 1'b1;
                            plot_enable = 1'b1;
                      end

                      update:
                      begin
                      update_temp  = 1'b1;
                      end

                      clear: 
                      begin
                      erase_temp = 1'b1;
                      next = 1'b1;
                      end
    
                  endcase
      end

always @(posedge clk)
      begin
      if (resetn == 1'b0) 
        begin
            current_state <= clear;
        end
      else 
        begin
            current_state <= next_state;
        end
      end
endmodule




module block_one(
      input clk, 
      input resetn, 
      input plot_enable, 
      input next, 
      input erase, 
      input update, 
      input reset,
      output reg [7:0] x_total,
      output reg [6:0] y_total ,
      output reg [2:0] output_colour,
      output reg [4:0] plot_count,
      output reg [7:0] x_count,
      output reg [25:0] freq,
      input [2:0] data_in,
      output reg [6:0] y_count
      input selector);
      reg [7:0] x_temp;
      reg [6:0] y_temp;
      reg output_xval;
      reg output_yval;


      always @(posedge clk)
      begin
          if (selector == 2'b00)
          begin
              y_total <= 7'd40;
          end
          else if (selector == 2'b01)
          begin
              y_total <= 7'd60;
          end
          else if (selector == 2'b10)
          begin
               y_total <= 7'd80;
          end

            if(reset || ! resetn) begin   
                  x_total <= 8'd156;
                  x_temp <= 8'd156;
                  y_temp <= 7'd35;
                  plot_count <= 5'd0;
                  x_count<= 8'b0;
                  y_count <= 7'd0;
                  output_colour <= 3'b0;
                  freq <= 25'd0;
                  output_xval <= 1'b0;
                  output_yval <= 1'b1;

            end
            else begin
                  if (erase == 1'b1 && plot_enable == 1'b0) 
                    begin
                        if (x_count == 8'd160 && y_count != 7'd120) 
                        begin
                              x_count <= 8'b00000000;
                              y_count <= y_count + 1'b1;
                        end
                        
                  else begin
                        x_count <= x_count + 1;
                        y_total <= y_count;
                        output_colour <= 3'b000;
                  end
            end
            
            if (erase == 1'b0) 
            begin 
                output_colour <= data_in; //IN this case we want to draw from the ROM
            end
            
            if (freq == 26'd12499999) 
            begin
            freq <= 26'd0;
            end
            
            else freq <= freq + 1'b1;
            
            if (plot_enable == 1'b1) begin
                  if (erase == 1'b1) 
                    begin
                    output_colour <= 3'b000;
                    end
                  else 
                  begin 
                    output_colour <= data_in;
                  end
                  
                  if (plot_count == 5'd20) 
                  begin
                     plot_count <= 5'd0;
                  end

                  else 
                    begin
                        plot_count <= plot_count + 1'b1;
                        y_total <= y_temp + plot_count[3:2];
                        x_total <= x_temp + plot_count[1:0];
                    end
            end
            if (update) 
            begin
                //set bouncing
                if (x_total == 8'b0) 
                begin
                    output_xval = 1'b1;
                end

                if (x_total == 8'd156) 
                begin
                    output_xval = 1'b0;
                end
                //increment based off bouncing
                if (output_xval == 1'b1) 
                begin
                      x_total <= x_total + 1;
                      x_temp <= x_temp + 1;
                end

                if (output_xval == 1'b0)
                begin
                      x_total <= x_total - 1;
                      x_temp <= x_temp - 1;
                end
            end
            end
      end
endmodule




module block_left(
      input clk, 
      input resetn, 
      input plot_enable, 
      input next, 
      input erase, 
      input update, 
      input reset,
      output reg [7:0] x_total,
      output reg [6:0] y_total,
      output reg [2:0] output_colour,
      output reg [5:0] plot_count,
      output reg [7:0] x_count,
      output reg [25:0] freq
      input selector);
      reg [7:0] x_temp;
      reg output_xval;


      always @(posedge clk)
      begin
          if (selector == 2'b00)
          begin
              y_total <= 7'd40;
          end
          else if (selector == 2'b01)
          begin
              y_total <= 7'd60;
          end
          else if (selector == 2'b10)
          begin
               y_total <= 7'd80;
          end
        
          if(reset == 1'b1 || resetn == 1'b0) 
          begin   
              x_total <= 8'd0;     
              x_temp <= 8'd0;
              plot_count<= 6'b0;
              output_colour <= 3'b0;
              freq <= 25'd0;
              output_xval <= 1'b0;
          
          end
          else 
          begin
          if (erase == 1'b1 && plot_enable == 1'b0) 
          begin
              if (x_count == 8'd160) 
                begin
                    x_count <= 8'b00000000;
                  end
              else 
            begin
                  x_count <= x_count + 1'b1;
                  x_total <= x_count;
                  output_colour <= 3'b000;
              end
          end
          if (erase == 1'b0) 
            begin
                output_colour <= 3'b001; // output blue pixel
            end
          if (freq == 26'd12499999) 
            begin
            freq <= 26'd0;
            end
          else 
            begin
            freq <= freq + 1;
            end
          if (plot_enable == 1'b1) 
            begin
              if (erase == 1'b1) 
                begin
                output_colour <= 3'b000;
                end
              else
                begin
                 output_colour <= 3'b001; //blue
                end
              if (plot_count == 6'd16) //reset when plot reaches 16 (using lab 7 logic)
                begin
                    plot_count<= 6'b0; 
                end
              else 
            begin
                plot_count <= plot_count+1;
                x_total <= x_temp + plot_count[1:0];
            end
          end
          if (update == 1'b1) 
            begin
                //set bouncing
              if (x_total == 8'b00000000) 
                begin
                output_xval = 1'b1;
                end


              if (x_total == 8'd156) output_xval = 0;
            //Increment x to move it accross the screen
            //In this case we only need to increment x and not Y
              if (output_xval) 
                begin
                  x_total <= x_total + 1;
                  x_temp <= x_temp + 1;
                  end
                  else
                begin
                    x_total <= x_total - 1;
                    x_temp <= x_temp - 1;
                  end
          end
          end
      end
endmodule


module block_up(
      input clk, 
      input resetn, 
      input plot_enable, 
      input next, 
      input erase, 
      input update, 
      input reset,
      output reg [7:0] x_total,
      output reg [6:0] y_total ,
      output reg [2:0] output_colour,
      output reg [5:0] plot_count,
      output reg [6:0] y_count,
      output reg [25:0] freq,
      input [7:0] keyboard_signal);

      reg [6:0] y_temp;
      reg output_yval;


      always @(posedge clk)
      begin
      if(reset == 1'b1 || resetn == 1'b0) begin   
          x_total <= 8'd0; //Hardcode total x since only moving in one direction
          y_total <= 7'd120; //set starting point of y
          y_temp <= 7'd0;
          plot_count<= 6'b0;
          y_count <= 7'd0;
          output_colour <= 3'b0;
          freq <= 25'd5;
          output_yval <= 1'b1;

          end
          else begin
          if (erase == 1'b1 && plot_enable == 1'b0) begin
          if (y_count != 7'd120) begin
          y_count <= y_count + 1;
          end
          else begin
            y_total <= y_count;
            output_colour <= 3'b000;
          end
          end
          if (erase == 1'b0) 
        begin
            output_colour <= 3'b001;
        end
          if (freq == 26'd12499999) 
            begin
            freq <= 26'd0;
            end

          else  
            begin
                freq <= freq + 1;
            end


          if (plot_enable) 
            begin
              if (erase == 1'b1) begin 
                output_colour <= 3'b000;
            end 
              else
                begin
                 output_colour <= 3'b001; //blue
                end
              if (plot_count == 6'd16) 
                begin
                plot_count<= 6'b0;
                end
              else 
            begin
                plot_count <= plot_count+1;
              y_total <= y_temp + plot_count[3:2];
            end
          end
          if (update == 1'b1) begin

        //set bouncing
          if (y_total == 7'b0) 
            begin
            output_yval = 1;
            end
          if (y_total == 7'd116) 
            begin
            output_yval = 0;
            end
            //Increment based off last wall bounced off
          if (
          keyboard_signal[7:4]==4'h1&&keyboard_signal[3:0]==4'hB
          ) begin //change this to if up true
          y_total <= y_total + 1'b1;
          y_temp <= y_temp + 1'b1;
          end
          if (
          
          keyboard_signal[7:4]==4'h1&&keyboard_signal[3:0]==4'hD
          ) begin //change this to if down true
          y_total <= y_total - 1'b1;
          y_temp <= y_temp - 1'b1;
          end
          end
      end
      end
endmodule
