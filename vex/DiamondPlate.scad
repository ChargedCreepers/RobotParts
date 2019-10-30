
include <BOSL/shapes.scad>
include <VexBase.scad>

//https://customizer.makerbot.com/docs
// Holes on y axis
yHoles = 5; // [1:100]

// Holes along x axis
xHoles = 2; // [1:100]
// How thick is the base?
baseThickness = 1.5;
//  Base can have flat ribs or not.
generateFlatRibs = true;
// Generate ribs every X holes
flatRibSpacing = 1;

flatRibsOnEnd = false;
flatRibHeight = 1;
flatRibWidth = 2;

// 1/2 inch
//holeRowSize = 12.7;
baseX = holeRowSize * xHoles;
baseY = holeRowSize * yHoles;

/* [Hidden] */
// Resolution, probably dont mess with this
$fn = 50;


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









