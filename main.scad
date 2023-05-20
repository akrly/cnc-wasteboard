include<modules.scad>

/* [Worktop] */

// Worktop length (mm)
wl = 300;
// Worktop width (mm)
ww = 200;
// Worktop height (mm)
wh = 30;

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

groveDim = [hsw, hsd, thw, thd]; 

tso = linearOffset(ww, n_slots, hsw, tsg);  // Corrected offset value so the slots are centred on the worktop
echo(tso);
/* [Wasteboard] */




carveyWorktop(wl, ww, wh, n_slots, tsg, tso, groveDim);

//wasteBoard(tl,tw,wbh);


