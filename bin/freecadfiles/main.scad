include<modules.scad>

///////////////////////////
//// Customisable menu ////
///////////////////////////

/* [Worktop] */

// Worktop dimensions ( l,w,h in mm )
wtdim = [300, 200, 30];
// Gap between T-slots (mm)
tsg = 34;

/* [T-slot profile] */

// Number of slots
n_slots = 4;
// Headspace width (mm)
hsw = 16; //// [16:0.1:18] 
// Headspace depth (mm)
hsd = 8; //// [7:0.1:8]
// Throat width (mm)
thw = 10; //// [10:10]
// Throat depth (mm)
thd = 8; //// [9:1:14]

/* [Wasteboard] */

// Wasteboard dimensions ( l,w,h in mm )
wbdim = [400, 260, 20];

// Mounting holes count in X dir
mh_xn = 3; // [2:5]
// Mounting hole count in Y dir
mh_yn = 5; //// [2:2]
// Plot mounting holes only above outer T-slots
outerRowsOnly = true;
// Mounting hole X offset
mhx_offset = 05;

/* [Work in progress] */

tn_xn = 6;
tn_yn = 5;
tn_xg = 50;
tn_yg = 40;
tn_xo = linearOffset(wbdim[0],tn_xn,0,tn_xg);
tn_yo = linearOffset(wbdim[1],tn_yn,0,tn_yg);

/* [Objects] */

object_worktop = false;
object_wasteboard = true;


//////////////////////////////
//// Calculated variables ////
//////////////////////////////

//Worktop
//
// T-slot dimensions
groveDim = [hsw, hsd, thw, thd]; 
// Offset value used to centre the T-slots
tso = linearOffset(wtdim[1], n_slots, hsw, tsg);

// Wasteboard
//
// Mounting hole "Y" offset
mhy_offset = tso;

// Mounting hole variables
mountingHoleVar = [mh_xn, mh_yn, mhx_offset, mhy_offset, hsw, outerRowsOnly];

// Mounting hole dimensions
mountingHoleDim = [M_nd, mbh, M_d2, clr+M_k];

// T-nut hole dimensions
//
tNutHoleDim = [tn_shd, tn_shh, tn_cd, wbdim[2]-tn_shh]; 

// T-nut hole variables
tNutHoleVar = [tn_xn, tn_yn, tn_xg, tn_yg, tn_xo, tn_yo];
//////////////////////////////
//// Generating models    ////
//////////////////////////////
if (object_worktop == true) {
    carveyWorktop(wtdim,, n_slots, tsg, tso, groveDim);
    if (object_wasteboard == true) {
        translate([0, 0, wtdim[2] + 1])
            wasteBoard(wbdim, wtdim, mountingHoleVar, mountingHoleDim, tNutHoleDim, tNutHoleVar);
    }
}
else if (object_wasteboard == true) {
    wasteBoard(wbdim, wtdim, mountingHoleVar, mountingHoleDim, tNutHoleDim, tNutHoleVar);
}

