include <variables.scad>

// Basic primitive for the worktop
module aluStock(l, w, h) {
    cube([l, w, h]);
}

// Assembling parts of the worktop
module carveyWorktop(l, w, h, n, g, tSlotOffset, tSlotDim ) {
    // Calculate the shift of the T-slots in the Y direction
    ytrans = tSlotOffset;
    // Calculate the height difference of the T-slot profile and the stock. 
    ztrans = h - (tSlotDim[1]+tSlotDim[3]);
    // Cutting the T-slot groves out of the stock
    translate([-l/2, -w/2, 0])
        difference() {
            aluStock(l, w, h);
            // Move extrusion up to stock surface and centre it along the Y direction
            translate([0, ytrans, ztrans])
                for (i = [0 : n - 1]) {
                    translate([0, i * (g + tSlotDim[0]), 0])
                        tSlotExtrusion(tSlotDim,l);                        
                }
       }
}

module tSlotExtrusion(dim,l){
/*
dim = [a, b, c, d]
    
a = headspace width
b = headspace depth
c = throat width
d = throat depth

Cut section diagram of the T-slot. 

+------------+     +-------------+
|            |     |   Λ         |
|            |<-e->|   |         |
|            |     |   d         |
|            |     |   |         |
|            |     |   V         |
|     +------+     +------+ ---  |
|     |                   |   Λ  |
|     |                   |   |  |
|     |                   |   b  |
|     |<--------a-------->|   |  |
|     |                   |   V  |
|     +-------------------+ ---  |
|                                |
+--------------------------------+


*/

    tSlotProfilePoints = [
        [0,                  0],
        [dim[0],             0],
        [dim[0],             dim[1]],
        [(dim[0]+dim[2])/2,  dim[1]],
        [(dim[0]+dim[2])/2,  dim[1]+dim[3]],
        [(dim[0]-dim[2])/2,  dim[1]+dim[3]],
        [(dim[0]-dim[2])/2,  dim[1]],
        [0,                  dim[1]]
        ];
    rotate([90, 0, 90]) {
        linear_extrude(l) {
            polygon(points = tSlotProfilePoints);
        }
    }
}

////////////////////
//// Wasteboard ////
////////////////////

module wasteBoard(l, w, h, mhVar, mhDim, tnhDim, tnhVar){
    //////
    // Variables for mounting holes
    //////
    // Finding the largest diameter of the mounting holes
    D = (mhDim[1] > mhDim[3]) ? mhDim[1] : mhDim[3];
    // Calculating the offset needed to center the mounting holes above the T-slots  
    mh_align =(mhVar[4] - D) / 2;
    // Gap between mounting holes along the X axis that allow the wasteboard to be fastened to the worktop
    gx = linearGap(l, mhVar[0], D, mhVar[2]);
    // Gap between mounting holes along the Y axis
    gy = linearGap(w, mhVar[1], mhVar[4], mhVar[3]);
    // Centering along the X and Y axes.
    //////
    // Variables for T-nut holes
    //////
    // Finding the largest diameter of the T-nut holes
    tnD = (tnhDim[0] > tnhDim[2]) ? tnhDim[0] : tnhDim[2];
    // Offset along X axis
    tn_xo = linearOffset(l, tnhVar[0], tnD, tnhVar[2]);
    // Offest along Y axis
    tn_yo = linearOffset(w, tnhVar[1], tnD, tnhVar[3]);

    translate([-l/2, -w/2, 0])
        difference() {
            mdfStock(l, w, h);
            //
            // Mounting holes
            //
            // Align the first hole body to be in x and y positive quadrant and applying offsets
            translate([D/2 + mhVar[2], D/2 + mhVar[3], 0])
            // Create the array of mounting holes
                for (i = [0 : mhVar[0] - 1]) {
                    for (j = [0 : mhVar[1] - 1]) {
                        if (mhVar[5] == true) {
                            if (j == 0 || j == mhVar[1] - 1) {
                                translate([i * (gx + D), j * (gy + mhVar[4]) + mh_align, 0])
                                dualDHole(mhDim);
                            } else{
                            }
                        } else {
                            translate([i * (gx + D), j * (gy + mhVar[4]) + mh_align, 0])
                            dualDHole(mhDim);
                        }
                    }   
                }
            //
            // T-nut holes
            //
            // Align the first hole body to be in x and y positive quadrant and applying offsets
            translate([tnD/2 + tn_xo, tnD/2 + tn_yo, 0])
            // Create the array of mounting holes
                for (i = [0 : tnhVar[0] - 1]) {
                    for (j = [0 : tnhVar[1] - 1]) {
                            translate([i*(tnD + tnhVar[2]),j*(tnD + tnhVar[3]),0])
                            dualDHole(tnhDim);
                        }
                    }
        }
}

module mdfStock(l, w, h){
    cube([l,w,h]);
}

module tNutHole(){
    dualDHole(tn_shd,tn_shh,tn_cd,wbh-tn_shh);
}

// The second cylinder is on top of the first.
module dualDHole(dim){

// dim = [ d1, h1, d2, h2]
    cylinder(h=dim[1],d=dim[0]);
    translate([0,0,dim[1]])
        cylinder(h=dim[3],d=dim[2]);
}
