//
// A Car Battery Protector Boot.  Principally for the positive terminal 
// of a battery to avoid accidental shorts.
//
// MIT License
//
// Copyright (c) 2025 Ken Whitaker
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

// The Belfry OpenScad Library, v2:  https://github.com/BelfrySCAD/BOSL2
// This library must be installed in your instance of OpenScad to use this model.
include <BOSL2/std.scad>

// *** Model Parameters ***
/* [Model Parameters] */

// Boot width that goes over the terminal and clamp.
boot_width_x = 31;

// Boot length that goes over the terminal and clamp.
boot_length_y = 42;

// Overall height of the boot 
boot_height_z = 24;

// Width of the cable chase where the battery cable exits the boot.
cable_chase_width_y = 19;

// Length of the chase once it is tapered down to cable width. 
cable_chase_length_x = 20;

// Distance from the battery terminal box to the point of cable chase.
boot_taper_len_y = 18;

// Thickness of all walls
wall_thickness = 2;

edge_rounding = 4;

// *** "Private" variables ***
/* [Hidden] */

// OpenSCAD System Settings - make curves smooth.
$fa = 1;
$fs = 0.4;

//
// The main part of the boot that covers the battery terminal post
// and the battery clamp.
//
// If this is a cutout, then shrink the X and Y dimensions by 2x wall thickness.
//
module boot_main_body(cutout = false) {

  size_adj = cutout ? wall_thickness * 2 : 0;

  cuboid(
    [boot_width_x - size_adj, boot_length_y - size_adj, boot_height_z], rounding=edge_rounding,
    edges=[TOP + FRONT, TOP + RIGHT, TOP + BACK, FRONT + RIGHT, RIGHT + BACK]
  ) {

    position(LEFT) rotate([0, -90, 0])
        prismoid(
          size1=[boot_height_z, boot_length_y - size_adj], size2=[boot_height_z, cable_chase_width_y - size_adj], h=boot_taper_len_y,
          rounding=[edge_rounding, 0, 0, edge_rounding]
        );
  }
  // cuboid
}

//
// Creates the wire chase where the cable exits the main body.
//
// If this is a cutout, then shrink the y dimension.  x dimension covers the the chase + main body.
//
module wire_chase(cutout = false) {

  size_adj = cutout ? wall_thickness * 2 : 0;

  cuboid(
    size=[cable_chase_length_x + size_adj * 2, cable_chase_width_y - size_adj, boot_height_z], rounding=edge_rounding,
    edges=[TOP + FRONT, TOP + BACK]
  );
}

//
// Builds the model.
//
module build_model() {

  difference() {
    union() {
      boot_main_body(cutout=false);

      translate([-(boot_width_x + (cable_chase_length_x / 2) + wall_thickness), 0, 0])
        wire_chase(cutout=false);
    }

    translate([0, 0, -wall_thickness])
      boot_main_body(cutout=true);

    translate([-(cable_chase_length_x + boot_taper_len_y + wall_thickness * 2), 0, -wall_thickness])
      wire_chase(cutout=true);
  }
}
build_model();
