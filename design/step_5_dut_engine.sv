module dut_engine (
	input clk,
	input rst,
	input start,
	input extra_at_start,
	output logic start_x,
	output logic enable_x,
	input near_end_x,
	output logic start_y,
	output logic enable_y,
	input near_end_y,
	output logic pixel_valid,
	output logic idle
);

	typedef enum {waiting, startup_row_1, startup_row_2, calculate, finish_row_1, finish_row_2} states_t;
	states_t state;

	always @(posedge clk) begin
	// TODO "State machines view"
	//      Right-click in the editor and select **Show In > State Machines**.
	//
	//      Note that this feature, as well as subsequent features in the tutorial,
	//      require an *XPRT* license. An evaluation license includes *XPRT* features.
	//
	//      Double-click on state `calculate` in the State Machines diagram to
	//      navigate to the relevant code in the editor.
		if (rst == 1'b1)
			begin
				state = waiting;
				start_x = 1'b0;
				enable_x = 1'b0;
				start_y = 1'b0;
				enable_y = 1'b0;
				pixel_valid = 1'b0;
			end else
			begin
				case (state)

					waiting : begin
						start_x = 1'b0;
						enable_x = 1'b0;
						start_y = 1'b0;
						enable_y = 1'b0;
						pixel_valid = 1'b0;

						if (start == 1'b1) begin
							state = startup_row_1; // received start
							start_x = 1'b1;
							enable_x = 1'b1;
						end
					end

					startup_row_1 : begin
						start_x = 1'b0;
						if (near_end_x == 1'b1) begin
							start_x = 1'b1;
							if (extra_at_start == 1'b1) begin
								state = startup_row_2; // extra line at start
							end
							else begin
								state = calculate;
							end
						end
					end

					startup_row_2 : begin
						start_x = 1'b0;
						if (near_end_x == 1'b1) begin
							state = calculate;
							start_x = 1'b1;
							start_y = 1'b1;
							enable_y = 1'b1;
						end
					end

					calculate: begin
						start_x = 1'b0;
						start_y = 1'b0;
						enable_y = 1'b0;
						pixel_valid = 1'b1;
						if (near_end_x == 1'b1) begin
							start_x = 1'b1;
							enable_y = 1'b1;
						end
						if (near_end_y == 1'b1 && near_end_x == 1'b1) begin
	// TODO "Fix incorrect state transition"
	//      Note that in the State Diagram, there is no transition out of the state `calculate`.
	//      This is obviously a design flaw.
	//
	//      In the following line, the name of the next state is incomplete.
	//      Place the cursor after `finish_ro`, press **Ctrl+Space** and 
	//      select `finish_row_1`. Note that the state machine graph gets updated
	//      immediately.
							state = finish_row_1; // main calculation done
							start_x = 1'b1;
							enable_y = 1'b1;
						end
					end

	// TODO "State Machines view navigation"
	//      Right-click on the state name `finish_row_1` in the line below and
	//      select **Show in > State Machines**. In the State Machines view, the
	//      corresponding state is highlighted and centered.
	//
	//      In the state machine diagram, double-click on the arrow between
	//      `finish_row_2` and `waiting` to navigate to the relevant line of code.
					finish_row_1 : begin
						start_x = 1'b0;
						enable_y = 1'b0;
						if (near_end_x == 1'b1) begin
							if (extra_at_start == 1'b0) begin
								state = finish_row_2; // extra line at end
								start_x = 1'b1;
							end
							else begin
								enable_x = 1'b0;
								pixel_valid = 1'b0;
								state = waiting; // all done
							end
						end
					end

					finish_row_2 : begin
						start_x = 1'b0;
						if (near_end_x == 1'b1) begin
							enable_x = 1'b0;
							pixel_valid = 1'b0;
	// TODO "State transition labels"
	//      Note that in the State Machines view, transitions are labeled with the
	//      comments from the related line of code. Edit the comments after
	//      `state = waiting` and see that the diagram gets updated as you type.
	//
	//      One can enable or disable state transition comments in the diagram
	//      by clicking respectively the **Hide transition comments** icon
	//      at the top of the State Machines view.
							state = waiting; // edit the label
						end
					end
				endcase
			end
	end
	// TODO "Export the State Diagram"
	//      Click on **Export image** ("floppy disk") icon above the state diagram.
	//      Export the image as either a PNG or SVG image.
	//
	//      Close the State Machines view.
	//      In the project Explorer, open file `step_6_image_testbench.sv`
	//      to continue the tutorial.

	assign idle = (state == waiting);

endmodule
