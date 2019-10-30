
include <BOSL/shapes.scad>;

// 1/2 inch
holeRowSize = 12.7;

function baseLenX( xHoles ) = holeRowSize * xHoles;
function baseLenY( yHoles ) = holeRowSize * yHoles;

module base(xHoles, yHoles, baseThickness) {
    cube([baseLenX(xHoles),baseLenY(yHoles),baseThickness]);      
}

module baseDiamonds(xHoles, yHoles, baseThickness) {
    // 
    xoffset =4.36;
    yoffset = 3.9;
   
    // Vex holes are .182" or 4.62mm 
    holeSize = 4.62;
    
    // Vex hole spacing is 0.500"
    holeOffset = 12.7;
    for( x=[0:holeOffset:baseLenX(xHoles)]) {
        for(y=[0:holeOffset:baseLenY(yHoles)]){
            x = x + xoffset;
            y = y+ yoffset;
            translate([x,y,-1]) cube(holeSize,baseThickness+3);
        }
     }  
}
