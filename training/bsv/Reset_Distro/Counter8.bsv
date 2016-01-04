
interface Counter8;
    method Bit#(8) read();
    method Action load(Bit#(8) newval);
    method Action increment();
endinterface

(* synthesize *)
module mkCounter8(Counter8);
   Reg#(Bit#(8)) value <- mkReg(0);

   method Bit#(8) read();
      return value;
   endmethod
   
   method Action load(Bit#(8) newval);
      value <= newval;
   endmethod
   
   method Action increment();
      value <= value + 1;
   endmethod
endmodule
