module rfft (
	Clk, Reset_n,
	done,
	Din0, Din1, Din2, Din3,
	Dout0, Dout1, Dout2, Dout3,
	Tf_in, Addr_T, Tf_we,
	Addr, Input, Write 
);

parameter WIDTH = 16;
parameter LIMIT = 63;  // 256/4-1
parameter VALID = 2;   // clock for to be valide

input 					Clk;
input 					Reset_n;
input		[WIDTH - 1 : 0]		Din0;
input		[WIDTH - 1 : 0]		Din1;
input		[WIDTH - 1 : 0]		Din2;
input		[WIDTH - 1 : 0]		Din3;

input 		[2 * WIDTH - 1 : 0]	Tf_in;
input 					Tf_we;
input 		[7 : 0]			Addr_T;

input 		[5 : 0]			Addr;
input 					Input;
input 					Write;

output 		reg			done;
output		[WIDTH - 1 : 0]		Dout0;
output		[WIDTH - 1 : 0]		Dout1;
output		[WIDTH - 1 : 0]		Dout2;
output		[WIDTH - 1 : 0]		Dout3;

reg					fin;
reg 		[3 : 0]			stage;
reg 		[6 : 0]			counter;
reg 		[6 : 0]			w_counter;


reg		[5 : 0]			addr		[0 : 1];
reg		[5 : 0]			w_addr		[0 : 1];
reg		[WIDTH - 1 : 0]		ram_in		[0 : 3];
wire		[WIDTH - 1 : 0] 	ram_out		[0 : 3];
wire					we ;

reg 		[7 : 0] 		tf_addr;
wire		[2* WIDTH - 1 : 0]	tf_out;


wire					bypass_n;
reg		[WIDTH - 1 : 0] 	in 		[0 : 3];
wire		[WIDTH - 1 : 0] 	out 		[0 : 3];

//A_port for Read, B_port for write 
bram_duel ram0(.Clk(Clk), .En(1'b1), .We_A(1'b0), .Addr_A(addr[0]), .DI_A(32'd0), .DO_A(ram_out[0]), .We_B(we), .Addr_B(w_addr[0]), .DI_B(ram_in[0]), .DO_B());
bram_duel ram1(.Clk(Clk), .En(1'b1), .We_A(1'b0), .Addr_A(addr[0]), .DI_A(32'd0), .DO_A(ram_out[1]), .We_B(we), .Addr_B(w_addr[0]), .DI_B(ram_in[1]), .DO_B());
bram_duel ram2(.Clk(Clk), .En(1'b1), .We_A(1'b0), .Addr_A(addr[1]), .DI_A(32'd0), .DO_A(ram_out[2]), .We_B(we), .Addr_B(w_addr[1]), .DI_B(ram_in[2]), .DO_B());
bram_duel ram3(.Clk(Clk), .En(1'b1), .We_A(1'b0), .Addr_A(addr[1]), .DI_A(32'd0), .DO_A(ram_out[3]), .We_B(we), .Addr_B(w_addr[1]), .DI_B(ram_in[3]), .DO_B());

bram_duel_T tfram(.Clk(Clk), .En(1'b1), .We_A(Tf_we), .Addr_A(tf_addr), .DI_A(Tf_in), .DO_A(tf_out), .We_B(1'b0), .Addr_B(8'd0), .DI_B(64'd0), .DO_B());

pe pe0 (
	.Clk(Clk), .Reset_n(Reset_n),
	.in0(in[0]), .in1(in[1]), .in2(in[2]), .in3(in[3]), 
	.out0(out[0]), .out1(out[1]), .out2(out[2]), .out3(out[3]), 
	.tf(tf_out), .bypass_n(bypass_n)
	);

assign bypass_n = (stage >= 3'd6) ? 0 : 1;
assign we = (Input == 1'b1) ? Write : (counter >= VALID) ? 1 : 0;


assign Dout0 = ram_out[0];
assign Dout1 = ram_out[1];
assign Dout2 = ram_out[2];
assign Dout3 = ram_out[3];

always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0 || Input == 1'b1)
		done <= 0;
	else if (stage == 3'd7 && counter == 0)
		done <= 1;
	else
		done <= done;
	end

always @ (posedge Clk)
	begin 
	if (Reset_n == 1'b0 || counter == (LIMIT + VALID) || Input == 1'b1)
		counter <= 0;
	else	
		counter <= counter + 1'b1;
	end

always @ (posedge Clk)
	begin 
	if (Reset_n == 1'b0 || counter <= VALID || w_counter == LIMIT || Input == 1'b1)
		w_counter <= 0;
	else	
		w_counter <= w_counter + 1'b1;
	end

always @ (posedge Clk)
	begin 
	if (Reset_n == 1'b0 || Input == 1'b1)
		stage <= 0;
	else if (w_counter == LIMIT)	
		stage <= stage + 1'b1;
	else 
		stage <= stage;
	end

always @ (*)
	begin
	if (Input == 1'b1)
		begin
		  addr[0] = Addr;
		  addr[1] = Addr;
		w_addr[0] = Addr;
		w_addr[1] = Addr;
		end
	else
		begin
	  	  addr[0] = (stage == 3'd7) ? 0 : counter[5 : 0];
		w_addr[0] = (stage == 3'd7) ? 0 : w_counter[5 : 0];
		case (stage)
			3'd0:	
				begin
				  addr[1] = counter[5:0];
				w_addr[1] = w_counter[5:0];
				end
			3'd1:
				begin
				  addr[1] = { ~counter[5] , counter[4:0]};
				w_addr[1] = { ~w_counter[5] , w_counter[4:0]}; 
				end
			3'd2:
				begin
				  addr[1] = { ~counter[5:4] , counter[3:0]};
				w_addr[1] = { ~w_counter[5:4] , w_counter[3:0]}; 
				end 
			3'd3:
				begin
				  addr[1] = { ~counter[5:3] , counter[2:0]}; 
				w_addr[1] = { ~w_counter[5:3] , w_counter[2:0]}; 
				end
			3'd4:
				begin
				  addr[1] = { ~counter[5:2] , counter[1:0]}; 
				w_addr[1] = { ~w_counter[5:2] , w_counter[1:0]}; 
				end
			3'd5:
				begin
				  addr[1] = { ~counter[5:1] , counter[0]};
				w_addr[1] = { ~w_counter[5:1] , w_counter[0]};
				end 
			3'd6:
				begin
				  addr[1] = ~counter[5:0]; 
				w_addr[1] = ~w_counter[5:0]; 
				end
			3'd7:
				begin
				  addr[1] = 0;
				w_addr[1] = 0;
				end
			endcase
		end
	end

always @ (*)
	begin
	if (Input == 1'b1)
		tf_addr = Addr_T;
	else
		begin
		case (stage)
			3'd0:
			begin
				tf_addr = counter;
			end
			3'd1:
			begin
				tf_addr = (counter[5]   == 0) ? {2'd0, counter[4 : 0], 1'd0} : {1'd0, counter[4 : 0], 2'd0};
			end
			3'd2:
			begin
				tf_addr = (counter[5:4] == 0) ? {2'd0, counter[3 : 0], 2'd0} : {1'd0, counter[3 : 0], 3'd0};
			end
			3'd3:
			begin
				tf_addr = (counter[5:3] == 0) ? {2'd0, counter[2 : 0], 3'd0} : {1'd0, counter[2 : 0], 4'd0};
			end
			3'd4:
			begin
				tf_addr = (counter[5:2] == 0) ? {2'd0, counter[1 : 0], 4'd0} : {1'd0, counter[1 : 0], 5'd0};
			end
			3'd5:
			begin
				tf_addr = (counter[5:1] == 0) ? {2'd0, counter[0], 5'd0} : {1'd0, counter[0], 6'd0};
			end
			3'd6:
			begin
				tf_addr = 0;
			end
			3'd7:
			begin
				tf_addr = 0;
			end
		endcase
		end
	end

always @ (*)
	begin
	case (stage)
		3'd0:
		begin
			in[0] = ram_out[0];
			in[1] = ram_out[2];
			in[2] = ram_out[1];
			in[3] = ram_out[3];
		end
		3'd1:
		begin
			in[0] = (counter[5]) ? ram_out[2] : ram_out[0];
			in[1] = (counter[5]) ? ram_out[0] : ram_out[1];
			in[2] = (counter[5]) ? ram_out[3] : ram_out[2];
			in[3] = (counter[5]) ? ram_out[1] : ram_out[3];
		end
		3'd2:
		begin
			in[0] = (counter[5:4] == 2'b0) ? ram_out[0] : (counter[4]) ? ram_out[2] : ram_out[0];
			in[1] = (counter[5:4] == 2'b0) ? ram_out[1] : (counter[4]) ? ram_out[0] : ram_out[2];
			in[2] = (counter[5:4] == 2'b0) ? ram_out[2] : (counter[4]) ? ram_out[3] : ram_out[1];
			in[3] = (counter[5:4] == 2'b0) ? ram_out[3] : (counter[4]) ? ram_out[1] : ram_out[3];
		end
		3'd3:
		begin
			in[0] = (counter[5:3] == 2'b0) ? ram_out[0] : (counter[3]) ? ram_out[2] : ram_out[0];
			in[1] = (counter[5:3] == 2'b0) ? ram_out[1] : (counter[3]) ? ram_out[0] : ram_out[2];
			in[2] = (counter[5:3] == 2'b0) ? ram_out[2] : (counter[3]) ? ram_out[3] : ram_out[1];
			in[3] = (counter[5:3] == 2'b0) ? ram_out[3] : (counter[3]) ? ram_out[1] : ram_out[3];
		end
		3'd4:
		begin
			in[0] = (counter[5:2] == 2'b0) ? ram_out[0] : (counter[2]) ? ram_out[2] : ram_out[0];
			in[1] = (counter[5:2] == 2'b0) ? ram_out[1] : (counter[2]) ? ram_out[0] : ram_out[2];
			in[2] = (counter[5:2] == 2'b0) ? ram_out[2] : (counter[2]) ? ram_out[3] : ram_out[1];
			in[3] = (counter[5:2] == 2'b0) ? ram_out[3] : (counter[2]) ? ram_out[1] : ram_out[3];
		end
		3'd5:
		begin
			in[0] = (counter[5:1] == 2'b0) ? ram_out[0] : (counter[1]) ? ram_out[2] : ram_out[0];
			in[1] = (counter[5:1] == 2'b0) ? ram_out[1] : (counter[1]) ? ram_out[0] : ram_out[2];
			in[2] = (counter[5:1] == 2'b0) ? ram_out[2] : (counter[1]) ? ram_out[3] : ram_out[1];
			in[3] = (counter[5:1] == 2'b0) ? ram_out[3] : (counter[1]) ? ram_out[1] : ram_out[3];
		end
		3'd6:
		begin
			in[0] = (counter[5:0] == 2'b0) ? ram_out[0] : (counter[0]) ? ram_out[2] : ram_out[0];
			in[1] = (counter[5:0] == 2'b0) ? ram_out[1] : (counter[0]) ? ram_out[0] : ram_out[2];
			in[2] = (counter[5:0] == 2'b0) ? ram_out[2] : (counter[0]) ? ram_out[3] : ram_out[1];
			in[3] = (counter[5:0] == 2'b0) ? ram_out[3] : (counter[0]) ? ram_out[1] : ram_out[3];
		end
		3'd7:
		begin
			in[0] = ram_out[0];
			in[1] = ram_out[1];
			in[2] = ram_out[2];
			in[3] = ram_out[3];
		end
	endcase
	end

always @ (*)
	begin
	if (Input == 1'b1)
		begin
		ram_in[0] = Din0;
		ram_in[1] = Din1;
		ram_in[2] = Din2;
		ram_in[3] = Din3;
		end
	else 
		begin
		case (stage)
			3'd0:
			begin
				ram_in[0] = (counter[5]) ? out[2] : out[0];
				ram_in[1] = (counter[5]) ? out[3] : out[1];
				ram_in[2] = (counter[5]) ? out[0] : out[2];
				ram_in[3] = (counter[5]) ? out[1] : out[3];
			end
			3'd1:
			begin
				ram_in[0] = (counter[4]) ? out[2] : out[0];
				ram_in[1] = (counter[4]) ? out[3] : out[1];
				ram_in[2] = (counter[4]) ? out[0] : out[2];
				ram_in[3] = (counter[4]) ? out[1] : out[3];
			end
			3'd2:
			begin
				ram_in[0] = (counter[3]) ? out[2] : out[0];
				ram_in[1] = (counter[3]) ? out[3] : out[1];
				ram_in[2] = (counter[3]) ? out[0] : out[2];
				ram_in[3] = (counter[3]) ? out[1] : out[3];
			end
			3'd3:
			begin
				ram_in[0] = (counter[2]) ? out[2] : out[0];
				ram_in[1] = (counter[2]) ? out[3] : out[1];
				ram_in[2] = (counter[2]) ? out[0] : out[2];
				ram_in[3] = (counter[2]) ? out[1] : out[3];
			end
			3'd4:
			begin
				ram_in[0] = (counter[1]) ? out[2] : out[0];
				ram_in[1] = (counter[1]) ? out[3] : out[1];
				ram_in[2] = (counter[1]) ? out[0] : out[2];
				ram_in[3] = (counter[1]) ? out[1] : out[3];
			end
			3'd5:
			begin
				ram_in[0] = (counter[0]) ? out[2] : out[0];
				ram_in[1] = (counter[0]) ? out[3] : out[1];
				ram_in[2] = (counter[0]) ? out[0] : out[2];
				ram_in[3] = (counter[0]) ? out[1] : out[3];
			end
			3'd6:
			begin
				ram_in[0] = out[0];
				ram_in[1] = out[1];
				ram_in[2] = out[2];
				ram_in[3] = out[3];
			end
			3'd7:
			begin
				ram_in[0] = out[0];
				ram_in[1] = out[1];
				ram_in[2] = out[2];
				ram_in[3] = out[3];
			end
		endcase
		end
	end


endmodule

