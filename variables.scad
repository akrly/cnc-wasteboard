include<util.scad>

$fn=128;


///////////////
// Wasteboard//
///////////////

clr = 8; // No metal area

// Mounting holes to the T slot worktop
// M6 nuts with TX30 heads are used. Adjust M_d2 and M_k as it might be different. 

M_pitch = 1;   // Pitch size (mm)
M_nd = 6.0;    // Nominal diameter (mm)
M_cd = 6.6;    // Clearance drill diameter (mm)
M_td = 5.0;    // Tap drill diameter (mm)

M_d2 = 12;     // Max bolt head diameter (mm)
M_k = 4.6;     // Max bolt head height (mm)


// Mounting holes for tool holders
// T-nut dimensions with M4 thread

tn_ch = 7;     // Cylinder height 
tn_cd = 5;     // Cylinder external diameter
tn_shh = 0.8;  // Shoulder height
tn_shd = 15;   // Shoulder diameter

wbh = 20; // Wasteboard height
mbh = wbh - (clr + M_k); // Minimum board height.

