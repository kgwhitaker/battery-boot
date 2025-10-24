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
cable_chase_length_x = 10;

// Distance from the battery terminal box to the point of cable chase.
boot_taper_len_y = 18;

// Thickness of all walls
wall_thickness = 2;

// *** "Private" variables ***
/* [Hidden] */

// OpenSCAD System Settings - make curves smooth.
$fa = 1;
$fs = 0.4;


//
// The main part of the boot that covers the battery terminal post
// and the battery clamp.
//
module boot_main_body(cutout = false)
{
  edge_rounding = 4;

  cuboid([boot_width_x, boot_length_y,boot_height_z], rounding = edge_rounding, 
    edges=[TOP+FRONT,TOP+RIGHT,TOP+BACK,FRONT+RIGHT, RIGHT+BACK]) {

      position(LEFT) rotate([0,-90,0]) 
        prismoid(size1=[boot_height_z, boot_length_y], size2=[boot_height_z,cable_chase_width_y], h=boot_taper_len_y, 
          rounding = [edge_rounding,0,0,edge_rounding]);



    }






}




//
// Builds the model.
//
module build_model() {
  boot_main_body();

}
build_model();
