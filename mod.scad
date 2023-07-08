
 include<modules.scad>

///////////////////////////
//// Customisable menu ////
///////////////////////////

/* [Worktop] */

// Worktop length (mm)
wtl = 300;
// Worktop width (mm)
wtw = 200;
// Worktop height (mm)
wth = 30;

/* [T-slot] */

// Number of slots
n_slots = 4;
// Headspace width (mm)
hsw = 16; //
// Headspace depth (mm)
hsd = 8; //
// Throat width (mm)
thw = 10; //
// Throat depth (mm)
thd = 8; //
// Gap between slots (mm)
tsg = 34;

/* [Wasteboard] */

// Wasteboard length (mm)
wbl = wtl;
// Wasteboard width (mm)
wbw = wtw;
// Wasteboard height (mm)
wbh = 18;
// Mounting holes count in X dir
mh_xn = 3; // [2:5]
// Mounting hole count in Y dir
mh_yn = 5; //// [2:2]
// Plot mounting holes only above outer T-slots
outerRowsOnly = true;
// Mounting hole X offset
mhx_offset = 05;

/* [Work in progress]  = */

tn_xn = 6;
tn_yn = 4;
tn_xg = 50;
tn_yg = 50;
tn_xo = linearOffset(wbl,tn_xn,0,tn_xg);
tn_yo = linearOffset(wbw,tn_yn,0,tn_yg);
//////////////////////////////
//// Calculated variables ////
//////////////////////////////

//Worktop
//
// T-slot dimensions
groveDim = [hsw, hsd, thw, thd]; 
// Offset value used to centre the T-slots
tso = linearOffset(wtw, n_slots, hsw, tsg);

// Wasteboard
//
// Mounting hole "Y" offset
mhy_offset = tso;

// Mounting hole variables
mountingHoleVar = [mh_xn, mh_yn, mhx_offset, mhy_offset, hsw, outerRowsOnly];

// Mounting hole dimensions
mountingHoleDim = [M_nd, mbh, M_d2, clr+M_k];

// T-nut hole dimensions
tNutHoleDim = [tn_shd, tn_shh, tn_cd, wbh-tn_shh]; 

// T-nut hole variables
tNutHoleVar = [tn_xn, tn_yn, tn_xg, tn_yg, tn_xo, tn_yo];
////////////////////
wasteBoard(wbl, wbw, wbh, mountingHoleVar, mountingHoleDim, tNutHoleDim, tNutHoleVar);

module wasteBoard(l, w, h, mhVar, mhDim, tnhDim, tnhVar){
    // Finding the largest diameter of the mounting holes
    D = (mhDim[1] > mhDim[3]) ? mhDim[1] : mhDim[3];
    // Calculating the offset needed to center the mounting holes above the T-slots  
    mh_align =(mhVar[4] - D) / 2;
    // Gap between mounting holes along the X axis that allow the wasteboard to be fastened to the worktop
    gx = linearGap(l, mhVar[0], D, mhVar[2]);
    // Gap between mounting holes along the Y axis
    gy = linearGap(w, mhVar[1], mhVar[4], mhVar[3]);
    // Centering along the X and Y axes.
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
    // Finding the largest diameter of the T-nut holes
    tnD = (tnhDim[1] > tnhDim[3]) ? tnhDim[1] : tnhDim[3];
            // Mounting holes
            // Align the first hole body to be in x and y positive quadrant and applying offsets
            translate([tn_xo,tn_yo,0])
            // Create the array of mounting holes
                for (i = [0 : tnhVar[0] - 1]) {
                    for (j = [0 : tnhVar[1] - 1]) {
                            translate([i*tnhVar[2],j*tnhVar[3],0])
                            dualDHole(tnhDim);
                        }
                    }   
                }

}

module mdfStock(l, w, h){
    cube([l,w,h]);
}

// The second cylinder is on top of the first.
module dualDHole(dim){

// dim = [ d1, h1, d2, h2]
    cylinder(h=dim[1],d=dim[0]);
    translate([0,0,dim[1]])
        cylinder(h=dim[3],d=dim[2]);
}
