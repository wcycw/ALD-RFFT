
module rfft ( Clk, Reset_n, done );
  input Clk, Reset_n;
  output done;
  wire   N74, N75, N76, N77, N78, N79, N80, N91, N92, N93, N94, N95, N96, n401,
         n403, n404, n405, n406, n408, n409, n410, n411, n412, n413, n414,
         n415, n416, n417, n418, n420, n421, n422, n423, n424, n425, n426,
         n427, n428, n429, n430, n431, n432, n433, n434, n435, n436, n437,
         n438, n439, n440, n441, n442, n443, n444, n445, n446, n447, n448,
         n449, n450, n451, n452, n453, n454, n455, n456, n457, n458, n459,
         n460, n461;
  wire   [3:0] stage;
  wire   [6:0] counter;
  wire   [5:0] w_counter;

  DFFQX1TS w_counter_reg_4_ ( .D(N95), .CK(n457), .Q(w_counter[4]) );
  DFFQX1TS stage_reg_0_ ( .D(n406), .CK(n460), .Q(stage[0]) );
  DFFQX1TS stage_reg_2_ ( .D(n404), .CK(n460), .Q(stage[2]) );
  DFFQX1TS w_counter_reg_2_ ( .D(N93), .CK(n457), .Q(w_counter[2]) );
  DFFQX1TS w_counter_reg_5_ ( .D(N96), .CK(n459), .Q(w_counter[5]) );
  DFFQX1TS counter_reg_3_ ( .D(N77), .CK(n459), .Q(counter[3]) );
  DFFQX1TS counter_reg_5_ ( .D(N79), .CK(n459), .Q(counter[5]) );
  DFFQX1TS w_counter_reg_3_ ( .D(N94), .CK(n458), .Q(w_counter[3]) );
  DFFQX1TS stage_reg_3_ ( .D(n403), .CK(n458), .Q(stage[3]) );
  DFFQX1TS done_reg ( .D(n401), .CK(n457), .Q(done) );
  DFFQX1TS stage_reg_1_ ( .D(n405), .CK(n461), .Q(stage[1]) );
  DFFQX1TS counter_reg_2_ ( .D(N76), .CK(n461), .Q(counter[2]) );
  DFFQX1TS counter_reg_4_ ( .D(N78), .CK(n457), .Q(counter[4]) );
  DFFQX1TS w_counter_reg_1_ ( .D(N92), .CK(n461), .Q(w_counter[1]) );
  DFFQX1TS counter_reg_1_ ( .D(N75), .CK(n460), .Q(counter[1]) );
  DFFQX1TS w_counter_reg_0_ ( .D(N91), .CK(n459), .Q(w_counter[0]) );
  DFFQX1TS counter_reg_0_ ( .D(N74), .CK(n458), .Q(counter[0]) );
  DFFQX1TS counter_reg_6_ ( .D(N80), .CK(n461), .Q(counter[6]) );
  INVX2TS U706 ( .A(Clk), .Y(n409) );
  INVX2TS U707 ( .A(n409), .Y(n458) );
  INVX2TS U708 ( .A(n458), .Y(n408) );
  INVX2TS U709 ( .A(n408), .Y(n457) );
  INVX2TS U710 ( .A(n409), .Y(n459) );
  INVX2TS U711 ( .A(n409), .Y(n460) );
  INVX2TS U712 ( .A(n409), .Y(n461) );
  INVX2TS U713 ( .A(counter[0]), .Y(n410) );
  INVX2TS U714 ( .A(n410), .Y(n416) );
  INVX2TS U715 ( .A(counter[1]), .Y(n444) );
  NOR2XLTS U716 ( .A(n410), .B(n444), .Y(n443) );
  NAND3XLTS U717 ( .A(counter[0]), .B(counter[1]), .C(counter[2]), .Y(n424) );
  OR4X2TS U718 ( .A(counter[4]), .B(counter[5]), .C(counter[2]), .D(counter[3]), .Y(n415) );
  NOR2XLTS U719 ( .A(counter[1]), .B(n415), .Y(n433) );
  INVX2TS U720 ( .A(Reset_n), .Y(n411) );
  INVX2TS U721 ( .A(n411), .Y(n454) );
  INVX2TS U722 ( .A(n454), .Y(n412) );
  AOI31XLTS U723 ( .A0(n416), .A1(counter[6]), .A2(n433), .B0(n412), .Y(n450)
         );
  OAI211XLTS U724 ( .A0(counter[2]), .A1(n443), .B0(n424), .C0(n450), .Y(n413)
         );
  INVX2TS U725 ( .A(n413), .Y(N76) );
  INVX2TS U726 ( .A(counter[3]), .Y(n425) );
  NOR2XLTS U727 ( .A(n425), .B(n424), .Y(n423) );
  NAND2X1TS U728 ( .A(counter[4]), .B(n423), .Y(n426) );
  OAI211XLTS U729 ( .A0(counter[4]), .A1(n423), .B0(n426), .C0(n450), .Y(n414)
         );
  INVX2TS U730 ( .A(n414), .Y(N78) );
  CLKBUFX2TS U731 ( .A(w_counter[0]), .Y(n418) );
  CLKBUFX2TS U732 ( .A(counter[6]), .Y(n451) );
  AOI211XLTS U733 ( .A0(n416), .A1(counter[1]), .B0(n451), .C0(n415), .Y(n417)
         );
  NOR2XLTS U734 ( .A(n412), .B(n417), .Y(n447) );
  INVX2TS U735 ( .A(n447), .Y(n430) );
  NOR2XLTS U736 ( .A(n418), .B(n430), .Y(N91) );
  NOR2XLTS U737 ( .A(n416), .B(n411), .Y(N74) );
  INVX2TS U738 ( .A(stage[0]), .Y(n438) );
  INVX2TS U740 ( .A(w_counter[4]), .Y(n431) );
  AND3X1TS U741 ( .A(w_counter[1]), .B(n418), .C(w_counter[2]), .Y(n428) );
  NAND2X1TS U742 ( .A(n428), .B(w_counter[3]), .Y(n432) );
  NOR2XLTS U743 ( .A(n431), .B(n432), .Y(n449) );
  NAND2X1TS U744 ( .A(n449), .B(w_counter[5]), .Y(n446) );
  OR2X1TS U745 ( .A(1'b0), .B(n446), .Y(n420) );
  NOR2XLTS U746 ( .A(n438), .B(n420), .Y(n440) );
  AOI211XLTS U747 ( .A0(n438), .A1(n420), .B0(n440), .C0(n412), .Y(n406) );
  INVX2TS U748 ( .A(stage[2]), .Y(n437) );
  NAND2X1TS U749 ( .A(stage[1]), .B(n440), .Y(n439) );
  NOR2XLTS U750 ( .A(n437), .B(n439), .Y(n456) );
  AOI211XLTS U751 ( .A0(n437), .A1(n439), .B0(n456), .C0(n412), .Y(n404) );
  NAND2X1TS U752 ( .A(w_counter[1]), .B(w_counter[0]), .Y(n422) );
  INVX2TS U753 ( .A(w_counter[2]), .Y(n421) );
  AOI211XLTS U754 ( .A0(n422), .A1(n421), .B0(n428), .C0(n430), .Y(N93) );
  INVX2TS U755 ( .A(n450), .Y(n442) );
  AOI211XLTS U756 ( .A0(n425), .A1(n424), .B0(n423), .C0(n442), .Y(N77) );
  INVX2TS U757 ( .A(counter[5]), .Y(n427) );
  NOR2XLTS U758 ( .A(n427), .B(n426), .Y(n453) );
  AOI211XLTS U759 ( .A0(n427), .A1(n426), .B0(n453), .C0(n442), .Y(N79) );
  OAI211XLTS U760 ( .A0(n428), .A1(w_counter[3]), .B0(n447), .C0(n432), .Y(
        n429) );
  INVX2TS U761 ( .A(n429), .Y(N94) );
  AOI211XLTS U762 ( .A0(n432), .A1(n431), .B0(n449), .C0(n430), .Y(N95) );
  NOR2BX1TS U763 ( .AN(n433), .B(counter[6]), .Y(n434) );
  NAND4BXLTS U764 ( .AN(stage[3]), .B(stage[1]), .C(N74), .D(n434), .Y(n436)
         );
  NAND2X1TS U765 ( .A(n454), .B(done), .Y(n435) );
  OAI31X1TS U766 ( .A0(n438), .A1(n437), .A2(n436), .B0(n435), .Y(n401) );
  OAI211XLTS U767 ( .A0(stage[1]), .A1(n440), .B0(n454), .C0(n439), .Y(n441)
         );
  INVX2TS U768 ( .A(n441), .Y(n405) );
  AOI211XLTS U769 ( .A0(n410), .A1(n444), .B0(n443), .C0(n442), .Y(N75) );
  OAI21XLTS U770 ( .A0(w_counter[1]), .A1(w_counter[0]), .B0(n447), .Y(n445)
         );
  AOI21X1TS U771 ( .A0(w_counter[1]), .A1(w_counter[0]), .B0(n445), .Y(N92) );
  NAND2X1TS U772 ( .A(n447), .B(n446), .Y(n448) );
  AOI2BB1XLTS U773 ( .A0N(n449), .A1N(w_counter[5]), .B0(n448), .Y(N96) );
  OAI21XLTS U774 ( .A0(n451), .A1(n453), .B0(n450), .Y(n452) );
  AOI21X1TS U775 ( .A0(counter[6]), .A1(n453), .B0(n452), .Y(N80) );
  OAI21XLTS U776 ( .A0(stage[3]), .A1(n456), .B0(n454), .Y(n455) );
  AOI21X1TS U777 ( .A0(stage[3]), .A1(n456), .B0(n455), .Y(n403) );
endmodule

