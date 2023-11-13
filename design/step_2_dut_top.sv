module dut_top(
   input        clk, // core clock
   input        rst, // system reset
   input        start, // start DUT (pulse)
   input [11:0] size_x, // image width
   input [11:0] size_y, // image height
   input  [7:0] pixel_in, // pixel in (streaming input)
   output [7:0] pixel_out, // pixel out (streaming output)
   output       pixel_valid // indicates that the output pixel is valid
);

   wire [7:0] pixel_pp;
   wire [7:0] pixel_p0;
   wire [7:0] pixel_pm;
   wire [7:0] pixel_0p;
   wire [7:0] pixel_0m;
   wire [7:0] pixel_mp;
   wire [7:0] pixel_m0;
   wire [7:0] pixel_mm;
   wire start_x;
   wire enable_x;
   wire near_end_x;
   wire start_y;
   wire enable_y;
   wire near_end_y;
   wire idle;
   wire on_edge_x;
   wire on_edge_y;
   wire on_edge_xy;
   wire [15:0] count_x;
   wire [15:0] endval_x;
   wire [15:0] count_y;
   wire [15:0] endval_y;
   localparam extra_at_start = 1'b0;

   // **Congratulations**, you've made it to the second part of the tutorial.
   // In this part, we'll focus on *Navigating the code*
   // and using the different *Views* of Sigasi Studio.

   counter counter_x_instance (
      .clk(clk),
      .rst(rst),
      .start(start_x),
      .enable(enable_x),
      .endvalue(endval_x),
      .count(count_x),
      .near_end(near_end_x),
      .on_edge(on_edge_x)
   );

   // TODO "Tasks view"
   //      Click on the Tasks tab of the window under the editor window.
   //      You'll see an overview of tasks in the code. i.e. comments starting
   //      with **TODO** (in CAPS). You can double-click a task to navigate
   //      to it. Navigate back here (**Alt+Left**) to continue the tutorial.
   //
   //      Once a task is done, you can remove the **TODO** tags in the code.
   //      The task will disappear from the Tasks view, so your progress becomes
   //      visible.

   // TODO "Problems view"
   //      * Click the **Problems** tab of the window under the editor window.
   //      * Click on the `>` left of `Errors` to open the list of errors.
   //      * Double-click the "mismatched input '==' expecting '='" line
   //        to navigate to the line with the problem.
   //      * Now remove the extraneous '=', the error marker turns grey.
   //      * Press **Ctrl+S** to save the file.
   //        The error marker and the entry in the Problems view are now gone.
   //
   //      Note that in the Problems view, many errors are present in `trouble.sv`.

   assign endval_x = size_x - 1;
   assign endval_y = size_y - 1;
   assign on_edge_xy = on_edge_x | on_edge_y;

   // TODO "Project Explorer" and "Library mapping"
   //      In the window to the left of the editor, navigate to the Project Explorer tab.
   //
   //      By default Sigasi Studio analyzes all (System)Verilog in your project. It may
   //      happen that you want to keep a file in the project but you don't want it to be
   //      analyzed. To exclude a file from a build (e.g. `trouble.sv` which has too many
   //      errors):
   //
   //      * Right-click `trouble.sv`.
   //      * Select **Exclude from Build**.
   //      * Note that the problems view looks much cleaner already.
   //
   //      Further information on the use of projects can be found in
   //      the Sigasi Studio manual: https://insights.sigasi.com/manual/projectsetup/
   //      (Use **Ctrl+Click** to open the link)

   counter counter_y_instance (
      .clk(clk),
      .rst(rst),
      .start(start_y),
      .enable(enable_y),
      .endvalue(endval_y),
      .count(count_y),
      .near_end(near_end_y),
      .on_edge(on_edge_y)
   );

   // TODO "Autocomplete instance"
   //      Add an instance of component `dut_engine`. On an empty line, enter the first
   //      characters of `dut_engine`. Press **Ctrl+Space** and double-click
   //      **dut_engine - Instantiate design unit** to create the instantiation.
   //      Press **Tab** multiple times to go through the instance connections, and **Enter** to
   //      return to normal editing mode. Finally, press **Ctrl+S** to save the file.

   dut_engine dut_engine_instance(
      .clk(clk),
      .rst(rst),
      .start(start),
      .extra_at_start(extra_at_start),
      .start_x(start_x),
      .enable_x(enable_x),
      .near_end_x(near_end_x),
      .start_y(start_y),
      .enable_y(enable_y),
      .near_end_y(near_end_y),
      .pixel_valid(pixel_valid),
      .idle(idle)
   );
   // TODO "Outline view"
   //      Check out the Outline view to the right of the editor window. It gives
   //      an overview of parameters, ports, types, nets and instances in the current file.
   //      Click on any item in the Outline view to navigate to the relevant code in
   //      the editor. This automatic navigation can be enabled or disabled by clicking the
   //      **Link with Editor** icon (2 arrows) in the Outline window.

   // TODO "Validation: instances"
   //      The instance of dut_core below contains a mistake, which is indicated by two
   //      problem markers. Place the mouse pointer over the problem marker or underlined code
   //      to see a pop-up with an explanation of the problem.
   //      One port name was misspelled, which is seen as a missing port connection
   //      (`pixel_mm`) and a duplicate one (`pixel_m0`).
   //
   //      Correct the code as indicated in the comments and press **Ctrl+S** to save the file.

   dut_core dut_core_instance (
      .pixel_out(pixel_out),
      .pixel_pp(pixel_pp),
      .pixel_p0(pixel_p0),
      .pixel_pm(pixel_pm),
      .pixel_0p(pixel_0p),
      .pixel_0m(pixel_0m),
      .pixel_mp(pixel_mp),
      .pixel_m0(pixel_m0),
      .pixel_mm(pixel_mm), // replace `pixel_m0` with `pixel_mm`
      .on_edge(on_edge_xy),
      .clock(clk),
      .reset(rst)
   );

   // TODO "Open declaration"
   //      On the line below, select `pixelbuffer` and press **F3** to navigate to the
   //      declaration of module `pixelbuffer`.

   pixelbuffer pixelbuffer_instance (
      .clk(clk),
      .rst(rst),
      .size_x(size_x),
      .pixel_in(pixel_in),
      .pixel_in_valid(1'b1),
      .pixel_pp(pixel_pp),
      .pixel_p0(pixel_p0),
      .pixel_pm(pixel_pm),
      .pixel_0p(pixel_0p),
      .pixel_0m(pixel_0m),
      .pixel_mp(pixel_mp),
      .pixel_m0(pixel_m0),
      .pixel_mm(pixel_mm)
   );

endmodule
