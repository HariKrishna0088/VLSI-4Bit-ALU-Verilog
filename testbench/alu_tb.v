//=============================================================================
// Testbench: alu_tb
// Description: Comprehensive testbench for 4-Bit ALU
// Author: Daggolu Hari Krishna
//
// Tests all 8 ALU operations with multiple test vectors.
// Includes self-checking mechanism with PASS/FAIL reporting.
//=============================================================================

`timescale 1ns / 1ps

module alu_tb;

    // Testbench signals
    reg  [3:0] A, B;
    reg  [2:0] opcode;
    wire [3:0] result;
    wire       carry_out, zero_flag, overflow;

    // Test tracking
    integer pass_count = 0;
    integer fail_count = 0;
    integer test_num   = 0;

    // Instantiate the ALU
    alu_4bit uut (
        .A         (A),
        .B         (B),
        .opcode    (opcode),
        .result    (result),
        .carry_out (carry_out),
        .zero_flag (zero_flag),
        .overflow  (overflow)
    );

    // Task for checking results
    task check_result;
        input [3:0] expected_result;
        input       expected_carry;
        input [79:0] op_name; // 10-character operation name
    begin
        test_num = test_num + 1;
        if (result === expected_result && carry_out === expected_carry) begin
            $display("[PASS] Test %0d: %s | A=%b, B=%b => Result=%b, Carry=%b",
                     test_num, op_name, A, B, result, carry_out);
            pass_count = pass_count + 1;
        end else begin
            $display("[FAIL] Test %0d: %s | A=%b, B=%b => Result=%b (expected %b), Carry=%b (expected %b)",
                     test_num, op_name, A, B, result, expected_result, carry_out, expected_carry);
            fail_count = fail_count + 1;
        end
    end
    endtask

    // Main test sequence
    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        $display("============================================================");
        $display("       4-BIT ALU TESTBENCH - Daggolu Hari Krishna");
        $display("============================================================");
        $display("");

        // -------------------------
        // Test ADD (opcode = 000)
        // -------------------------
        $display("--- Testing ADD Operation ---");
        opcode = 3'b000;

        A = 4'b0011; B = 4'b0001; #10;
        check_result(4'b0100, 1'b0, "ADD       ");

        A = 4'b1111; B = 4'b0001; #10;
        check_result(4'b0000, 1'b1, "ADD       ");

        A = 4'b0111; B = 4'b0111; #10;
        check_result(4'b1110, 1'b0, "ADD       ");

        A = 4'b1000; B = 4'b1000; #10;
        check_result(4'b0000, 1'b1, "ADD       ");

        // -------------------------
        // Test SUB (opcode = 001)
        // -------------------------
        $display("");
        $display("--- Testing SUB Operation ---");
        opcode = 3'b001;

        A = 4'b0100; B = 4'b0001; #10;
        check_result(4'b0011, 1'b0, "SUB       ");

        A = 4'b0000; B = 4'b0001; #10;
        check_result(4'b1111, 1'b1, "SUB       ");

        A = 4'b1010; B = 4'b1010; #10;
        check_result(4'b0000, 1'b0, "SUB       ");

        // -------------------------
        // Test AND (opcode = 010)
        // -------------------------
        $display("");
        $display("--- Testing AND Operation ---");
        opcode = 3'b010;

        A = 4'b1100; B = 4'b1010; #10;
        check_result(4'b1000, 1'b0, "AND       ");

        A = 4'b1111; B = 4'b0000; #10;
        check_result(4'b0000, 1'b0, "AND       ");

        A = 4'b1111; B = 4'b1111; #10;
        check_result(4'b1111, 1'b0, "AND       ");

        // -------------------------
        // Test OR (opcode = 011)
        // -------------------------
        $display("");
        $display("--- Testing OR Operation ---");
        opcode = 3'b011;

        A = 4'b1100; B = 4'b0011; #10;
        check_result(4'b1111, 1'b0, "OR        ");

        A = 4'b0000; B = 4'b0000; #10;
        check_result(4'b0000, 1'b0, "OR        ");

        // -------------------------
        // Test XOR (opcode = 100)
        // -------------------------
        $display("");
        $display("--- Testing XOR Operation ---");
        opcode = 3'b100;

        A = 4'b1010; B = 4'b0101; #10;
        check_result(4'b1111, 1'b0, "XOR       ");

        A = 4'b1111; B = 4'b1111; #10;
        check_result(4'b0000, 1'b0, "XOR       ");

        // -------------------------
        // Test NOT (opcode = 101)
        // -------------------------
        $display("");
        $display("--- Testing NOT Operation ---");
        opcode = 3'b101;

        A = 4'b1010; B = 4'b0000; #10;
        check_result(4'b0101, 1'b0, "NOT       ");

        A = 4'b0000; B = 4'b0000; #10;
        check_result(4'b1111, 1'b0, "NOT       ");

        // -------------------------
        // Test SHL (opcode = 110)
        // -------------------------
        $display("");
        $display("--- Testing Shift Left Operation ---");
        opcode = 3'b110;

        A = 4'b0011; B = 4'b0000; #10;
        check_result(4'b0110, 1'b0, "SHL       ");

        A = 4'b1001; B = 4'b0000; #10;
        check_result(4'b0010, 1'b1, "SHL       ");

        // -------------------------
        // Test SHR (opcode = 111)
        // -------------------------
        $display("");
        $display("--- Testing Shift Right Operation ---");
        opcode = 3'b111;

        A = 4'b1100; B = 4'b0000; #10;
        check_result(4'b0110, 1'b0, "SHR       ");

        A = 4'b0011; B = 4'b0000; #10;
        check_result(4'b0001, 1'b1, "SHR       ");

        // -------------------------
        // Test Zero Flag
        // -------------------------
        $display("");
        $display("--- Testing Zero Flag ---");
        opcode = 3'b001;
        A = 4'b0101; B = 4'b0101; #10;
        if (zero_flag === 1'b1)
            $display("[PASS] Zero flag correctly asserted for A-A=0");
        else
            $display("[FAIL] Zero flag not asserted when result is zero");

        // -------------------------
        // Summary
        // -------------------------
        $display("");
        $display("============================================================");
        $display("  TEST SUMMARY: %0d PASSED, %0d FAILED out of %0d tests",
                 pass_count, fail_count, test_num);
        $display("============================================================");

        if (fail_count == 0)
            $display("  >>> ALL TESTS PASSED! <<<");
        else
            $display("  >>> SOME TESTS FAILED! <<<");

        $display("");
        $finish;
    end

endmodule
