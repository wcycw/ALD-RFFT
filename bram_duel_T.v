`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:05 03/10/2017 
// Design Name: 
// Module Name:    bram_dual 
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
module bram_duel_T(
	Clk, En, We_A, Addr_A,  DI_A,  DO_A, We_B, Addr_B,  DI_B,  DO_B
    );
parameter WIDTH = 32;

input 		Clk;
input 		En;
input 		We_A;
input		We_B;
input 		[7 : 0]		Addr_A;

input 		[2 * WIDTH - 1 : 0]	DI_A;
output 		[2 * WIDTH - 1 : 0]	DO_A;
reg	 	[2 * WIDTH - 1 : 0]	DO_A;

input 		[7 : 0]		Addr_B;

input 		[2 * WIDTH - 1 : 0]	DI_B;
output 		[2 * WIDTH - 1 : 0]	DO_B;
reg	 	[2 * WIDTH - 1 : 0]	DO_B;

reg 		[2 * WIDTH - 1 : 0]	ram 	 [0 : 255];

initial begin
ram[0] = 64'd1654381667;
ram[1] = 64'd1721899560;
ram[2] = 64'd476277948;
ram[3] = 64'd1131919667;
ram[4] = 64'd1763698143;
ram[5] = 64'd757909860;
ram[6] = 64'd1465506663;
ram[7] = 64'd1280537598;
ram[8] = 64'd2061782999;
ram[9] = 64'd590736201;
ram[10] = 64'd686430126;
ram[11] = 64'd548975998;
ram[12] = 64'd1049850874;
ram[13] = 64'd1117995566;
ram[14] = 64'd1817050159;
ram[15] = 64'd1944561973;
ram[16] = 64'd1846940165;
ram[17] = 64'd1794719417;
ram[18] = 64'd293935757;
ram[19] = 64'd965879799;
ram[20] = 64'd712894120;
ram[21] = 64'd800208227;
ram[22] = 64'd1557073675;
ram[23] = 64'd501533383;
ram[24] = 64'd398253606;
ram[25] = 64'd1889311990;
ram[26] = 64'd973411388;
ram[27] = 64'd594775270;
ram[28] = 64'd1999069752;
ram[29] = 64'd983664549;
ram[30] = 64'd1120960437;
ram[31] = 64'd108029528;
ram[32] = 64'd1028595381;
ram[33] = 64'd359210117;
ram[34] = 64'd667904702;
ram[35] = 64'd577303645;
ram[36] = 64'd411244369;
ram[37] = 64'd1181733737;
ram[38] = 64'd1470150303;
ram[39] = 64'd2016783786;
ram[40] = 64'd203207054;
ram[41] = 64'd801957848;
ram[42] = 64'd898182764;
ram[43] = 64'd1095159785;
ram[44] = 64'd268168058;
ram[45] = 64'd1679859400;
ram[46] = 64'd429428691;
ram[47] = 64'd1862955717;
ram[48] = 64'd385162359;
ram[49] = 64'd908055655;
ram[50] = 64'd1672598003;
ram[51] = 64'd793697191;
ram[52] = 64'd1647757620;
ram[53] = 64'd2060691275;
ram[54] = 64'd1569483756;
ram[55] = 64'd771850991;
ram[56] = 64'd1698377857;
ram[57] = 64'd284006675;
ram[58] = 64'd1591523091;
ram[59] = 64'd1819767052;
ram[60] = 64'd362742390;
ram[61] = 64'd2052758544;
ram[62] = 64'd1388059953;
ram[63] = 64'd1008772710;
ram[64] = 64'd59543905;
ram[65] = 64'd27031833;
ram[66] = 64'd1204967714;
ram[67] = 64'd1121577988;
ram[68] = 64'd1897274597;
ram[69] = 64'd1656961123;
ram[70] = 64'd2125143612;
ram[71] = 64'd340669980;
ram[72] = 64'd448950958;
ram[73] = 64'd1408699195;
ram[74] = 64'd162190;
ram[75] = 64'd578443683;
ram[76] = 64'd244510212;
ram[77] = 64'd1346916373;
ram[78] = 64'd998357984;
ram[79] = 64'd1112903077;
ram[80] = 64'd2126933416;
ram[81] = 64'd357134750;
ram[82] = 64'd146949885;
ram[83] = 64'd180523145;
ram[84] = 64'd1805588451;
ram[85] = 64'd433680200;
ram[86] = 64'd303623482;
ram[87] = 64'd578716702;
ram[88] = 64'd538173251;
ram[89] = 64'd2024192040;
ram[90] = 64'd159680506;
ram[91] = 64'd1543189239;
ram[92] = 64'd1221535054;
ram[93] = 64'd395987258;
ram[94] = 64'd306023153;
ram[95] = 64'd107797906;
ram[96] = 64'd1430691721;
ram[97] = 64'd261359388;
ram[98] = 64'd1063176001;
ram[99] = 64'd1735105767;
ram[100] = 64'd1242183356;
ram[101] = 64'd1687131805;
ram[102] = 64'd250171647;
ram[103] = 64'd2009373950;
ram[104] = 64'd220144928;
ram[105] = 64'd2008964762;
ram[106] = 64'd1932856800;
ram[107] = 64'd539109431;
ram[108] = 64'd578700124;
ram[109] = 64'd259546805;
ram[110] = 64'd663864578;
ram[111] = 64'd1394416281;
ram[112] = 64'd465395056;
ram[113] = 64'd759263818;
ram[114] = 64'd599158652;
ram[115] = 64'd508643381;
ram[116] = 64'd1784389407;
ram[117] = 64'd623633094;
ram[118] = 64'd1681213498;
ram[119] = 64'd1712917307;
ram[120] = 64'd1982890714;
ram[121] = 64'd1792996052;
ram[122] = 64'd1394111260;
ram[123] = 64'd1781358050;
ram[124] = 64'd1215223523;
ram[125] = 64'd1692268091;
ram[126] = 64'd676384569;
ram[127] = 64'd1364507612;
ram[128] = 64'd301568571;
ram[129] = 64'd401565877;
ram[130] = 64'd1724075865;
ram[131] = 64'd546214084;
ram[132] = 64'd1875002510;
ram[133] = 64'd992149492;
ram[134] = 64'd1993476736;
ram[135] = 64'd1471125105;
ram[136] = 64'd1220411824;
ram[137] = 64'd845213471;
ram[138] = 64'd2045965839;
ram[139] = 64'd1039700309;
ram[140] = 64'd168657724;
ram[141] = 64'd2099436875;
ram[142] = 64'd2079237915;
ram[143] = 64'd1897733421;
ram[144] = 64'd778481503;
ram[145] = 64'd1468243397;
ram[146] = 64'd32185702;
ram[147] = 64'd1926698117;
ram[148] = 64'd109339306;
ram[149] = 64'd1567197757;
ram[150] = 64'd1005771444;
ram[151] = 64'd1156873771;
ram[152] = 64'd260529259;
ram[153] = 64'd2143583427;
ram[154] = 64'd1020995517;
ram[155] = 64'd1477314689;
ram[156] = 64'd22051409;
ram[157] = 64'd1250843779;
ram[158] = 64'd1213973170;
ram[159] = 64'd4938043;
ram[160] = 64'd1389310115;
ram[161] = 64'd545408974;
ram[162] = 64'd1228420622;
ram[163] = 64'd157611696;
ram[164] = 64'd1132437921;
ram[165] = 64'd1884058533;
ram[166] = 64'd725389116;
ram[167] = 64'd350208593;
ram[168] = 64'd1850629771;
ram[169] = 64'd1528901696;
ram[170] = 64'd1608968317;
ram[171] = 64'd816420795;
ram[172] = 64'd1311280882;
ram[173] = 64'd1220598260;
ram[174] = 64'd1831159676;
ram[175] = 64'd712529375;
ram[176] = 64'd1112389953;
ram[177] = 64'd2092792936;
ram[178] = 64'd2083704786;
ram[179] = 64'd1810506673;
ram[180] = 64'd1489858768;
ram[181] = 64'd396989756;
ram[182] = 64'd2122621510;
ram[183] = 64'd901374606;
ram[184] = 64'd1053357104;
ram[185] = 64'd2065144707;
ram[186] = 64'd1256387735;
ram[187] = 64'd2049444841;
ram[188] = 64'd1529228454;
ram[189] = 64'd658339082;
ram[190] = 64'd869201830;
ram[191] = 64'd1491389916;
ram[192] = 64'd361190428;
ram[193] = 64'd1738736974;
ram[194] = 64'd2142337289;
ram[195] = 64'd1551990621;
ram[196] = 64'd969990685;
ram[197] = 64'd1085078418;
ram[198] = 64'd481841002;
ram[199] = 64'd140887777;
ram[200] = 64'd1373889045;
ram[201] = 64'd1209006771;
ram[202] = 64'd286532283;
ram[203] = 64'd1089743807;
ram[204] = 64'd1583622633;
ram[205] = 64'd33271913;
ram[206] = 64'd855293571;
ram[207] = 64'd1810998426;
ram[208] = 64'd1164816851;
ram[209] = 64'd615888705;
ram[210] = 64'd370286395;
ram[211] = 64'd2143315406;
ram[212] = 64'd811333864;
ram[213] = 64'd1714577445;
ram[214] = 64'd1967542669;
ram[215] = 64'd1536441377;
ram[216] = 64'd1626851711;
ram[217] = 64'd734913173;
ram[218] = 64'd1507244714;
ram[219] = 64'd544808186;
ram[220] = 64'd1868394941;
ram[221] = 64'd1607886953;
ram[222] = 64'd1969288870;
ram[223] = 64'd820070526;
ram[224] = 64'd375284036;
ram[225] = 64'd239321813;
ram[226] = 64'd44840260;
ram[227] = 64'd2010973370;
ram[228] = 64'd1331793104;
ram[229] = 64'd224646247;
ram[230] = 64'd353221903;
ram[231] = 64'd955723413;
ram[232] = 64'd1813206378;
ram[233] = 64'd1766644116;
ram[234] = 64'd878754190;
ram[235] = 64'd976630911;
ram[236] = 64'd1018207156;
ram[237] = 64'd1857971596;
ram[238] = 64'd368902945;
ram[239] = 64'd366507726;
ram[240] = 64'd912251286;
ram[241] = 64'd1321607869;
ram[242] = 64'd840093362;
ram[243] = 64'd1891639756;
ram[244] = 64'd1441468904;
ram[245] = 64'd1004847721;
ram[246] = 64'd664246839;
ram[247] = 64'd1376625967;
ram[248] = 64'd2111298238;
ram[249] = 64'd1717186685;
ram[250] = 64'd723882762;
ram[251] = 64'd802720679;
ram[252] = 64'd834181499;
ram[253] = 64'd1315206077;
ram[254] = 64'd619357568;
ram[255] = 64'd689408367;

end


always @(posedge Clk) 
	begin
	if (En)
		begin
		if (We_A)
			ram[Addr_A] <= DI_A;
		DO_A <= ram[Addr_A];
		end
	if (En)
		begin
		if (We_B)
			ram[Addr_B] <= DI_B;
		DO_B <= ram[Addr_B];
		end 
	end


endmodule


