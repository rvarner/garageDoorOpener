
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
fobThickB = 10.30;
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
module fobBoxBlank() {
	translate(v=[0,0,(fobWidth + (2*fobBoxWallThickness))/2])
	cube([fobLenA + (2 * fobBoxWallThickness), fobThickB + fobBoxRetainerThickness, fobWidth + (2*fobBoxWallThickness)],
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
module fobBox2() {
	union() {
	fobBox();
	translate(v=[0,-9.2,0])
	difference() {
		scale(v=[1,.5,1]) fobBoxBlank();
			translate(v=[0,0,2.5 + fobWidth + (fobBoxWallThickness) -0.01]) cube([200,200,5],center=true);
	}}
}
//fobBox2();

///////////////
// Execution //
///////////////
//fobBox();
difference() {
	rotate(a=[0,0,45])
	union() {
		translate(v=[51,24,0]) rotate(a=[0,0,3.5]) fobBox2();
		scale(v=[1.8,1,1.3]) moneyClip();
	}
	translate(v=[-2,16.5,25]) rotate(a=[0,0,48]) cube([14,10,50],center=true);
	translate(v=[3.8,19.8,25]) rotate(a=[0,0,7]) cube([14,4,50],center=true);
}










