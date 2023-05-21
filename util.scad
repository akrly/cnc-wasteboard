// This function calculates the offset required to center equally spaced spaced series of "n objects. The objects have a length "x" and gap "g" between neighbouring objects. "l" is the length of the reference line.
function linearOffset (l, n, x, g) = (l - (n*x + (n-1)*g)) / 2;

// Calculating gaps between equally a series of equidistant objects of length "x" spanning across a reference line "l". There is an offset "o" at each side of the reference line.
function linearGap (l, n, x, o) = (l - 2*o - n*x) / (n - 1);
