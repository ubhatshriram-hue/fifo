
`define DATA_WIDTH 8
`define ADDR_WIDTH 8




interface my_if( input logic clk,rst);
logic wr_cs;
logic rd_cs;
logic wr_en;
logic rd_en;
logic [`DATA_WIDTH -1 :0] data_in;
logic [`DATA_WIDTH -1 :0] data_out;
logic full;
logic empty;

clocking cbdrv @(posedge clk);
default input #1 output #1;
output wr_cs,rd_cs,wr_en,rd_en;
output data_in;
endclocking

clocking cbmoni @(posedge clk);
default input #1 output #1;
input wr_cs,rd_cs,wr_en,rd_en,rst;
input data_in;
endclocking

clocking cbmono @(posedge clk);
default input #1 output #1;
input wr_cs,rd_cs,wr_en,rd_en,rst;
input data_in;
input data_out;
input full,empty;
endclocking

modport drv(clocking cbdrv);
modport moni(clocking cbmoni);
modport mono(clocking cbmono);

endinterface

