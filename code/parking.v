
module parking (
    input wire clk,
    input wire reset,
    input wire car_entered,
    input wire is_uni_car_entered,
    input wire car_exited,
    input wire is_uni_car_exited,
    input wire [4:0] hour,
    output reg [8:0] uni_parked_car,
    output reg [8:0] parked_car,
    output reg [8:0] uni_vacated_space,
    output reg [8:0] vacated_space,
    output reg uni_is_vacated_space,
    output reg is_vacated_space
);


// پارامترهای ثابت
parameter MAX_UNI_CARS = 500;
parameter TOTAL_CAPACITY = 700;

// ظرفیت آزاد
reg [8:0] free_capacity;
always @(*) begin
    if (hour > 8 && hour < 13) begin
        free_capacity = 200;
    end else if (hour < 16) begin
        free_capacity = 200 + (hour - 13) * 50;
    end else begin
        free_capacity = 500;
    end
end

// شمارنده خودروها
always @(posedge clk or posedge reset) begin

    if (reset) begin
        uni_parked_car <= 0;
        parked_car <= 0;
    end else begin
        if (car_entered) begin
            if (is_uni_car_entered && uni_is_vacated_space) begin
                uni_parked_car <= uni_parked_car + 1;
            end else if ((!is_uni_car_entered) && is_vacated_space) begin
                parked_car <= parked_car + 1;
            end
        end
        if (car_exited) begin
            if (is_uni_car_exited && uni_parked_car > 0) begin
                uni_parked_car <= uni_parked_car - 1;
            end else if (!is_uni_car_exited && parked_car > 0) begin
                parked_car <= parked_car - 1;
            end
        end
    end
end

// محاسبه فضاهای خالی
always @(*) begin
    uni_vacated_space = MAX_UNI_CARS - uni_parked_car;
    vacated_space = free_capacity  - parked_car;
    uni_is_vacated_space = (uni_vacated_space > 0)&&
    ((TOTAL_CAPACITY-parked_car-uni_parked_car)>0);
    is_vacated_space = (vacated_space > 0)&&
    ((TOTAL_CAPACITY-parked_car-uni_parked_car)>0);
end

endmodule
