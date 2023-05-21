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
n_slots = 5;
// Headspace width (mm)
hsw = 17; //// [16:0.1:18] 
// Headspace depth (mm)
hsd = 7; //// [7:0.1:8]
// Throat width (mm)
thw = 10; //// [10:10]
// Throat depth (mm)
thd = 10; //// [9:1:14]
// Gap between slots (mm)
tsg = 20;

/* [Wasteboard] */

// Wasteboard length (mm)
wbl = wtl;
// Wasteboard width (mm)
wbw = wtw;
// Wasteboard height (mm)
wbh = 20;
// Mounting holes count in X dir
mh_xn = 3; // [2:5]
// Mounting hole count in Y dir
mh_yn = 5; //// [2:2]
// Plot mounting holes only above outer T-slots
outerRowsOnly = true;
// Mounting hole X offset
mhx_offset = 30;



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

//////////////////////////////
//// Generating models    ////
//////////////////////////////

carveyWorktop(wtl, wtw, wth, n_slots, tsg, tso, groveDim);

translate([0,0,wth+1])
    wasteBoard(wbl, wbw, wbh, mountingHoleVar, mountingHoleDim, tNutHoleDim);
