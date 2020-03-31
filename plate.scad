include <roundedcube.scad>;

case_height = 20;
case_width = 120;
case_depth = 105;
case_corner_radius = 4;
case_thickness = 4;
plate_thickness = 3;
switch_width = 14;
switch_distance = 5;

screw_1_x_offset = 38; // 75 / 2 ?
screw_1_y_offset = 28.5; // 55.5 / 2?

screw_2_x_offset = 18.5; // 36.5 / 2?
screw_2_y_offset = -28.5; // 59 / 2?

screw_3_x_offset = -38; // 79 / 2?
screw_3_y_offset = -28.5; // 59 / 2?

module switch_mount(width=switch_width) {
    cube([width, width, plate_thickness], true);
}

module m5_screw_hole(height=10, radius=2.5, center=true) {
    cylinder(height, radius, radius, center);
}

difference() {
    translate([0, 0, (case_height - plate_thickness) / 2]) {
        difference() {
            roundedcube(
                [case_width - case_thickness + 4, case_depth - case_thickness, case_height],
                true,
                case_corner_radius,
                "z"
            );
            translate([0, 0, plate_thickness]) {
                roundedcube(
                    [case_width - case_thickness + 4, case_depth - case_thickness, case_height],
                    true,
                    case_corner_radius,
                    "z"
                );
            }
        }
    }

    for (y=[-2:1:2]) {
        for (x=[0:1:2]) {
            translate([
                (switch_width + switch_distance) / 2 + (x * (switch_width + switch_distance)),
                y * (switch_width + switch_distance),
                0
            ]) {
                switch_mount();
            }
            translate([
                -(switch_width + switch_distance) / 2 - (x * (switch_width + switch_distance)),
                y * (switch_width + switch_distance),
                0
            ]) {
                switch_mount();
            }
        }
    }
    
    // Plate screw mounts
    translate([screw_1_x_offset, screw_1_y_offset, 0]) {
        m5_screw_hole(case_height, center=true);
    }

    translate([screw_2_x_offset, screw_2_y_offset, 0]) {
        m5_screw_hole(case_height, center=true);
    }

    translate([screw_3_x_offset, screw_3_y_offset, 0]) {
        m5_screw_hole(case_height, center=true);
    }
}