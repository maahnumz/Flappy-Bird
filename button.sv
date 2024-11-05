module button (
    input logic Clock, Reset, pressed,
    output logic set
);
    logic [1:0] PS, NS;
    parameter [1:0] on = 2'b00, hold = 2'b01, off = 2'b10;

    always_comb begin
        case(PS)
            on: if (pressed) NS = hold;
                else NS = off;
            hold: if (pressed) NS = hold;
                  else NS = off;
            off: if (pressed) NS = on;
                 else NS = off;
            default: NS = 2'bxx;
        endcase
    end

    always_comb begin
        case(PS)
            on: set = 1;
            hold: set = 0;
            off: set = 0;
            default: set = 1'bx;
        endcase
    end

    always_ff @(posedge Clock or posedge Reset) begin
        if (Reset)
            PS <= off;
        else
            PS <= NS;
    end

endmodule