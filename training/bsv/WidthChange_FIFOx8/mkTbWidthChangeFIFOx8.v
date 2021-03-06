//
// Generated by Bluespec Compiler, version 2014.07.A (build 34078, 2014-07-30)
//
// On Tue Nov  3 13:57:05 EST 2015
//
//
// Ports:
// Name                         I/O  size props
// CLK                            I     1 clock
// RST_N                          I     1 reset
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkTbWidthChangeFIFOx8(CLK,
			     RST_N);
  input  CLK;
  input  RST_N;

  // register state
  reg [15 : 0] state;
  reg [15 : 0] state$D_IN;
  wire state$EN;

  // ports of submodule wc_fifo
  wire [83 : 0] wc_fifo$pio_0_request_put,
		wc_fifo$pio_1_request_put,
		wc_fifo$pio_2_request_put,
		wc_fifo$pio_3_request_put;
  wire [63 : 0] wc_fifo$pio_0_response_get,
		wc_fifo$pio_1_response_get,
		wc_fifo$pio_2_response_get,
		wc_fifo$pio_3_response_get;
  wire wc_fifo$EN_pio_0_request_put,
       wc_fifo$EN_pio_0_response_get,
       wc_fifo$EN_pio_1_request_put,
       wc_fifo$EN_pio_1_response_get,
       wc_fifo$EN_pio_2_request_put,
       wc_fifo$EN_pio_2_response_get,
       wc_fifo$EN_pio_3_request_put,
       wc_fifo$EN_pio_3_response_get,
       wc_fifo$RDY_pio_0_request_put,
       wc_fifo$RDY_pio_0_response_get,
       wc_fifo$RDY_pio_1_request_put,
       wc_fifo$RDY_pio_1_response_get,
       wc_fifo$RDY_pio_2_request_put,
       wc_fifo$RDY_pio_2_response_get,
       wc_fifo$RDY_pio_3_request_put,
       wc_fifo$RDY_pio_3_response_get;

  // rule scheduling signals
  wire CAN_FIRE_RL_done,
       CAN_FIRE_RL_step0,
       CAN_FIRE_RL_step1,
       CAN_FIRE_RL_step2,
       CAN_FIRE_RL_step3,
       CAN_FIRE_RL_step4,
       CAN_FIRE_RL_step5,
       WILL_FIRE_RL_done,
       WILL_FIRE_RL_step0,
       WILL_FIRE_RL_step1,
       WILL_FIRE_RL_step2,
       WILL_FIRE_RL_step3,
       WILL_FIRE_RL_step4,
       WILL_FIRE_RL_step5;

  // submodule wc_fifo
  mkWCFIFOx8 wc_fifo(.CLK(CLK),
		     .RST_N(RST_N),
		     .pio_0_request_put(wc_fifo$pio_0_request_put),
		     .pio_1_request_put(wc_fifo$pio_1_request_put),
		     .pio_2_request_put(wc_fifo$pio_2_request_put),
		     .pio_3_request_put(wc_fifo$pio_3_request_put),
		     .EN_pio_0_request_put(wc_fifo$EN_pio_0_request_put),
		     .EN_pio_0_response_get(wc_fifo$EN_pio_0_response_get),
		     .EN_pio_1_request_put(wc_fifo$EN_pio_1_request_put),
		     .EN_pio_1_response_get(wc_fifo$EN_pio_1_response_get),
		     .EN_pio_2_request_put(wc_fifo$EN_pio_2_request_put),
		     .EN_pio_2_response_get(wc_fifo$EN_pio_2_response_get),
		     .EN_pio_3_request_put(wc_fifo$EN_pio_3_request_put),
		     .EN_pio_3_response_get(wc_fifo$EN_pio_3_response_get),
		     .RDY_pio_0_request_put(wc_fifo$RDY_pio_0_request_put),
		     .pio_0_response_get(wc_fifo$pio_0_response_get),
		     .RDY_pio_0_response_get(wc_fifo$RDY_pio_0_response_get),
		     .RDY_pio_1_request_put(wc_fifo$RDY_pio_1_request_put),
		     .pio_1_response_get(wc_fifo$pio_1_response_get),
		     .RDY_pio_1_response_get(wc_fifo$RDY_pio_1_response_get),
		     .RDY_pio_2_request_put(wc_fifo$RDY_pio_2_request_put),
		     .pio_2_response_get(wc_fifo$pio_2_response_get),
		     .RDY_pio_2_response_get(wc_fifo$RDY_pio_2_response_get),
		     .RDY_pio_3_request_put(wc_fifo$RDY_pio_3_request_put),
		     .pio_3_response_get(wc_fifo$pio_3_response_get),
		     .RDY_pio_3_response_get(wc_fifo$RDY_pio_3_response_get));

  // rule RL_step0
  assign CAN_FIRE_RL_step0 = state == 16'd0 ;
  assign WILL_FIRE_RL_step0 = CAN_FIRE_RL_step0 ;

  // rule RL_step1
  assign CAN_FIRE_RL_step1 =
	     wc_fifo$RDY_pio_0_request_put && wc_fifo$RDY_pio_1_request_put &&
	     state == 16'd1 ;
  assign WILL_FIRE_RL_step1 = CAN_FIRE_RL_step1 ;

  // rule RL_step2
  assign CAN_FIRE_RL_step2 =
	     wc_fifo$RDY_pio_0_response_get &&
	     wc_fifo$RDY_pio_1_response_get &&
	     state == 16'd2 ;
  assign WILL_FIRE_RL_step2 = CAN_FIRE_RL_step2 ;

  // rule RL_step3
  assign CAN_FIRE_RL_step3 =
	     wc_fifo$RDY_pio_0_request_put && wc_fifo$RDY_pio_1_request_put &&
	     wc_fifo$RDY_pio_2_request_put &&
	     wc_fifo$RDY_pio_3_request_put &&
	     state == 16'd3 ;
  assign WILL_FIRE_RL_step3 = CAN_FIRE_RL_step3 ;

  // rule RL_step4
  assign CAN_FIRE_RL_step4 =
	     wc_fifo$RDY_pio_0_response_get &&
	     wc_fifo$RDY_pio_1_response_get &&
	     state == 16'd4 ;
  assign WILL_FIRE_RL_step4 = CAN_FIRE_RL_step4 ;

  // rule RL_step5
  assign CAN_FIRE_RL_step5 =
	     wc_fifo$RDY_pio_2_response_get &&
	     wc_fifo$RDY_pio_3_response_get &&
	     state == 16'd5 ;
  assign WILL_FIRE_RL_step5 = CAN_FIRE_RL_step5 ;

  // rule RL_done
  assign CAN_FIRE_RL_done = state == 16'd6 ;
  assign WILL_FIRE_RL_done = CAN_FIRE_RL_done ;

  // register state
  always@(WILL_FIRE_RL_step0 or
	  WILL_FIRE_RL_step1 or
	  WILL_FIRE_RL_step2 or
	  WILL_FIRE_RL_step3 or WILL_FIRE_RL_step4 or WILL_FIRE_RL_step5)
  begin
    case (1'b1) // synopsys parallel_case
      WILL_FIRE_RL_step0: state$D_IN = 16'd1;
      WILL_FIRE_RL_step1: state$D_IN = 16'd2;
      WILL_FIRE_RL_step2: state$D_IN = 16'd3;
      WILL_FIRE_RL_step3: state$D_IN = 16'd4;
      WILL_FIRE_RL_step4: state$D_IN = 16'd5;
      WILL_FIRE_RL_step5: state$D_IN = 16'd6;
      default: state$D_IN = 16'b1010101010101010 /* unspecified value */ ;
    endcase
  end
  assign state$EN =
	     WILL_FIRE_RL_step0 || WILL_FIRE_RL_step1 || WILL_FIRE_RL_step2 ||
	     WILL_FIRE_RL_step3 ||
	     WILL_FIRE_RL_step4 ||
	     WILL_FIRE_RL_step5 ;

  // submodule wc_fifo
  assign wc_fifo$pio_0_request_put =
	     WILL_FIRE_RL_step1 ?
	       84'hC0010000055AA11223344 :
	       84'hC00140000000022334455 ;
  assign wc_fifo$pio_1_request_put =
	     WILL_FIRE_RL_step1 ?
	       84'hC0010000055AA11223344 :
	       84'hC00140000000022334455 ;
  assign wc_fifo$pio_2_request_put = 84'hC001400000000BBBBBBBB ;
  assign wc_fifo$pio_3_request_put = 84'hC001400000000BBBBBBBB ;
  assign wc_fifo$EN_pio_0_request_put =
	     WILL_FIRE_RL_step1 || WILL_FIRE_RL_step3 ;
  assign wc_fifo$EN_pio_0_response_get =
	     WILL_FIRE_RL_step4 || WILL_FIRE_RL_step2 ;
  assign wc_fifo$EN_pio_1_request_put =
	     WILL_FIRE_RL_step1 || WILL_FIRE_RL_step3 ;
  assign wc_fifo$EN_pio_1_response_get =
	     WILL_FIRE_RL_step4 || WILL_FIRE_RL_step2 ;
  assign wc_fifo$EN_pio_2_request_put = CAN_FIRE_RL_step3 ;
  assign wc_fifo$EN_pio_2_response_get = CAN_FIRE_RL_step5 ;
  assign wc_fifo$EN_pio_3_request_put = CAN_FIRE_RL_step3 ;
  assign wc_fifo$EN_pio_3_response_get = CAN_FIRE_RL_step5 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        state <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (state$EN) state <= `BSV_ASSIGNMENT_DELAY state$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    state = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_step2)
	$display("BRAM01 Read = %x %x",
		 wc_fifo$pio_0_response_get,
		 wc_fifo$pio_1_response_get);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_step4)
	$display("BRAM01 Read = %x %x",
		 wc_fifo$pio_0_response_get,
		 wc_fifo$pio_1_response_get);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_step5)
	$display("BRAM23 Read = %x %x",
		 wc_fifo$pio_2_response_get,
		 wc_fifo$pio_3_response_get);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_done) $display("TESTS FINISHED");
    if (RST_N != `BSV_RESET_VALUE) if (WILL_FIRE_RL_done) $finish(32'd0);
  end
  // synopsys translate_on
endmodule  // mkTbWidthChangeFIFOx8

