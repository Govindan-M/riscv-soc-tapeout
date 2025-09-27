# 📘 Day 5 – Optimization in Synthesis
✨ Optimization is about **making designs work better, faster, and more reliably**.

## 📚 Table of Contents
- 1️⃣ Overlapping & Incomplete Cases
- 2️⃣ Incomplete If-Else & Case Statements
- 3️⃣ For Loops vs For-Generate
- 4️⃣ DEMUX & Multiplexers
- 5️⃣ Ripple Carry Adder (RCA)
- 6️⃣ Labs & Simulation Flow
- 7️⃣ Key Takeaways
## 1️⃣ Overlapping & Incomplete Cases – Primary Focus

**Problem:** Overlapping or partial case statements can cause **unpredictable outputs or inferred latches**.

**Example – Bad Case:**

```verilog
module bad_case(input i0, i1, i2, i3, input [1:0] sel, output reg y);
    always @(*) begin
        case(sel)
            2'b00: y = i0;
            2'b01: y = i1;
            2'b10: y = i2;
            2'b1?: y = i3; // ❌ overlapping, unsafe
        endcase
    end
endmodule

```

**✅ Solution:** Cover **all input combinations explicitly** and use `default:` for safety.

---

## 2️⃣ Incomplete If-Else & Case Statements

**Problem:** Missing branches can infer latches, causing functional mismatches.

**Example – Incomplete If:**

```verilog
module incomp_if(input i0, i1, i2, output reg y);
    always @(*) begin
        if(i0) y <= i1; // ❌ No else → y retains previous value
    end
endmodule

```

**Fix – Default assignment or complete branches:**

```verilog
always @(*) begin
    y = 1'b0; // default
    if(i0) y <= i1;
end

```

**Complete Case Example:**

```verilog
module comp_case(input i0, i1, i2, input [1:0] sel, output reg y);
    always @(*) begin
        case(sel)
            2'b00: y = i0;
            2'b01: y = i1;
            default: y = i2; // ✅ ensures no latch
        endcase
    end
endmodule

```

---

## 3️⃣ For Loops vs For-Generate

- **For loop:** inside `always` blocks for evaluation.

```verilog
always @(*) begin
    for(k=0; k<4; k=k+1)
        if(k==sel) y = i_int[k];
end

```

- **For-generate:** outside `always` for hardware replication.

```verilog
genvar i;
generate
    for(i=1;i<8;i=i+1) begin
        fa u_fa (.a(num1[i]), .b(num2[i]), .c(int_co[i-1]), .co(int_co[i]), .sum(int_sum[i]));
    end
endgenerate

```

---

## 4️⃣ DEMUX & Multiplexers

**1:8 DEMUX Using Case:**

```verilog
always @(*) begin
    case(sel)
        3'b000: o0 = i; 3'b001: o1 = i;
        3'b010: o2 = i; 3'b011: o3 = i;
        3'b100: o4 = i; 3'b101: o5 = i;
        3'b110: o6 = i; 3'b111: o7 = i;
        default: {o7,o6,o5,o4,o3,o2,o1,o0} = 8'b0;
    endcase
end

```

**1:8 DEMUX Using For Loop:**

```verilog
integer k;
always @(*) begin
    for(k=0; k<8; k=k+1)
        out[k] = (sel==k) ? i : 1'b0;
end

```

✅ Both synthesize into the same hardware; for loops are **cleaner and scalable**.

---

## 5️⃣ Ripple Carry Adder (RCA) Using Generate Block

```verilog
module rca (input [7:0] num1, num2, output [8:0] sum);
    wire [7:0] int_sum, int_co;
    genvar i;
    generate
        for (i=1; i<8; i=i+1) begin
            fa u_fa (.a(num1[i]), .b(num2[i]), .c(int_co[i-1]), .co(int_co[i]), .sum(int_sum[i]));
        end
    endgenerate
    fa u_fa0 (.a(num1[0]), .b(num2[0]), .c(1'b0), .co(int_co[0]), .sum(int_sum[0]));
    assign sum[7:0] = int_sum;
    assign sum[8] = int_co[7];
endmodule

module fa(input a,b,c, output co,sum);
    assign {co,sum} = a+b+c;
endmodule

```

✅ **Advantages:** Scalable, cleaner code, accurate hardware representation.

---

## 6️⃣ Labs & Simulation Flow

1. **Compile RTL with Testbench:**

```bash
iverilog <design>.v tb_<design>.v

```

1. **Run Simulation:**

```bash
./a.out

```

1. **View Waveform:**

```bash
gtkwave <design>.vcd

```

1. **Synthesize with Yosys:**

```
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog <design>.v
synth -top <design>
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog -noattr <design>_net.v
show

```

1. **GLS Simulation:**

```bash
iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v <design>_net.v tb_<design>.v
./a.out
gtkwave tb_<design>.vcd

```

---

## 7️⃣ Key Takeaways

- ✅ Always provide **complete if-else or case statements**.
- ✅ Avoid **overlapping cases** to prevent unstable outputs.
- ✅ Use **for loops inside always** for evaluation, **for-generate** for replication.
- ✅ GLS ensures **RTL behavior matches synthesized netlist**.
- ✅ Clean, modular, scalable RTL is easier to debug, simulate, and synthesize.
