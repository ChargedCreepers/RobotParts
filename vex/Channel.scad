
include <BOSL/shapes.scad>
include <VexBase.scad>

/* [Basic] */
// Number of holes along the Y axis
yHoles = 8; // [1:100]
// Number of holes along the X axis
xHoles = 3; // [1:100]
// How many holes high is the channel?
channelHeight = 1;//[1:10]
// If true, just a single channel wall, or an L bracket
singleChannel = false; 
// Thickness of base (mm)
baseThickness = 1.5;
// Side thickness of the c-channel (mm)
sideThickness=2;

/* [Ribs]     */
// Reinforcement ribs along the base?
generateFlatRibs = true;
// Rib on the end of the base?
flatRibsOnEnd = false;
// Flat rib height (mm)
flatRibHeight = 2;
// Flat rib width (mm)
flatRibWidth = 2.5;

/* [Gussets] */
// Generate gussets along the channel wall?
generateGussets = true;
// Gusset thickness
gussetWidth=2;


/* [Hidden] */
// Resolution, probably dont mess with this
$fn = 50;
// 1/2 inch
holeRowSize = 12.7;
baseX = holeRowSize * xHoles;
baseY = holeRowSize * yHoles;


module flatribs() {
    for(y=[0:yHoles]){
        yOffset = (holeRowSize) * y;
        // flatribs are even! 
        if( (y % 2) == 0) {  
            if( !flatRibsOnEnd ) {
               if( y != 0 && y!= yHoles ) {
                translate([0,yOffset]) cube([baseX,flatRibWidth,baseThickness+flatRibHeight]);            
               }
            }
            else {
                translate([0,yOffset]) cube([baseX,flatRibWidth,baseThickness+flatRibHeight]);
            }
        }    
    }   
}

// I didn't know these were called gussets when I wrote this.. :)
module triRibs() {
    // 1/2 inch
    holeOffset = 12.7;
   
     //Walk along the y axis, makin triangle ribs!
    for(y=[0:yHoles]){
        halfTriRibWidth = gussetWidth / 2;
        yOffset = (holeRowSize) * y;
            if( (y % 2) != 0 && y != yHoles) {
                translate([0, yOffset - halfTriRibWidth]) right_triangle([10, 1.5, 10]);
                
                if(!singleChannel) {
                    translate( [holeRowSize *xHoles, yOffset + halfTriRibWidth ]) 
                        rotate([0,0,180])
                        right_triangle([10, 1.5, 10]); 
                }

            }
    }   
}

module side(startX, startY) {
    difference() {
        translate([startX,startY,baseThickness]) cube([sideThickness,baseY,holeRowSize * channelHeight]);
        sideHoles();  
    }
}

module sideHoles() {
   
    yoffset = 3.9;
    zoffset = 5.25;
   
    // 3/16 hole?
    holeSize = 4.76;
  
    // 1/2 inch
    holeOffset = 12.7;
        for(y=[0:yHoles]){
            for(z=[0:channelHeight]) {
                yPos = (holeRowSize * y) + yoffset; 
                zPos = (holeRowSize * z) + zoffset;
                translate([sideThickness-3,yPos,zPos]) cube([baseX+10,holeSize,holeSize]);            
            }

        }      
}

difference() {
    base(xHoles, yHoles, baseThickness);
     baseDiamonds(xHoles, yHoles, baseThickness);   
} 

side(0,0);

if(!singleChannel) {
    side(holeRowSize*xHoles-sideThickness,0);
}



if(generateFlatRibs) {
    flatribs(); 
}

if(generateGussets) {
    triRibs();
}








