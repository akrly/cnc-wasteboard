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
    //translate([-l/2, -w/2, 0])
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

                 

+------------+     +-------------+
|            |<-e->|   Λ         |
|            |     |   |         |
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

////////////////
// Wasteboard //
////////////////

// Basic primitive for the wasteboard

module wasteBoard(l, w, h){
    //mdfStock(l,w,h);

   tNutHole();
   translate([20,0,0])
       mountingHole();

}


module mdfStock( l=tl, w = tw, h = wbh){
    cube([l,w,h]);
}

module tNutHole(){
    dualDHole(tn_shd,tn_shh,tn_cd,wbh-tn_shh);
}

module mountingHole(){
    dualDHole(M_nd,mbh,M_d2,clr+M_k);
}


// The second cylinder is on top of the first.
module dualDHole(d1,h1,d2,h2){
    cylinder(h=h1,d=d1);
    translate([0,0,h1])
        cylinder(h=h2,d=d2);
}
