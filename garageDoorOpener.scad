
////////////////
// Money Clip //
////////////////

module moneyClip() {
	import_stl("MakerBot_Money_Clip_Larger_v4.stl");
}


/////////////////////
// Garage Door Fob //
/////////////////////

fobLenA = 60.42;
fobLenB = 54.75;
fobWidth = 31.60;
fobThickA = 9.90;
fobThickB = 10.20;
fobButtonLen = 27.82;
fobButtonThick = 12.4;
fobSlantLen = 9.43;

module fob() {
	union() {
		translate(v=[17,(fobButtonThick-fobThickB)/2,fobWidth/2]) 
			cube([fobButtonLen,fobButtonThick,fobWidth],center=true);
		translate(v=[0,0,fobWidth/2]) 
			cube([fobLenA,fobThickB,fobWidth],center=true);
	}
}

////////////////////////
// Container (fobBox) //
////////////////////////
fobBoxWallThickness = 4; //mm
fobBoxRetainerThickness = fobButtonThick - fobThickB; //mm
fobBoxBlankLen = fobLenA + (2 * fobBoxWallThickness);
fobBoxThickness = fobThickB + fobBoxRetainerThickness;
module fobBoxBlank() {
	translate(v=[0,0,(fobWidth + (2*fobBoxWallThickness))/2])
	cube([fobBoxBlankLen, fobBoxThickness, fobWidth + (2*fobBoxWallThickness)],
		center=true);
}

module fobBox() {
	difference() {
		fobBoxBlank();
		translate(v=[0,0,fobBoxWallThickness]) fob();
		translate(v=[0,0,2.5 + fobWidth + (fobBoxWallThickness) -0.01]) cube([200,200,5],center=true);
	}
}

//translate(v=[44,20,0]) rotate(a=[0,0,3.5])
module fobBoxThick() {
	union() {
	fobBox();
	translate(v=[0,-9.2,0])
	difference() {
		scale(v=[1,.5,1]) fobBoxBlank();
			translate(v=[0,0,2.5 + fobWidth + (fobBoxWallThickness) -0.01]) cube([200,200,5],center=true);
	}}
}



////////////////////////
// Money Clip Fob Box //
////////////////////////

module moneyClipFobBox() {
	union() {
		difference() {
			rotate(a=[0,0,45])
			union() {
				translate(v=[51,24,0]) rotate(a=[0,0,3.5]) fobBoxThick();
				scale(v=[1.8,1,1.3]) moneyClip();
			}
			translate(v=[-2,16.5,25]) rotate(a=[0,0,48]) cube([14,10,50],center=true);
			translate(v=[3.8,19.8,25]) rotate(a=[0,0,7]) cube([14,4,50],center=true);
//			translate(v=[30,30,0]) 
//				rotate(a=[0,0,45]) translate(v=[0,0,40/2]) cube([108,15,40],center=true);
		}
		// Make a foot
		//translate(v=[1,5,1]) cylinder(r=6,h=2,center=true);
	}
}


//////////
// Clip //
//////////
visorThick = 24.5;
clipWallThick = 3.5;
clipLen = fobBoxBlankLen;
clipHeight = 38;
clipAngle = 6;
clipFn = 25;
clipRadius = (visorThick/2) + clipWallThick;
clipInnerRadius = clipRadius - clipWallThick;
clipCurveTrim = .5;
module clipSide() {
	translate(v=[0,0,clipHeight/2])
	union() {
		cube([clipLen,clipWallThick,clipHeight],center=true);
		translate(v=[-clipLen/2,0,0]) cylinder(r=clipWallThick/2,h=clipHeight,center=true,$fn=10);
	}
}


module clipCurve() {
	translate(v=[clipLen/2,clipRadius-(clipWallThick/2),clipHeight/2])
	difference() {
		// Outer cylinder
		cylinder(h=clipHeight,r=clipRadius,center=true,$fn=clipFn);

		// Inner cylinder
		cylinder(h=clipHeight,r=clipInnerRadius,center=true,$fn=clipFn);

		translate(v=[-(clipRadius+5)/2 - clipCurveTrim,0,0])cube([clipRadius+5,2.2 * clipRadius,clipHeight + 2],center=true);
	}
}

module clip() {
	
	// Box with clip side
	translate(v=[0,clipWallThick + visorThick,0])
	union() {
		translate(v=[0,fobBoxThickness/2 + clipWallThick/2,0])fobBox();
		clipSide();
	}

	translate(v=[clipLen/2 + 1.5,0,0])rotate(a=[0,0,-clipAngle])translate(v=[-clipLen/2,0,0])clipSide();
}

///////////////
// Execution //
///////////////


//translate(v=[0,50,0])fobBox();
//fobBox2();
//clipSide();
rotate(a=[0,0,45])
union() {
clip();

clipCurve();

translate(v=[-33,8,1])cylinder(h=2,r=8,center=true,$fn=20);
}
