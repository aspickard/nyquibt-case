include <roundedcube.scad>;
include <m5-screw-mount.scad>;

// All units in mm

// Height of base of case (not including slope)
case_height = 20;
// Width of base of case without "wings" on sides
case_width = 120;
// Depth of base of case
case_depth = 105;
// How round you want your corners bro?
case_corner_radius = 4;
// Thickness of the case shell (back of case is thinner for usb c)
case_thickness = 4;
// Width on either of case
case_wing_width = 30;
// Z offset of the case floor from origin
case_floor = -case_height / 2 + case_thickness;
// Slope of the case (for switch protection)
case_slope = 5;
// How much top slope should intersect with base case
case_slope_offset = 0;
// How much space for plate support rims on front and sides
case_plate_shelf_width = 2;

// Top right plate screw offsets from origin
screw_1_x_offset = 38;
screw_1_y_offset = 28.5;

// Bottom right plate screw offsets from origin
screw_2_x_offset = 18.5;
screw_2_y_offset = -28.5;

// Bottom left plate screw offsets from origin
screw_3_x_offset = -38;
screw_3_y_offset = -28.5;

// Size of breakout board in top left
breakout_board_height = 10;
breakout_board_width = 30;
breakout_board_depth = 70;

// Offsets of mounting holes on the breakout board
breakout_board_hole_x_offset = 2;
breakout_board_hole_y_offset = 3;

// Distance from origin to mount breakout board
breakout_board_x_offset = (-case_width + breakout_board_width) / 2;
breakout_board_y_offset = case_depth / 2 - case_thickness - 1;
breakout_board_z_offset = -(case_height - breakout_board_height) / 2 + case_thickness;

// Distance from floor for usbc cutout
usbc_z_offset = -2;
usbc_hole_width = 25;

// Magnet size for wing magnet inserts / mounts
magnet_radius = 5;
magnet_height = 3;
magnet_offset = 4;

// Power switch sizes
switch_width = 18;
switch_depth = 20;
switch_plate_width = 2;

module usbc_hole(vertical=true) {
    direction = vertical ? "y" : "x";
    
    roundedcube([10, 10, 4], true, 2, direction);
}

module magnet_mount(height=3, radius=5, rotation=case_slope) {
    rotate([case_slope, 0, 0]) {
        cylinder(height, radius, radius, true);
    }
}

module magnet_slot(height=3, width=10, rotation=case_slope) {
    rotate([case_slope, 0, 0]) {
        cube([width + 2, width, height], true);
    }
}

module pad_mount(width=13, height=2) {
    cube([width, width, height], true);
}

// Case shell
difference () {
    translate([0, 0, case_height / 2]) {
        difference () {
        // Outer case
        roundedcube([case_width + case_wing_width, case_depth, case_height * 2], true, case_corner_radius, "z");

        // Inner case
        // Y is 1 in the translate so that back wall of inner case is flush
        translate([0, 1, case_thickness - case_plate_shelf_width]) {
            roundedcube([
                case_width - case_plate_shelf_width * 2,
                case_depth - case_plate_shelf_width * 3,
                case_height * 2 - case_thickness
            ],
                true,
                case_corner_radius,
                "z"
            );
        }
        
        // Inner case ceiling
        translate([0, 0, case_height + case_slope_offset - case_thickness]) {
            rotate([case_slope, 0, 0]) {
                roundedcube(
                    [
                        case_width + case_wing_width,
                        case_depth * 2,
                        case_height
                    ],
                    true,
                    case_corner_radius,
                    "z"
                );
            }
        }
    }
    }
    
    // Breakout board usb c hole
    translate([
        breakout_board_x_offset + 12 + breakout_board_hole_x_offset, // TODO: 12?
        breakout_board_y_offset,
        usbc_z_offset
    ]) {    
        usbc_hole();
    }

    // Split connection usb c hole
    translate([
        case_width / 2 - case_thickness - case_wing_width, // Wing width is offset from inner case y
        breakout_board_y_offset,
        usbc_z_offset
    ]) {
        usbc_hole();
    }
    
    // Proton C DFU button
    translate([breakout_board_x_offset + 15, breakout_board_y_offset - 20, case_floor - 4]) {
        cylinder(case_thickness * 2, 2, 2, true);
    }
 
    // Power switch bottom
    translate([-(case_width / 2) - case_thickness, 0, case_thickness]) {
        cube([
            switch_width,
            switch_depth,
            case_height
        ], true);
    }
    
    // Power switch top
    translate([-(case_width / 2) - case_thickness, 0, case_height]) {
        cube([
            switch_width + switch_plate_width,
            switch_depth + switch_plate_width,
            case_height
        ], true);
    }
    
    // Magnet mounts       
    translate([
        -(case_width / 2 + case_wing_width / 2 - magnet_radius),
        case_depth / 2 - magnet_radius - magnet_offset * 3,
        case_height - magnet_height - magnet_offset + 1
    ]) {
        magnet_slot();
    }
 
    translate([
        case_width / 2 + case_wing_width / 2 - magnet_radius,
        case_depth / 2 - magnet_radius - magnet_offset * 3,
        case_height - magnet_height - magnet_offset + 1
    ]) {
        magnet_slot();
    }

    translate([
        case_width / 2 + case_wing_width / 2 - magnet_radius,
        -(case_depth / 2 - magnet_radius) + magnet_offset * 3,
        magnet_offset * 2
    ]) {
        magnet_slot();
    }
    
    translate([
        -(case_width / 2 + case_wing_width / 2 - magnet_radius),
        -(case_depth / 2 - magnet_radius) + magnet_offset * 3,
        magnet_offset * 2
    ]) {
        magnet_slot();
    }
    
    // Pad mounts
    translate([
        -(case_width / 2 + case_wing_width / 2 - magnet_radius - magnet_offset * 4),
        case_depth / 2 - magnet_radius - magnet_offset * 4,
        -(case_height / 2)
    ]) {
        pad_mount();
    }
    
    translate([
        -(case_width / 2 + case_wing_width / 2 - magnet_radius - magnet_offset * 4),
        -(case_depth / 2 - magnet_radius - magnet_offset * 4),
        -(case_height / 2)
    ]) {
        pad_mount();
    }
    
    translate([
        (case_width / 2 + case_wing_width / 2 - magnet_radius - magnet_offset * 4),
        -(case_depth / 2 - magnet_radius - magnet_offset * 4),
        -(case_height / 2)
    ]) {
        pad_mount();
    }
    
    translate([
        (case_width / 2 + case_wing_width / 2 - magnet_radius - magnet_offset * 4),
        (case_depth / 2 - magnet_radius - magnet_offset * 4),
        -(case_height / 2)
    ]) {
        pad_mount();
    }
}

// Plate screw mounts
translate([screw_1_x_offset, screw_1_y_offset, 0]) {
    m5_screw_mount(case_height, true);
}

translate([screw_2_x_offset, screw_2_y_offset, 0]) {
    m5_screw_mount(case_height, true);
}

translate([screw_3_x_offset, screw_3_y_offset, 0]) {
    m5_screw_mount(case_height, true);
}

// Breakout board screw mounts
// Top left
translate([
    breakout_board_x_offset + breakout_board_hole_x_offset,
    breakout_board_y_offset - breakout_board_hole_y_offset,
    breakout_board_z_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Top right
translate([
    breakout_board_x_offset + breakout_board_width - breakout_board_hole_x_offset, breakout_board_y_offset - breakout_board_hole_y_offset,
    breakout_board_z_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Bottom right
translate([
    breakout_board_x_offset + breakout_board_width - breakout_board_hole_x_offset, breakout_board_y_offset - breakout_board_depth,
    breakout_board_z_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Bottom left
translate([
    breakout_board_x_offset + breakout_board_hole_x_offset,
    breakout_board_y_offset - breakout_board_depth, breakout_board_z_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// USB C split connection scew mounts (25mm inner width)
translate([
        case_width / 2 - case_thickness - case_wing_width - usbc_hole_width / 2,
        case_depth / 2 - case_thickness - 2,
        case_floor
    ]) {
    m5_screw_mount(2, true);
}

translate([
        case_width / 2 - case_thickness - case_wing_width + usbc_hole_width / 2,
        case_depth / 2 - case_thickness - 2,
        case_floor
    ]) {
    m5_screw_mount(2, true);
}

// LED strip 10 x 25
translate([
        -12.5,
        -(case_depth / 2 - case_thickness) + 10,
        case_floor
    ]) {
    m5_screw_mount(4, true);
}

translate([
        12.5,
        -(case_depth / 2 - case_thickness) + 10,
        case_floor
    ]) {
    m5_screw_mount(4, true);
}

// Battery mount
translate([17, 0,  -case_height / 2 + 2 * 2]) {
    difference () {
        cube([55 + case_thickness / 2, 50 + case_thickness / 2, 8] ,true);
        cube([55, 50, 10], true);
    }
}
