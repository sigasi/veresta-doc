`timescale 1ns/100ps
`include "class_blockimage.svh"
`include "class_imageserializer.svh"

// Standardized header of my.compa.ny
//
// (c) 2020 MyCo Inc. All rites reversed.
// 
// Top-level testbench of the Imaginary Project
//
// Author: *Sigasi Team*
module image_testbench();
	//
	// **Congratulations**, you've made it to the last part of the tutorial. 
	// 
	// In this last part, we demonstrate SystemVerilog classes, block diagrams
	// and automatic generation of documentation.
	//
	
	logic clk = 1'b0;              // Test clock
	wire rst;                      // Test reset
	wire start;                    // Trigger the design under test
	logic running;                 // Indicates that the test is running
	localparam width  = 80;        // Image width (pixels)
	localparam height = 60;        // Image height (pixels)
	wire [7:0] pixel_out;          // Pixel produced by the design under test
	wire pixel_valid;              // Indicates that the data on `pixel_out` is valid
	imageserializer image_stream;  // The input image, accessible as a stream of pixels 
	logic [7:0] pixel_in;          // Input pixel for the design under test

	// TODO "Close some files in the editor"
	//      At this point, a large number of files are open in the editor, which
	//      clutters up the tab labels at the top.
	//
	//      Right-click the tab of the current file above and select
	//      **Close Tabs to the Left**.

	// Clock generator
	always #5 begin
		clk = ~clk;
	end

	// Initialize the source image
	initial begin
		// TODO "Class Hierarchy view"
		//      Select `blockimage` on the line below and press **F4**.
		//      The Class Hierarchy view opens to the left of the editor.
		//
		//      The top half of the Class Hierarchy view shows how the current
		//      class fits into its class hierarchy. The lower half of the
		//      window shows methods and fields of the current class.
		//
		//      Single-click on any of the classes in the hierarchy to display
		//      its fields and methods. Single-click on `largeblockimage`
		//      and note that only one member `new()` is shown. Click 
		//      **Show Inherited Members** (leftmost icon next to `largeblockimage`)
		//      to also see inherited class fields and methods.
		//
		//      Double-click on class `blockimage` in the hierarchy to navigate 
		//      to its definition in the editor.
		blockimage img;
		img = new(width, height);
		image_stream = new(img);
	end

	// TODO "Block diagram view"
	//      Right-click in the editor and select **Show In > Block Diagram** to open
	//      the block diagram of module `dut_top`.
	//
	//      As in the State Machines view, you can navigate to the relevant HDL code
	//      by double-clicking elements in the Block Diagram view. For example,
	//      double-click the `dut_top_instance` block.

	// Feed data into the DUT 
	always @(posedge clk) begin
		if (start | running) begin
			if (image_stream.hasPixel()) begin
				running = 1'b1;
				pixel_in = image_stream.getPixel();
			end
			else
				running = 1'b0;
		end
		else
			pixel_in = 1'b0;
	end

	// Driver block for reset and start indication
	drive_rst_start drive_rst_start_instance (
		.rst(rst),
		.start(start)
	);

	// DUT instance
	dut_top dut_top_instance (
		.clk(clk),
		.rst(rst),
		.start(start),
		.size_x(width),
		.size_y(height),
		.pixel_in(pixel_in),
		.pixel_out(pixel_out),
		.pixel_valid(pixel_valid)
	);

	// TODO "Generate documentation"
	//      Select **Project > Export > Documentation...** , select
	//      `work.image_testbench : module` as the top level element,
	//      set `Export as:` to **HTML (linked resources)**
	//      and click **Finish** to generate and open the documentation for this
	//      project.
	//
	//      This is the last topic of Sigasi's SystemVerilog tutorial.
	//
	//      The complete manual of Sigasi Studio is available online at
	//      https://insights.sigasi.com/manual (**Ctrl+Click** to open the link in Sigasi Studio)
	//
	//      If further questions remain, feel free to contact Sigasi support on 'support@sigasi.com'.

endmodule
