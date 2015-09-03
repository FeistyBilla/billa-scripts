// SCRIPT TO LAUNCH AND CIRCULARIZE FROM KERBIN

//VARIABLES
SET launch_count TO 3.
SET v_throttle TO 0.1.
SET angle_of_the_dangle TO 90.
SET in_flight TO 0.

//PRE-FLIGHT CHECKS
WAIT 1.
CLEARSCREEN.
WAIT 1.
SET SHIP:CONTROL:MAINTHROTTLE TO 0.
PRINT "=========================".
PRINT "STARTING LAUNCH SEQUENCE".
PRINT "=========================".
PRINT " ".
WAIT 1.5.
PRINT "CHECKING SYSTEMS...".
PRINT " ".
WAIT 2.
PRINT "STATUS IS A LITTLE BETTER THAN OK".
PRINT " ".
WAIT 0.5.
PRINT SHIP:NAME + " IS READY FOR LAUNCH...".
PRINT " ".
WAIT 1.

//COUNTDOWN & LAUNCH
UNTIL launch_count = 0 {
	PRINT "T-" + launch_count + "...".
	PRINT " ".
	SET launch_count TO launch_count -1.
	IF launch_count = 1 {
		STAGE.
		PRINT "FIRING ENGINES".
		PRINT " ".
	}
	WAIT 1.
}
LOCK THROTTLE TO 1.
WAIT 0.2.
PRINT "DISENGAGING STABALIZERS".
PRINT " ".
STAGE.
SET in_flight to 1.
PRINT SHIP:NAME + " IS AWAY".
PRINT " ".

//MOVIN' ON UP
WAIT UNTIL SHIP:ALTITUDE > 200. 
"BEGINNING TURN".
PRINT " ".
WAIT 0.5.
LOCK STEERING TO HEADING (90,90).
WAIT 2.
PRINT "ADJUSTING LAUNCH ANGLE BASED ON SHITTY FORMULA".
PRINT " ".

UNTIL SHIP:APOAPSIS > 80000 {
	IF SHIP:APOAPSIS < 80000 {
		SET angle_of_the_dangle TO (90 * (0.9 - SHIP:ALTITUDE / 70000)).
		LOCK STEERING TO HEADING (90,angle_of_the_dangle).
		IF MAXTHRUST = 0 {
			STAGE.
		}
	}
	WAIT 0.1.
}

LOCK THROTTLE TO 0.
LOCK STEERING TO SHIP:PROGRADE.
WAIT 1.
PRINT "WAITING FOR CIRCULARIZATION BURN".
PRINT " ".

//CIRCULARIZE

WAIT UNTIL SHIP:ALTITUDE > 70000.
PRINT "EXTENDING SOLAR PANELS & TURNING ON SOME LIGHTS".
PRINT " ".
WAIT 1.
ABORT ON.
WAIT UNTIL ETA:APOAPSIS < 10.
PRINT "GETTING FIRST AID SPRAY FOR THIS EPIC BURN".
LOCK THROTTLE TO 1.
UNTIL SHIP:PERIAPSIS > 75000 {
	IF MAXTHRUST = 0 {
		STAGE.
	}
	WAIT 0.1.
}
LOCK THROTTLE TO 0.
PRINT "YOU'RE ON YOUR OWN NOW...".
PRINT "GOOD LUCK IN SPACE, BRO.".
WAIT 10.