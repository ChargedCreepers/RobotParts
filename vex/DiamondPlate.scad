
include <BOSL/shapes.scad>
include <VexBase.scad>

/* [Basic] */
// Number of holes along the Y axis
yHoles = 5; // [1:100]
// Number of holes along the X axis
xHoles = 5; // [1:100]
// Thickness of the base (mm)
baseThickness = 1.5;

/* [Ribs] */
// Reinforcement ribs along the base?
generateFlatRibs = true;
// Rib height (mm)
flatRibHeight = 1;
// Rib width (mm)
flatRibWidth = 2;
// Generate ribs every X holes
flatRibSpacing = 1;
// Ribs on the end?
flatRibsOnEnd = false;


/* [Hidden] */
// Resolution, probably dont mess with this
$fn = 50;

// 1/2 inch
//holeRowSize = 12.7;
baseX = holeRowSize * xHoles;
baseY = holeRowSize * yHoles;


module flatribsX() {
    for(y=[0:yHoles]){
        yOffset = ((holeRowSize) * y) - flatRibWidth /2;
        
        if( (flatRibsOnEnd) && (y == 0)) {
            translate([0,(holeRowSize *y)]) cube([baseX,flatRibWidth,baseThickness+flatRibHeight]);
        }
        
        if( (flatRibsOnEnd) && (y == yHoles)) {
            translate([0,(holeRowSize *y) -flatRibWidth   ]) cube([baseX,flatRibWidth,baseThickness+flatRibHeight]);
        }        
        
        if( (y % flatRibSpacing) == 0) {  
            if( !flatRibsOnEnd ) {
               if( y != 0 && y!= yHoles ) {
                translate([0,yOffset]) cube([baseX,flatRibWidth,baseThickness+flatRibHeight]);         
               }
            }
        }    
    }   
}

module flatribsY() {
    for(x=[0:xHoles]){
        xOffset = ((holeRowSize) * x) - flatRibWidth /2;
        
        if( (flatRibsOnEnd) && (x == 0)) {
            translate([((holeRowSize) * x),0]) cube([flatRibWidth,baseY,baseThickness+flatRibHeight]);
        }
  
        if( (flatRibsOnEnd) && (x == xHoles)) {
            translate([((holeRowSize) * x) - flatRibWidth,0]) cube([flatRibWidth,baseY,baseThickness+flatRibHeight]);
        }  
        
        if( (x % flatRibSpacing) == 0) {  
            if( !flatRibsOnEnd ) {
               if( x != 0 && x!= xHoles ) {
                translate([xOffset,0]) cube([flatRibWidth,baseY,baseThickness+flatRibHeight]);         
               }
            }
        }    
    }   
}



difference() {
    base(xHoles, yHoles, baseThickness);
    baseDiamonds(xHoles, yHoles, baseThickness);   
} 

if(generateFlatRibs) {
    flatribsX(); 
    flatribsY();
}









