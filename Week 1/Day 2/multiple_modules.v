// Sub-module 1: AND operation
module sub_module1 (
    input a,
    input b,
    output y
);
    assign y = a & b; // AND operation
endmodule
// Sub-module 2: OR operation
module sub_module2 (
    input a,
    input b,
    output y
);
    assign y = a | b; // OR operation
endmodule
// Top module: instantiates sub_module1 and sub_module2
module multiple_modules (
    input a,
    input b,
    input c,
    output y
);
    wire net1;

    // Instantiate sub_module1
    sub_module1 u1 (
        .a(a),
        .b(b),
        .y(net1)  // net1 = a & b
    );

    // Instantiate sub_module2
    sub_module2 u2 (
        .a(net1),
        .b(c),
        .y(y)     // y = net1 | c = (a & b) | c
    );

endmodule
