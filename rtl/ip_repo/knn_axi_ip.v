
`timescale 1 ns / 1 ps

	module knn_axi_ip #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface knn_axi_ip
		parameter integer C_knn_axi_ip_DATA_WIDTH	= 32,
		parameter integer C_knn_axi_ip_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface knn_axi_ip
		input wire  knn_axi_ip_aclk,
		input wire  knn_axi_ip_aresetn,
		input wire [C_knn_axi_ip_ADDR_WIDTH-1 : 0] knn_axi_ip_awaddr,
		input wire [2 : 0] knn_axi_ip_awprot,
		input wire  knn_axi_ip_awvalid,
		output wire  knn_axi_ip_awready,
		input wire [C_knn_axi_ip_DATA_WIDTH-1 : 0] knn_axi_ip_wdata,
		input wire [(C_knn_axi_ip_DATA_WIDTH/8)-1 : 0] knn_axi_ip_wstrb,
		input wire  knn_axi_ip_wvalid,
		output wire  knn_axi_ip_wready,
		output wire [1 : 0] knn_axi_ip_bresp,
		output wire  knn_axi_ip_bvalid,
		input wire  knn_axi_ip_bready,
		input wire [C_knn_axi_ip_ADDR_WIDTH-1 : 0] knn_axi_ip_araddr,
		input wire [2 : 0] knn_axi_ip_arprot,
		input wire  knn_axi_ip_arvalid,
		output wire  knn_axi_ip_arready,
		output wire [C_knn_axi_ip_DATA_WIDTH-1 : 0] knn_axi_ip_rdata,
		output wire [1 : 0] knn_axi_ip_rresp,
		output wire  knn_axi_ip_rvalid,
		input wire  knn_axi_ip_rready
	);
// Instantiation of Axi Bus Interface knn_axi_ip
	knn_axi_ip_slave_lite_v1_0_knn_axi_ip # ( 
		.C_S_AXI_DATA_WIDTH(C_knn_axi_ip_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_knn_axi_ip_ADDR_WIDTH)
	) knn_axi_ip_slave_lite_v1_0_knn_axi_ip_inst (
		.S_AXI_ACLK(knn_axi_ip_aclk),
		.S_AXI_ARESETN(knn_axi_ip_aresetn),
		.S_AXI_AWADDR(knn_axi_ip_awaddr),
		.S_AXI_AWPROT(knn_axi_ip_awprot),
		.S_AXI_AWVALID(knn_axi_ip_awvalid),
		.S_AXI_AWREADY(knn_axi_ip_awready),
		.S_AXI_WDATA(knn_axi_ip_wdata),
		.S_AXI_WSTRB(knn_axi_ip_wstrb),
		.S_AXI_WVALID(knn_axi_ip_wvalid),
		.S_AXI_WREADY(knn_axi_ip_wready),
		.S_AXI_BRESP(knn_axi_ip_bresp),
		.S_AXI_BVALID(knn_axi_ip_bvalid),
		.S_AXI_BREADY(knn_axi_ip_bready),
		.S_AXI_ARADDR(knn_axi_ip_araddr),
		.S_AXI_ARPROT(knn_axi_ip_arprot),
		.S_AXI_ARVALID(knn_axi_ip_arvalid),
		.S_AXI_ARREADY(knn_axi_ip_arready),
		.S_AXI_RDATA(knn_axi_ip_rdata),
		.S_AXI_RRESP(knn_axi_ip_rresp),
		.S_AXI_RVALID(knn_axi_ip_rvalid),
		.S_AXI_RREADY(knn_axi_ip_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
