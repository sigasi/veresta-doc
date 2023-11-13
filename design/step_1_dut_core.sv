////////////////////////////////////////////////////////////////////////////////
// Welcome!
////////////////////////////////////////////////////////////////////////////////
// You made a great choice installing Sigasi Studio, and now you are ready to
// unlock its power.
//
// This demo file will guide you through your first steps. In about ten
// minutes you will have learned the basics of how Sigasi helps you work
// with Verilog and SystemVerilog files. This tutorial also covers more advanced
// topics, which you can explore at your own pace.
//
// TODO In the (System)Verilog files of this project, follow the comments that
//      are marked 'TODO'.
//
// TODO Double-click the tab of this editor to switch to full screen editing.
////////////////////////////////////////////////////////////////////////////////

// TODO "Correct syntax error"
//      Sigasi Studio puts error markers in the left hand side margin when a
//      syntax error is found. Sigasi Studio marks errors while you are typing.
//      The earlier errors are found, the easier they are to fix.
//
//      One can jump to the error using **Ctrl+.**
//
//      In the module declaration, add the closing parenthesis `)` between
//      `reset` and the semicolon. The error marker turns grey.
//      Press **Ctrl+S** to save the file, the error markers disappear.

module dut_core(
   output logic [7:0] pixel_out,
   input [7:0] pixel_pp,
   input [7:0] pixel_p0,
   input [7:0] pixel_pm,
   input [7:0] pixel_0p,
   input [7:0] pixel_0m,
   input [7:0] pixel_mp,
   input [7:0] pixel_m0,
   input [7:0] pixel_mm,
   input on_edge,
   input clock,
   input reset);

   // TODO "Format"
   //      Sigasi Studio can format your code. This can greatly
   //      enhance the readability of your code.
   //      Press **Ctrl+Shift+F** to format the current file.

   // TODO "Semantic highlighting"
   //      As you see, language keywords, ports, wires, comments, tags in comments
   //      (like "TODO") are highlighted with different colors to improve readability.
   //
   //      Highlighting colors and fonts can be adjusted to your preferences in
   //      **Window > Preferences > Sigasi > Verilog/SystemVerilog > Syntax Coloring**

   wire logic signed [15:0] gradx; // X gradient
   wire logic signed [15:0] grady; // Y gradient
   wire logic signed [15:0] gradsq; // XY gradient, squared
   logic signed [15:0] gradx_r; // X gradient, buffered
   logic signed [15:0] grady_r; // Y gradient, buffered

   // TODO "Block select mode"
   //      Press **Alt+Shift+A** to activate block selection mode. Then, select both
   //      numbers `9` on the lines above. Type `15` to change both lines at once.
   //
   //      Press **Alt+Shift+A** again to exit block selection mode.

   // TODO "Hover to see documentation"
   //      On the statement below, hover your mouse over the words `grad??`.
   //      A pop-up window will appear and show you the documentation
   //      for the wires.

   // Calculate the X, Y and XY(squared) gradients
   assign gradx = (pixel_mp - pixel_pp) + 2 * (pixel_m0 - pixel_p0) + (pixel_mm - pixel_pm);
   assign grady = (pixel_mp - pixel_mm) + 2 * (pixel_0p - pixel_0m) + (pixel_pp - pixel_pm);
   assign gradsq = (gradx_r * gradx_r) + (grady_r * grady_r);

   // TODO "Navigation"
   //      Place the cursor on `gradsq` in the line above and press **F3**. This will take
   //      you to the definition of `gradsq`. Press **Alt+Left** or click the left
   //      arrow in the toolbar to navigate back here.
   //      Pressing the **Ctrl** key and clicking on `gradsq` (or another symbol) has
   //      the same effect as pressing **F3**. Note how the names are underlined while you
   //      **Ctrl+Hover** over them.

   // TODO "Autocompletion"
   //      On the blank line below, type the first letters of `always` and then **Ctrl+Space**.
   //      Select `Insert an always block with posedge clk` (double-click, or use
   //      arrow up/down and press enter). An `always` block is generated and `clk` is selected.
   //      Type `cl` (replacing `clk`) and press **Ctrl+Space** again to auto-select `clock`
   //      which is our clock signal.
   //
   //      Templates may contain one or more fields. Use **Tab** to navigate between fields.
   //      Press **Enter** to finish editing template fields and return to normal editing.
   always @(posedge clock) begin
      gradx_r = gradx;
      grady_r = grady;

   end

   // TODO "Move lines"
   //      Select the 2 lines of code below. Press **Alt+Up** a few times
   //      to move the lines into the newly created always block.

   // TODO "Toggle comments"
   //      One can comment or uncomment lines using **Ctrl+/** or **Ctrl+Shift+C**.
   //      Select the next block of commented lines and press **Ctrl+/** to uncomment.

     always_ff @(posedge clock) begin
         if (on_edge == 1'b1)
             begin
                 pixel_out <= 'b0;
             end
         else
             begin
                 // TODO "Name completion"
                 //      Not only language keywords, but also names can be auto-completed.
                 //      In the next line, place the cursor after `gra`, press **Ctrl+Space** and choose `gradsq`.
                 pixel_out <= gradsq[15:8];
             end
     end

   // TODO "Mark Occurrences"
   //      Select `pixel_out` in the else clause a few lines up, and look at the
   //      occurrence of pixel_out in the if clause a little higher up. Click the
   //      **Toggle Mark Occurrences** icon in the toolbar to turn the highlighting
   //      of the "other" occurrence on and off.

   // TODO "Code folding"
   //      Left of the code above, next to `always`, `if` and `begin`, there are
   //      small minus signs in a circle. By clicking one of these, the corresponding
   //      code construct is *folded* and the minus turns into a plus. To *unfold* the
   //      code, click the plus sign.

   // TODO "Leave full screen editing"
   //      If you are editing this file in full-screen mode, double-click the tab of
   //      this editor window to get all Sigasi Studio windows back.

endmodule

// TODO "Validation: parameters"
//      For the next steps in this tutorial, you need a Sigasi Studio license.
//      If you don't have one already, request your trial license
//      at https://www.sigasi.com/try-buy (you can **Ctrl+Click** here too)
//
//      Sigasi Studio checks your code as you type and reports problems by placing
//      "info", "warning" and "error" markers in the left margin of the editor, next to
//      the line number. The problem is also underlined in the editor. Place the
//      mouse pointer over the problem marker or underlined code to see what
//      the problem is.
//
//      The line below has an info marker for the parameter `WIDTH` (which is underlined).
//      Place the mouse pointer over the info-with-lightbulb icon or over `WIDTH`. A pop-up
//      appears with the info message that *Parameter is missing a default value*.
//
//      Add a default value after `WIDTH` (e.g. `WIDTH = 16`). The marker and underline disappear.
//      Press **Ctrl+S** to save the file.

module counter #(WIDTH = 16) (
   input clk,
   input rst,
   input start,
   input enable,
   input [(WIDTH-1):0] endvalue,
   output [(WIDTH-1):0] count,
   output logic near_end,
   output logic on_edge
);

   // TODO "Find references"
   //
   //      Select the module name `counter` above and press **Ctrl+Shift+G** to
   //      find references to the counter module, i.e. places where the counter module
   //      is used. The result is in the search window below. Double-click the first
   //      instance  (`counter counter_x_instance`) to navigate to it.
   //      This step will not work if no license has been configured.

   logic [(WIDTH-1):0] count_val;

   always @(posedge clk) begin
      if (rst == 1'b1)
         begin
            count_val = 'b0;
            near_end = 1'b0;
         end
      else if (start == 1'b1)
         begin
            count_val = 'b0;
            near_end = 1'b0; // assuming that endvalue > 1
         end
      else if (enable == 1'b1 && count_val < endvalue)
      begin
         near_end = (count_val == (endvalue - 2))?1'b1:1'b0;
         count_val += 1;
      end
   end;

   assign count = count_val;

   always @(count, endvalue) begin
      if (count == 0 || count == endvalue)
         on_edge = 1'b1;
      else
         on_edge = 1'b0;
   end

endmodule
