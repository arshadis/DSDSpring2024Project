module tb_parking();

    // Inputs
    reg clk;
    reg reset;
    reg car_entered;
    reg is_uni_car_entered;
    reg car_exited;
    reg is_uni_car_exited;
    
    reg [4:0] hour;
    
    // Outputs
    wire [8:0] uni_parked_car;
    wire [8:0] parked_car;
    wire [8:0] uni_vacated_space;
    wire [8:0] vacated_space;
    wire uni_is_vacated_space;
    wire is_vacated_space;
    
    // Instantiate the parking module
    parking dut (
        .clk(clk),
        .reset(reset),
        .car_entered(car_entered),
        .is_uni_car_entered(is_uni_car_entered),
        .car_exited(car_exited),
        .is_uni_car_exited(is_uni_car_exited),
        .hour(hour),
        .uni_parked_car(uni_parked_car),
        .parked_car(parked_car),
        .uni_vacated_space(uni_vacated_space),
        .vacated_space(vacated_space),
        .uni_is_vacated_space(uni_is_vacated_space),
        .is_vacated_space(is_vacated_space)
    );
    task show; begin
        $display("Time: %t,
        vorodi  (reset: %d, car_entered: %d, is_uni_car_entered: %d, car_exited: %d, is_uni_car_exited: %d, hour: %d)
        khoroji (uni_parked_car: %d, parked_car: %d, uni_vacated_space: %d, vacated_space: %d, uni_is_vacated_space: %d, is_vacated_space: %d)",
        $time, reset, car_entered, is_uni_car_entered, car_exited, is_uni_car_exited,hour,
        uni_parked_car,parked_car,uni_vacated_space,vacated_space,uni_is_vacated_space,is_vacated_space);
    end
    endtask


    // Clock generation
    always #5 clk = ~clk;
    integer i;
    // Test scenarios
    initial begin
        $display("reset and hour is seted between 8 and 13:");
        clk = 0;
        reset = 1;
        car_entered = 0;
        is_uni_car_entered = 0;
        car_exited = 0;
        is_uni_car_exited = 0;
        hour = 10;

        #10
        show;

        reset = 0;

        $display("a uni car entered:");
        car_entered = 1;
        is_uni_car_entered = 1;
        #10;
        show;

        $display("a free car entered:");
        is_uni_car_entered = 0;
        #10;
        show;

        car_entered = 0;
        $display("a uni car exited:");
        car_exited = 1;
        is_uni_car_exited = 1;
        #10;
        show;

        $display("a free car exited:");
        is_uni_car_exited = 0;
        #10;
        show;
        
        $display("hour set to 13:");
        hour=13;
        #10;
        show;

        $display("hour set to 14:");
        hour=14;
        #10;
        show;
        #10

        for (i = 0; i< 250 ;i=i+1 ) begin
            car_entered = 1;
            is_uni_car_entered = 0;
            #10;
        end
        $display("the space of free cars is 0:");
        #10
        show;
        #10

        for (i = 0; i<500;i=i+1 ) begin
            car_entered = 1;
            is_uni_car_entered = 1;
            #10;
        end
        $display("the space of uni cars is 0:");
        #10
        show;

        $display("reset:");
        reset=1;
        #10;
        show;

        $display("hour set to 16:");
        hour=16;
        #10;
        show;
        
        for (i = 0; i<500;i=i+1 ) begin
            car_entered = 1;
            is_uni_car_entered = 0;
            #10;
        end
        $display("the space of free cars is 0:");
        #10
        show;

        for (i = 0; i<200;i=i+1 ) begin
            car_entered = 1;
            is_uni_car_entered = 1;
            #10;
        end
        $display("the space of uni cars is 0:");
        #10
        show;

        $display("reset:");
        reset=1;
        #10;
        show;

        for (i = 0; i<300;i=i+1 ) begin
            car_entered = 1;
            is_uni_car_entered = 0;
            #10;
        end
        $display("the space of free cars is 0:");
        #10
        show;

        for (i = 0; i<400;i=i+1 ) begin
            car_entered = 1;
            is_uni_car_entered = 1;
            #10;
        end
        $display("the space of uni cars is 0:");
        #10
        show;

        #10 $stop;
    end
endmodule