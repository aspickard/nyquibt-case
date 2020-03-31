include <roundedcube.scad>;
include <m5-screw-mount.scad>;

module usbc_hole(vertical = true) {
    direction = vertical ? "y" : "x";
    
    roundedcube([10, 10, 4], true, 2, direction);
}

// All units in mm

case_height = 20;
case_width = 120;
case_depth = 105;
case_corner_radius = 4;
case_thickness = 4;
case_wing_width = 30;
case_floor = -case_height / 2 + case_thickness;

screw_1_x_offset = 37.4; // 75 / 2 ?
screw_1_y_offset = 27.8; // 55.5 / 2?

screw_2_x_offset = 18.2; // 36.5 / 2?
screw_2_y_offset = -29.4; // 59 / 2?

screw_3_x_offset = -39; // 79 / 2?
screw_3_y_offset = -29.4; // 59 / 2?

breakout_board_height = 10;
breakout_board_width = 30;
breakout_board_depth = 70;

breakout_board_hole_x_offset = 2;
breakout_board_hole_y_offset = 3;

breakout_board_x_offset = (-case_width + breakout_board_width) / 2;
breakout_board_y_offset = case_depth / 2 - case_thickness - 1;
breakout_board_mount_offset = -(case_height - breakout_board_height) / 2 + case_thickness;

usbc_z_offset = 2;
usbc_z_translate = -(case_height / 2) + case_thickness * 2 + usbc_z_offset;


// Case shell
difference () {

    // Outer case
    union() {
        roundedcube([case_width + case_wing_width, case_depth, case_height], true, case_corner_radius, "z");
            
            translate([0, 0, case_height - case_thickness * 2 - 4]) {
                rotate([5, 0, 0]) {
                    roundedcube([case_width + case_wing_width, case_depth, case_height - case_thickness - 2], true, case_corner_radius, "z");
                }
            }
    }

    // Inner case
    translate([0, 1, case_thickness - 2]) {
        roundedcube(
            [case_width - case_thickness, case_depth - case_thickness - 2, case_height - case_thickness],
            true,
            case_corner_radius,
            "z"
        );
    }
    
    // Inner case ceiling
    translate([0, -1, case_height]) {
        roundedcube(
            [case_width - case_thickness + 4, case_depth - case_thickness, case_height],
            true,
            case_corner_radius,
            "z"
        );
    }
    
    // Breakout board usb c hole
    translate([breakout_board_x_offset + 12 + breakout_board_hole_x_offset, breakout_board_y_offset, 0])
    {    
        usbc_hole();
    }

    // Split connection usb c hole
    translate([case_width / 2 - case_thickness - case_wing_width, breakout_board_y_offset, 0]) {
        usbc_hole();
    }
    
    // Proton C DFU button
    translate([breakout_board_x_offset + 14, breakout_board_y_offset - 20, case_floor - 4]) {
        cylinder(case_thickness * 2, 2, 2, true);
    }
 
    // Power switch bottom
    translate([-(case_width / 2) - case_thickness, 0, case_thickness]) {
        cube([18, 18, case_height], true);
    }
    
    // Power switch top
    translate([-(case_width / 2) - case_thickness, 0, case_height]) {
        cube([20, 20, case_height], true);
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
    breakout_board_mount_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Top right
translate([
    breakout_board_x_offset + breakout_board_width - breakout_board_hole_x_offset, breakout_board_y_offset - breakout_board_hole_y_offset,
    breakout_board_mount_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Bottom right
translate([
    breakout_board_x_offset + breakout_board_width - breakout_board_hole_x_offset, breakout_board_y_offset - breakout_board_depth + 2 * breakout_board_hole_y_offset,
    breakout_board_mount_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Bottom left
translate([
    breakout_board_x_offset + breakout_board_hole_x_offset,
    breakout_board_y_offset - breakout_board_depth + 2 * breakout_board_hole_y_offset, breakout_board_mount_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// USB C split connection scew mounts (25mm inner width)
translate([
        case_width / 2 - case_thickness - case_wing_width - 12.5,
        case_depth / 2 - case_thickness - 2,
        case_floor
    ]) {
    m5_screw_mount(2, true);
}

translate([
        case_width / 2 - case_thickness - case_wing_width + 12.5,
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
translate([17, -1,  -case_height / 2 + 2 * 2]) {
    difference () {
        cube([55 + case_thickness / 2, 50 + case_thickness / 2, 8] ,true);
        cube([55, 50, 10], true);
    }
}
