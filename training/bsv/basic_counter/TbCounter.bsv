import MyCounter::*;
import StmtFSM::*;

(*synthesize*)
module mkTbCounter();

   Counter counter <- mkCounter();
   Reg#(Bit#(16)) state <- mkReg(0);   

   /* check count value */
   function Bool checkval(expected_val);
      return (counter.read() == expected_val);
   endfunction
   
  /* 
  // Stmt testSeq =  seq
//
//      /* test load */
//      counter.load(42);
//      if(checkval(42)) $display("Load passed");
//      else $display("Load failed");
//
//      /* test inc; increment from 42 up to 48 */
//      while(!checkval(48))counter.increment;
//      $display("Increment test complete");
//
//      /* test dec; decrement 48 -> 45 */
//      while(!checkval(45)) 
//	 seq
//	    counter.decrement;
//	    $display("decrement counter");
//	 endseq
//      $display("decrement test complete");
//		      
//      /* tests complete */
//      $display("TESTS Finished");
//   endseq;
//   mkAutoFSM(testSeq);
//		     
/*--------------------------------------------   
/* previous implementation using if-then-else */    
   rule step0(state == 0);
      counter.load(42);
      state <= 1;
   endrule
   rule step1(state == 1);
      if (counter.read() != 42) $display("FAIL: counter.load(42)");
      state <= 2;
   endrule
   rule step2(state == 2);
      if (counter.read() != 42) $display("FAIL: counter.load(42)");
      state <= 3;
   endrule
   rule step3(state == 3);
      if(!checkval(48))
	 begin
	    counter.increment; 
	    $display("Incrementing Counter");
	 end
      else
	 begin
	    $display("Counter passed increment test");
	    state <= 4;
	 end
   endrule
   rule done(state == 4);
      $display("TESTS FINISHED");
      $finish(0);
   endrule
 /*--------------------------------------------------*/
 
endmodule
