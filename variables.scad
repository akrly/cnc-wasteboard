include<util.scad>

$fn=10;


///////////////
// Wasteboard//
///////////////

clr = 5; // No metal area

// Mounting holes to the T slot worktop
// M8 nuts with TX40 heads are used. Adjust M_d2 and M_k as it might be different. 

M_pitch = 1.25;   // Pitch size (mm)
M_nd = 8.0;    // Nominal diameter (mm)
M_cd = 8.4;    // Clearance drill diameter (mm)
M_td = 9.0;    // Tap drill diameter (mm)

M_d2 = 14.5; ///// 12;     // Max bolt head diameter (mm)
M_k = 5; ///// 4.4;     // Max bolt head height (mm)


// Mounting holes for tool holders
// T-nut dimensions with M4 thread
;
tn_ch = 6;     // Cylinder height 
tn_cd = 5.5;     // Cylinder external diameter
tn_shh = 1.0;  // Shoulder height
tn_shd = 15;   // Shoulder diameter

wbh = 20; // Wasteboard height
mbh = wbh - (clr + M_k); // Minimum board height.

