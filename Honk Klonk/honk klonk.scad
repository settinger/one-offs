// Hong Kong Clock (Honk Klonk) for Jake
// February 2017
// EttingerSam@gmail.com

// This is designed to replace the hour hand on the (discontinued?) VACKIS $1.00 alarm clock from IKEA. I assume it will fit on any small IKEA clock that uses the same quartz module.

//_font = "Palatino Linotype:style=Bold";
//_font = "Liberation Sans";
_font = "Georgia:style=Bold";
$fn = 200;
klonk_h = 0.84;
DST = false;

// Snap-fit clock center
module centerpiece() {
  difference() {
    cylinder(h=klonk_h, d=7.00, center=true);
    cylinder(h=klonk_h*2, d=3.15, center=true);
  }
}

// Module for creating new hour hands
module hourHand(_text, _time) {
  rotate([0, 0, _time*30]) {
    translate([0, 7, 0]) {
      union() {
        // hour hand main
        cube([2.032, 9, klonk_h], center=true);
        // hour hand text
        translate([0, 4.5, 0]) {
          linear_extrude(center=true, height=klonk_h) {
            text(_text, size=3, valign="bottom", halign="center", font = _font);
          }
        }
        // hour hand "serif" thing
        translate([0, 4.5, -klonk_h/6]) {
          cube([4,.25,2*klonk_h/3], center=true);
        }
      }
    }
  }
}

union() {
  centerpiece();
  hourHand("DE", DST ? 2 : 1); // Germany
  hourHand("HK", 8); // Hong Kong
  hourHand("LA", DST ? -7 : -8); // Los Angeles
}

// Some other options:
// hourHand("NY", DST ? -4 : -5); // New York
// hourHand("TX", DST ? -5 : -6); // Texas
// hourHand("EU", 8.45); // Eucla, Central Western Standard Time -- Need a special minute hand for this one as well 