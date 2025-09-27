# 📘 Day 5 – Optimization in Synthesis
## **1. Incomplete If-Else and Case Statements**

- Incomplete if-else or case statements can **infer latches**, which may cause glitches and timing issues.
- Example:

```verilog
module incomp_if(input i0, i1, i2, output reg y);
    always @(*) begin
        if(i0) y <= i1;
    end
endmodule

```

- RTL simulation shows `y` retains its previous value when `i0` is low.
- Synthesized netlist infers a **latch** to hold the value.
- **Fix:** include all conditions or a `default` value.
- Complete case example:

```verilog
module comp_case(input i0, i1, i2, input [1:0] sel, output reg y);
    always @(*) begin
        case(sel)
            2'b00: y = i0;
            2'b01: y = i1;
            default: y = i2;
        endcase
    end
endmodule

```

- No latches are inferred.

---

### **2. Overlapping Cases**

- Overlapping or partial cases can lead to **unstable outputs**.
- Example:

```verilog
module bad_case(input i0, i1, i2, i3, input [1:0] sel, output reg y);
    always @(*) begin
        case(sel)
            2'b00: y = i0;
            2'b01: y = i1;
            2'b10: y = i2;
            2'b1?: y = i3; // overlapping
        endcase
    end
endmodule

```

- Avoid overlapping and ensure all values are handled explicitly.

---

### **3. For Loop vs For-Generate**

- **For loop:** used inside `always` block for iterative evaluation.
- **For-generate:** used outside `always` for hardware replication.
- Example (for loop in mux):

```verilog
always @(*) begin
    for(k=0; k<4; k=k+1)
        if(k==sel) y = i_int[k];
end

```

- Example (for-generate in RCA):

```verilog
genvar i;
generate
    for(i=1;i<8;i=i+1) begin
        fa u_fa (.a(num1[i]), .b(num2[i]), .c(int_co[i-1]), .co(int_co[i]), .sum(int_sum[i]));
    end
endgenerate

```

---

### **4. Labs & Simulation Flow**

- Compile RTL with testbench: `iverilog <design>.v tb_<design>.v`
- Run simulation: `./a.out`
- View waveform: `gtkwave <design>.vcd`
- Synthesize with Yosys:

```bash
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog <design>.v
synth -top <design>
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog -noattr <design>_net.v
show

```

- GLS simulation:

```bash
iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v <design>_net.v tb_<design>.v
./a.out
gtkwave tb_<design>.vcd

```

---

### **5. Key Takeaways**

1. Always provide **complete if-else or case statements** to avoid latches.
2. Avoid **overlapping case statements** to prevent unstable outputs.
3. Use **for loops** inside always blocks for evaluation and **for-generate** for hardware replication.
4. GLS ensures that **RTL behavior matches synthesized netlist**.
