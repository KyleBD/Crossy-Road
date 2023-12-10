
module part2 #(parameter CLOCK_FREQUENCY = 50000000)(input ClockIn, input Reset, input [1:0] Speed, output [3:0] CounterValue);

wire Enable;
RateDivider #(CLOCK_FREQUENCY) div_one(.ClockIn(ClockIn), .Reset(Reset), .Speed(Speed), .Enable(Enable));
DisplayCounter counter_one(.Clock(ClockIn), .Reset(Reset), .EnableDC(Enable), .CounterValue(CounterValue));

endmodule


module RateDivider #(parameter CLOCK_FREQUENCY = 50000000)(input ClockIn, input Reset, input [1:0] Speed, output Enable); 
reg[27:0] RateDividerCount;//28-bit
always@(posedge ClockIn)
begin
if((Reset==1'b1)||(RateDividerCount==28'd0))
begin
case(Speed)
2'b00: RateDividerCount<=28'd0;
2'b01: RateDividerCount<=CLOCK_FREQUENCY - 1'b1;
2'b10: RateDividerCount<=2*CLOCK_FREQUENCY - 1'b1;
2'b11: RateDividerCount<=4*CLOCK_FREQUENCY - 1'b1;
default: RateDividerCount=27'b0;
endcase
end
else
begin
RateDividerCount<= RateDividerCount-1'b1;
end
end
//assign enable = (RateDividerCount== 28'b0)?1'b1:1'b0;
assign Enable = (RateDividerCount == 28'b0)?'1:'0;


endmodule

module DisplayCounter(input Clock, input Reset, input EnableDC, output reg [3:0] CounterValue);
always @(posedge Clock)
    begin
        if(Reset == 1'b1)
            CounterValue <= 4'b0000;
        else if(CounterValue == 4'b1111)
            CounterValue <= 4'b0000;
        else if(EnableDC == 1'b1)
            CounterValue <= CounterValue + 1'b1;
    end
endmodule
