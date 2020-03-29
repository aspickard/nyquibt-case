thread_radius = 1.5;

module m5_screw_mount(height = 10, center = false) {
    difference () {
        cylinder(height, 2.5, 2.5, center);
        cylinder(height, 2.5 - thread_radius, 2.5 - thread_radius, center);
    }
}