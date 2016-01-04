
import Counter8::*;
import Vector::*;
import Clocks::*;


(* synthesize *)
module mkTbResetDistro();

   Reset rst <- exposeCurrentReset;
   Clock clk <- exposeCurrentClock;
   
   Reset rst1 <- mkSyncReset(1,rst,clk);
   Reset rst2 <- mkSyncReset(2,rst,clk);
   
   Reg#(Bit#(16)) state <- mkReg(0);
   
   Reg#(Bit#(1))  reset_pk <- mkReg(1, reset_by rst);

   Reg#(Bit#(1))  reset_d1 <- mkReg(1);

   
   Counter8 counter1 <- mkCounter8(reset_by rst1);
   Counter8 counter2 <- mkCounter8(reset_by rst2);

   
   //startup time
    rule step0(state == 0);
        state <= 1;
    endrule

    rule step1(state == 1);
       reset_d1 <= 1'b0;
       counter1.increment;
       counter2.increment;
       if(counter1.read == 8'h4)
	  state <= 2;
    endrule

    rule step2(state == 2);
        state <= 3;
    endrule

    rule step3(state == 3);
       state <= 4;
    endrule

    rule done(state == 4);
        $display("TESTS FINISHED");
        $finish(0);
    endrule

endmodule
