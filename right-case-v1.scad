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
case_thickness = 2;

screw_1_x_offset = 37.4; // 75 / 2 ?
screw_1_y_offset = 27.8; // 55.5 / 2?

screw_2_x_offset = 18.2; // 36.5 / 2?
screw_2_y_offset = -29.4; // 59 / 2?

screw_3_x_offset = -39; // 79 / 2?
screw_3_y_offset = -29.4; // 59 / 2?

breakout_board_height = 10;
breakout_board_width = 30;
breakout_board_depth = 70;

breakout_board_x_offset = (-case_width + breakout_board_width) / 2;
breakout_board_y_offset = case_depth / 2 - case_thickness * 2;
breakout_board_mount_offset = -(case_height - breakout_board_height) / 2 + case_thickness;

usbc_z_offset = 2;
usbc_z_translate = -(case_height / 2) + case_thickness * 2 + usbc_z_offset;

// Case shell
difference () {
    difference () {
        difference () {
            // Outer case
            roundedcube([case_width, case_depth, case_height], true, case_corner_radius, "z");

            // Inner case
            translate([0, 0, case_thickness]) {
                roundedcube(
                    [case_width - case_thickness, case_depth - case_thickness, case_height - case_thickness],
                    true,
                    case_corner_radius,
                    "z"
                );
            }
        }
        
        // Breakout board usb c hole
        translate([breakout_board_x_offset + 11, breakout_board_y_offset, usbc_z_translate]) {    
            usbc_hole();
        }
    }
    // Split connection usb c hole
    translate([case_width / 2, 0, usbc_z_translate]) {
        usbc_hole(false);
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
translate([breakout_board_x_offset, breakout_board_y_offset, breakout_board_mount_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Top right
translate([breakout_board_x_offset + breakout_board_width, breakout_board_y_offset, breakout_board_mount_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Bottom right
translate([breakout_board_x_offset + breakout_board_width, breakout_board_y_offset - breakout_board_depth, breakout_board_mount_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// Bottom left
translate([breakout_board_x_offset, breakout_board_y_offset - breakout_board_depth, breakout_board_mount_offset]) {
    m5_screw_mount(breakout_board_height, true);
}

// USB C split connection scew mounts
translate([case_width / 2 - case_thickness * 2 - 1, 12.5, -case_height / 2 + 2 * 2]) {
    m5_screw_mount(2, true);
}

translate([case_width / 2 - case_thickness * 2 - 1, -12.5, -case_height / 2 + 2 * 2]) {
    m5_screw_mount(2, true);
}
