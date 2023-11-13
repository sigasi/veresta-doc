// Module pixel_testbench implements a first testbench for the design under test.

module pixel_testbench();
	// TODO "Reset perspective"
	//      Right-click the Sigasi icon in the top right corner and select **Reset**
	//      to reset the Sigasi perspective and start with a cleaner layout.

	// TODO "Validation: severity"
	//      By default, the use of the deprecated `reg` keyword is ignored.
	//      Depending on your project requirements, you may want to change the severity
	//      to `error`, `warning` or `info`.
	//
	//      Go to **Project > Properties > Verilog Errors/Warnings**.
	//      Tick the 'Enable project specific settings' checkbox.
	//      Change the `Disallow 'reg' datatype` severity to `warning` and click `Apply and Close`.
	//      Note that the warning icons have appeared on the next 2 lines to reflect the new severity.
	reg rst;
	reg start;

	// TODO "Quick Fixes"
	//      The lightbulbs combined with the warning markers on the previous lines of code mean that
	//      Sigasi Studio has one or more **Quick Fixes**. These are suggestions on how to solve the problem.
	//      Place your mouse pointer over the marker icon to see the warning message.
	//      Click on the icon to open the Quick Fixes pop-up, and double-click the suggested solution
	//      `Replace reg with logic` to accept it.
	//
	//      Alternatively, use a Quick Fix to suppress the warning.
	reg clk;

	logic [11:0] size_x = 40, size_y = 40;
	logic [23:0] count;
	logic pixel_in, input_pixel;
	typedef enum {IDLE, RUNNING, READY} t_feeder_states;
	t_feeder_states feeder_state;
	// Feed data into the DUT
	always @(posedge clk) begin
		if (rst == 1'b1) begin
			feeder_state = IDLE;
			pixel_in = 0;
			count = 0;
		end
		else begin
			pixel_in = 0;
			// TODO "Validation: case statement"
			//      Place the mouse pointer over the warning-with-lightbulb icon at the left of the
			//      next line of code. A pop-up appears with two warning messages.
			//      * The case statement doesn't cover all cases: `IDLE` is missing.
			//      * The case statement doesn't have a `default` clause.
			//
			//      The line after the `case` line has the choice `ID` with a missing `LE`. Place the
			//      cursor after `ID` and press **Ctrl+Space** to auto-complete the enum value. Now all
			//      cases are covered in the case statement.
			case (feeder_state)
				IDLE:
				if (start) begin
					feeder_state = RUNNING;
					pixel_in = input_pixel;
					count = 1;
				end
				RUNNING:
				if (count < size_x * size_y) begin
					pixel_in = input_pixel;
					count += 1;
				end
				else
					feeder_state = READY;
					// TODO "Validation: case statement (cont'd)"
					//      Place the cursor on the line with `//default :` and press **Ctrl+/** to uncomment.
					//      The warning on the case statement is now gone, but a new warning is flagged on the
					//      default clause. The default clause should be placed after all other cases.
					//
					//      Leave the cursor on the same line and press **Alt+Down** 4 times
					//      to move the default clause to the appropriate place.
				READY: begin
					$display("All done");
					feeder_state = IDLE;
				end
				default : feeder_state = IDLE;
			endcase
		end
	end

	// TODO "Naming conventions"
	//      Sigasi Studio can help to enforce naming conventions of various design items,
	//      e.g. to enforce that instance names start with `inst_`.
	//
	//      Go to **Window > Preferences > Sigasi > Verilog/SystemVerilog > Naming Conventions**.
	//      In the box next to `Instantiation`, enter `inst_\w+` (without the backticks)
	//      and click `Apply and Save`.
	//      Note that a warning marker has appeared in front of the next line of code.
	//
	//      Now add `inst_` in front of `dut_top_instance` so the code adheres to the
	//      naming convention and the warning marker disappears.
	//
	//      The naming conventions are written using regular expressions.
	//      Information on the syntax can be found here: https://www.sigasi.com/app/regex
	//
	//      Go back to **Window > Preferences > Sigasi > Verilog/SystemVerilog > Naming Conventions**,
	//      click `Restore Defaults` and `Apply and Save`.
	dut_top inst_dut_top_instance (
		.clk(clk),
		.rst(rst),
		.start(start),
		.size_x(size_x),
		.size_y(size_y),
		.pixel_in(pixel_in),
		.pixel_out(pixel_out),
		.pixel_valid(pixel_valid)
	);

	// Clock generator
	always #5 begin
		clk = ~clk;
	end

	// TODO "Mixed language design"
	//      Sigasi Studio supports designs that use both (System)Verilog and VHDL.
	//      To add VHDL support to the current project, right-click the tutorial project
	//      in the Project Explorer and select **Configure > Add VHDL support**.
	//
	//      Or, open `drive_rst_start.vhd` from the Project Explorer. A pop-up asks
	//      whether you want to add VHDL support to the project. Click **Yes** and
	//      you're all set.
	//
	//      Now add an instance of a VHDL module.
	//      On the empty line below, type the first characters of `drive_rst_start`,
	//      press **Ctrl+Space**.


	// TODO "Hierarchy view"
	//      Right-click anywhere inside the text of the current module
	//      (`pixel_testbench`), for example on the current line.
	//      Select `Set as Top Level` to set the current design unit as the top level
	//      of the design hierarchy. Now check out the Hierarchy view window to the
	//      right of the editor, under the Outline view.
	//      At the top of the Hierarchy window, click the 2nd icon (**Expand all**,
	//      `+` sign in a box) to see the complete design hierarchy.
	//      Double-click on the `always statement` under `dut_engine`
	//      to navigate to the corresponding code in the editor.

endmodule
