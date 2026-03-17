//=============================================================================
// Module: alu_4bit
// Description: 4-Bit Arithmetic Logic Unit (ALU)
// Author: Daggolu Hari Krishna
// Date: 2024
//
// Supports 8 operations selected via 3-bit opcode:
//   000 - ADD      | 001 - SUB      | 010 - AND      | 011 - OR
//   100 - XOR      | 101 - NOT A    | 110 - Shift Left| 111 - Shift Right
//
// Features:
//   - Carry Out flag for arithmetic operations
//   - Zero flag (asserted when result is zero)
//   - Overflow flag for signed arithmetic
//=============================================================================

module alu_4bit (
    input  wire [3:0] A,          // Operand A
    input  wire [3:0] B,          // Operand B
    input  wire [2:0] opcode,     // Operation selector
    output reg  [3:0] result,     // ALU result
    output reg        carry_out,  // Carry out flag
    output wire       zero_flag,  // Zero flag
    output reg        overflow    // Overflow flag (signed)
);

    // Internal signals
    reg [4:0] temp; // 5-bit temporary for carry detection

    // Zero flag: asserted when result is all zeros
    assign zero_flag = (result == 4'b0000);

    always @(*) begin
        // Default values
        temp      = 5'b0;
        carry_out = 1'b0;
        overflow  = 1'b0;
        result    = 4'b0000;

        case (opcode)
            3'b000: begin // ADD
                temp      = {1'b0, A} + {1'b0, B};
                result    = temp[3:0];
                carry_out = temp[4];
                // Signed overflow: positive + positive = negative, or vice versa
                overflow  = (A[3] == B[3]) && (result[3] != A[3]);
            end

            3'b001: begin // SUB
                temp      = {1'b0, A} - {1'b0, B};
                result    = temp[3:0];
                carry_out = temp[4]; // Borrow flag
                // Signed overflow: positive - negative = negative, or vice versa
                overflow  = (A[3] != B[3]) && (result[3] != A[3]);
            end

            3'b010: begin // AND
                result = A & B;
            end

            3'b011: begin // OR
                result = A | B;
            end

            3'b100: begin // XOR
                result = A ^ B;
            end

            3'b101: begin // NOT A (Bitwise complement)
                result = ~A;
            end

            3'b110: begin // Shift Left (A << 1)
                {carry_out, result} = {A, 1'b0};
            end

            3'b111: begin // Shift Right (A >> 1)
                result    = {1'b0, A[3:1]};
                carry_out = A[0]; // Shifted-out bit
            end

            default: begin
                result    = 4'b0000;
                carry_out = 1'b0;
                overflow  = 1'b0;
            end
        endcase
    end

endmodule
