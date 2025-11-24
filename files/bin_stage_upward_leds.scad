// Bin Day Stage - Split Design with Upward-Facing LEDs
// LEDs point up through lid holes near bin positions

// Bin dimensions (from analysis)
bin_width = 88;
bin_depth = 77;
bin_spacing = 10;

// Stage dimensions
stage_width = bin_width * 2 + bin_spacing + 40;
stage_depth = bin_depth + 30;
base_height = 25;
lid_thickness = 6;
wall_thickness = 3;
base_thickness = 3;

// Connection system
screw_post_diameter = 10;
screw_hole_diameter = 3.2;  // For M3 screws
countersink_diameter = 6.5;
countersink_depth = 2;

// LED PCB dimensions
led_pcb_width = 14.8;
led_pcb_height = 12;
led_pcb_thickness = 2;  // Approximate PCB thickness
led_hole_diameter = 10;  // Hole in lid for LED to shine through
led_holder_height = 15;  // Height of LED mounting posts in base

// Calculate LED positions (near front edge of bins, pointing up)
led1_x_pos = 20 + bin_width/2;  // Center of first bin
led1_y_pos = 15;  // Near front edge of bin position

led2_x_pos = 20 + bin_width + bin_spacing + bin_width/2;  // Center of second bin
led2_y_pos = 15;  // Near front edge of bin position

// ESP32 dimensions
esp32_width = 55;
esp32_length = 28;

// Letter dimensions for front face
letter_height = 20;
letter_pin_diameter = 2.8;
letter_pin_length = 8;
letter_hole_diameter = 3;

// Cable management
cable_channel_width = 10;
cable_channel_depth = 5;

// ============================================
// BASE PART - With upward-facing LED mounts
// ============================================
module stage_base() {
    difference() {
        // Main base body
        cube([stage_width, stage_depth, base_height]);
        
        // Hollow interior
        translate([wall_thickness, wall_thickness, base_thickness])
            cube([stage_width - 2*wall_thickness, 
                  stage_depth - 2*wall_thickness, 
                  base_height + 1]);
        
        // Letter mounting holes on FRONT face
        letter_positions = [
            stage_width * 0.15,  // B
            stage_width * 0.25,  // I
            stage_width * 0.35,  // N
            stage_width * 0.55,  // D
            stage_width * 0.65,  // A
            stage_width * 0.75   // Y
        ];
        
        for (x = letter_positions) {
            // Two pins per letter
            translate([x - 5, -0.1, base_height * 0.7])
                rotate([-90, 0, 0])
                    cylinder(d=letter_hole_diameter, h=wall_thickness + letter_pin_length, $fn=20);
            translate([x + 5, -0.1, base_height * 0.7])
                rotate([-90, 0, 0])
                    cylinder(d=letter_hole_diameter, h=wall_thickness + letter_pin_length, $fn=20);
        }
        
        // Cable channels in bottom
        // Channel from LED 1 position to center
        translate([led1_x_pos - cable_channel_width/2, led1_y_pos, 0])
            cube([cable_channel_width, stage_depth/2 - led1_y_pos, cable_channel_depth]);
        
        // Channel from LED 2 position to center
        translate([led2_x_pos - cable_channel_width/2, led2_y_pos, 0])
            cube([cable_channel_width, stage_depth/2 - led2_y_pos, cable_channel_depth]);
        
        // Central channel connecting to ESP32
        translate([led1_x_pos, stage_depth/2 - cable_channel_width/2, 0])
            cube([led2_x_pos - led1_x_pos, cable_channel_width, cable_channel_depth]);
        
        // USB cable access hole (rear center)
        translate([stage_width/2 - 8, stage_depth - wall_thickness - 0.1, 5])
            cube([16, wall_thickness + 0.2, 8]);
        
        // Side ventilation
        for (i = [0:3]) {
            translate([-0.1, 20 + i * 20, base_height * 0.4])
                cube([wall_thickness + 0.2, 10, 5]);
            translate([stage_width - wall_thickness - 0.1, 20 + i * 20, base_height * 0.4])
                cube([wall_thickness + 0.2, 10, 5]);
        }
    }
    
    // LED 1 mounting structure (holds LED facing UP)
    translate([led1_x_pos, led1_y_pos, base_thickness]) {
        // Four corner posts to hold PCB
        for (x = [-led_pcb_width/2 - 2, led_pcb_width/2 + 2]) {
            for (y = [-led_pcb_height/2 - 2, led_pcb_height/2 + 2]) {
                translate([x, y, 0]) {
                    difference() {
                        cylinder(r=3, h=led_holder_height, $fn=20);
                        // Notch to hold PCB edge
                        translate([x > 0 ? -1 : -3, y > 0 ? -1 : -3, led_holder_height - 3])
                            cube([4, 4, 4]);
                    }
                }
            }
        }
        // Support platform with hole for LED
        translate([0, 0, led_holder_height - 3])
            difference() {
                // Platform
                translate([-led_pcb_width/2 - 4, -led_pcb_height/2 - 4, 0])
                    cube([led_pcb_width + 8, led_pcb_height + 8, 2]);
                // Hole for LED component
                translate([0, 0, -0.1])
                    cylinder(d=8, h=2.2, $fn=20);
            }
    }
    
    // LED 2 mounting structure (same as LED 1)
    translate([led2_x_pos, led2_y_pos, base_thickness]) {
        // Four corner posts to hold PCB
        for (x = [-led_pcb_width/2 - 2, led_pcb_width/2 + 2]) {
            for (y = [-led_pcb_height/2 - 2, led_pcb_height/2 + 2]) {
                translate([x, y, 0]) {
                    difference() {
                        cylinder(r=3, h=led_holder_height, $fn=20);
                        // Notch to hold PCB edge
                        translate([x > 0 ? -1 : -3, y > 0 ? -1 : -3, led_holder_height - 3])
                            cube([4, 4, 4]);
                    }
                }
            }
        }
        // Support platform with hole for LED
        translate([0, 0, led_holder_height - 3])
            difference() {
                // Platform
                translate([-led_pcb_width/2 - 4, -led_pcb_height/2 - 4, 0])
                    cube([led_pcb_width + 8, led_pcb_height + 8, 2]);
                // Hole for LED component
                translate([0, 0, -0.1])
                    cylinder(d=8, h=2.2, $fn=20);
            }
    }
    
    // ESP32 mounting posts (centered)
    esp32_x = stage_width/2 - esp32_width/2;
    esp32_y = stage_depth/2 - esp32_length/2;
    
    for (x = [0, esp32_width - 5]) {
        for (y = [0, esp32_length - 5]) {
            translate([esp32_x + x + 2.5, esp32_y + y + 2.5, base_thickness])
                difference() {
                    cylinder(d=8, h=10, $fn=20);
                    cylinder(d=2.5, h=10.1, $fn=16);
                }
        }
    }
    
    // Corner screw posts for lid attachment
    for (x = [12, stage_width - 12]) {
        for (y = [12, stage_depth - 12]) {
            translate([x, y, base_thickness])
                difference() {
                    cylinder(d=screw_post_diameter, h=base_height - base_thickness, $fn=30);
                    translate([0, 0, base_height - base_thickness - 10])
                        cylinder(d=screw_hole_diameter, h=11, $fn=16);
                }
        }
    }
    
    // Additional mid-point screw posts
    for (x = [stage_width/2]) {
        for (y = [12, stage_depth - 12]) {
            translate([x, y, base_thickness])
                difference() {
                    cylinder(d=screw_post_diameter, h=base_height - base_thickness, $fn=30);
                    translate([0, 0, base_height - base_thickness - 10])
                        cylinder(d=screw_hole_diameter, h=11, $fn=16);
                }
        }
    }
}

// ============================================
// LID PART - With LED holes and pressure points
// ============================================
module stage_lid() {
    difference() {
        union() {
            // Main lid plate
            cube([stage_width, stage_depth, lid_thickness]);
            
            // Bin position guides
            // Left bin
            translate([20 - 2, 10, lid_thickness])
                cube([2, bin_depth - 20, 3]);
            translate([20 + bin_width, 10, lid_thickness])
                cube([2, bin_depth - 20, 3]);
            
            // Right bin
            translate([20 + bin_width + bin_spacing - 2, 10, lid_thickness])
                cube([2, bin_depth - 20, 3]);
            translate([20 + bin_width * 2 + bin_spacing, 10, lid_thickness])
                cube([2, bin_depth - 20, 3]);
            
            // Front and back stops
            for (x_offset = [20, 20 + bin_width + bin_spacing]) {
                translate([x_offset, 8, lid_thickness])
                    cube([bin_width, 2, 3]);
                translate([x_offset, bin_depth + 8, lid_thickness])
                    cube([bin_width, 2, 3]);
            }
        }
        
        // LED holes - where light shines through
        // LED 1 hole
        translate([led1_x_pos, led1_y_pos, -0.1])
            cylinder(d=led_hole_diameter, h=lid_thickness + 0.2, $fn=30);
        
        // LED 2 hole
        translate([led2_x_pos, led2_y_pos, -0.1])
            cylinder(d=led_hole_diameter, h=lid_thickness + 0.2, $fn=30);
        
        // Decorative ring around LED holes (optional)
        // LED 1 decorative recess
        translate([led1_x_pos, led1_y_pos, lid_thickness - 1])
            cylinder(d=led_hole_diameter + 6, h=1.1, $fn=30);
        
        // LED 2 decorative recess
        translate([led2_x_pos, led2_y_pos, lid_thickness - 1])
            cylinder(d=led_hole_diameter + 6, h=1.1, $fn=30);
        
        // Screw holes with countersinks
        for (x = [12, stage_width - 12]) {
            for (y = [12, stage_depth - 12]) {
                translate([x, y, -0.1]) {
                    cylinder(d=screw_hole_diameter, h=lid_thickness + 0.2, $fn=16);
                    translate([0, 0, lid_thickness - countersink_depth])
                        cylinder(d1=screw_hole_diameter, d2=countersink_diameter, 
                                h=countersink_depth + 0.1, $fn=16);
                }
            }
        }
        
        // Additional mid-point screw holes
        for (x = [stage_width/2]) {
            for (y = [12, stage_depth - 12]) {
                translate([x, y, -0.1]) {
                    cylinder(d=screw_hole_diameter, h=lid_thickness + 0.2, $fn=16);
                    translate([0, 0, lid_thickness - countersink_depth])
                        cylinder(d1=screw_hole_diameter, d2=countersink_diameter, 
                                h=countersink_depth + 0.1, $fn=16);
                }
            }
        }
        
        // Ventilation grid (avoiding LED areas)
        for (x = [30:25:stage_width - 30]) {
            for (y = [30:25:stage_depth - 30]) {
                // Skip holes too close to LED holes
                if (sqrt(pow(x - led1_x_pos, 2) + pow(y - led1_y_pos, 2)) > 15 &&
                    sqrt(pow(x - led2_x_pos, 2) + pow(y - led2_y_pos, 2)) > 15) {
                    translate([x, y, -0.1])
                        cylinder(d=6, h=lid_thickness + 0.2, $fn=6);
                }
            }
        }
    }
    
    // LED pressure rings (underside of lid) - holds LEDs in place
    // LED 1 pressure ring
    translate([led1_x_pos, led1_y_pos, 0]) {
        difference() {
            // Outer ring that contacts LED PCB
            translate([0, 0, -2])
                cylinder(d=led_pcb_width + 6, h=2, $fn=30);
            // Inner hole for LED
            translate([0, 0, -2.1])
                cylinder(d=led_hole_diameter + 2, h=2.2, $fn=30);
            // Relief cuts for PCB corners
            for (angle = [0:90:270]) {
                rotate([0, 0, angle])
                    translate([led_pcb_width/2 + 1, 0, -2.1])
                        cube([4, 4, 2.2], center=true);
            }
        }
    }
    
    // LED 2 pressure ring
    translate([led2_x_pos, led2_y_pos, 0]) {
        difference() {
            // Outer ring that contacts LED PCB
            translate([0, 0, -2])
                cylinder(d=led_pcb_width + 6, h=2, $fn=30);
            // Inner hole for LED
            translate([0, 0, -2.1])
                cylinder(d=led_hole_diameter + 2, h=2.2, $fn=30);
            // Relief cuts for PCB corners
            for (angle = [0:90:270]) {
                rotate([0, 0, angle])
                    translate([led_pcb_width/2 + 1, 0, -2.1])
                        cube([4, 4, 2.2], center=true);
            }
        }
    }
}

// ============================================
// LETTER MODULES (Same as before)
// ============================================
module letter_B() {
    union() {
        difference() {
            cube([15, 4, 20]);
            translate([4, -0.1, 3])
                cube([7, 4.2, 4]);
            translate([4, -0.1, 10])
                cube([7, 4.2, 4]);
        }
        translate([2, 0, 0])
            cube([3, 4, 20]);
        translate([4, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
        translate([11, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
    }
}

module letter_I() {
    union() {
        translate([2, 0, 0])
            cube([4, 4, 20]);
        cube([8, 4, 3]);
        translate([0, 0, 17])
            cube([8, 4, 3]);
        translate([2, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
        translate([6, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
    }
}

module letter_N() {
    union() {
        cube([3, 4, 20]);
        translate([12, 0, 0])
            cube([3, 4, 20]);
        translate([3, 0, 0])
            rotate([0, 30, 0])
                cube([3, 4, 24]);
        translate([4, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
        translate([11, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
    }
}

module letter_D() {
    union() {
        difference() {
            cube([15, 4, 20]);
            translate([4, -0.1, 3])
                cube([8, 4.2, 14]);
        }
        translate([2, 0, 0])
            cube([3, 4, 20]);
        translate([4, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
        translate([11, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
    }
}

module letter_A() {
    union() {
        translate([2, 0, 0])
            rotate([0, -15, 0])
                cube([3, 4, 22]);
        translate([10, 0, 0])
            rotate([0, 15, 0])
                cube([3, 4, 22]);
        translate([3, 0, 8])
            cube([9, 4, 3]);
        translate([4, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
        translate([11, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
    }
}

module letter_Y() {
    union() {
        translate([2, 0, 10])
            rotate([0, -20, 0])
                cube([3, 4, 12]);
        translate([10, 0, 10])
            rotate([0, 20, 0])
                cube([3, 4, 12]);
        translate([5.5, 0, 0])
            cube([3, 4, 12]);
        translate([4, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
        translate([11, 4, 10])
            rotate([-90, 0, 0])
                cylinder(d=2.8, h=8, $fn=20);
    }
}

// ============================================
// GENERATE PARTS
// ============================================

// Show base (default)
stage_base();

// Show lid (comment out base and uncomment this for lid export)
// stage_lid();

// Show assembly (for visualization only)
// stage_base();
// color("lightblue", 0.7) translate([0, 0, base_height]) stage_lid();
