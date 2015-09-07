// SCRIPT TO LAUNCH AND CIRCULARIZE FROM KERBIN

//VARIABLES
SET launch_count TO 3.
SET v_throttle TO 1.
SET angle_of_the_dangle TO 90.
SET let_em_fly TO 0.
SET cut_it_out TO 0.

//FUNCTIONS
FUNCTION drop_it_like_it_is_hot {
	IF (MAXTHRUST = 0 AND let_em_fly = 1) {
		STAGE.
		PRINT "JETTISONED SPENT STAGE".
		PRINT " ".
	}
}

FUNCTION steer_it {
	IF SHIP:ALTITUDE < 15000 {
		SET angle_of_the_dangle TO (90 * (0.9 - SHIP:ALTITUDE / 25000)).
		LOCK STEERING TO HEADING (90,angle_of_the_dangle).
	}
	IF (SHIP:ALTITUDE > 15000 AND SHIP:ALTITUDE < 30000 ){
		SET angle_of_the_dangle TO 35.
		LOCK STEERING TO HEADING (90,angle_of_the_dangle).
	}
	IF  SHIP:ALTITUDE > 30000 {
		SET angle_of_the_dangle TO 30.
		LOCK STEERING TO HEADING (90,angle_of_the_dangle).
	}
}

FUNCTION throttle_it {
	PARAMETER howfast.
	IF SHIP:SURFACESPEED > howfast {
		LOCK THROTTLE TO 0.5.
		}
	IF SHIP:SURFACESPEED < howfast {
		LOCK THROTTLE TO 1.
	}
}

FUNCTION fly_this_thang {
	IF SHIP:ALTITUDE < 45000 {
		SET cut_it_out TO ((400 + (SHIP:ALTITUDE / 10)) / 3).
		throttle_it(cut_it_out - (cut_it_out * 0.1)).
		WAIT 1.5.
		steer_it().
		drop_it_like_it_is_hot().
		WAIT 0.2.
	}
	IF SHIP:ALTITUDE > 45000 {
		LOCK THROTTLE TO 1.
	}
	steer_it().
	drop_it_like_it_is_hot().
	WAIT 0.2.
}

//FAKE PRE-FLIGHT CHECK OUTPUT
CLEARSCREEN.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
WAIT 1.
PRINT "=========================".
PRINT "STARTING LAUNCH SEQUENCE".
PRINT "=========================".
PRINT " ".
WAIT 1.5.
PRINT "CHECKING SYSTEMS...".
PRINT " ".
WAIT 2.
PRINT "STATUS IS SLIGHTLY BETTER THAN OK".
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
	}
	WAIT 1.
}
PRINT "START ENGINES AND RELEASE STABALIZERS".
PRINT " ".
LOCK THROTTLE TO 1.
STAGE.
SET let_em_fly TO 1.
PRINT SHIP:NAME + " IS AWAY".
PRINT " ".

//MOVIN' ON UP
WAIT UNTIL SHIP:ALTITUDE > 100. 
PRINT "STARTING TURN".
PRINT " ".
WAIT 0.5.
LOCK STEERING TO HEADING (90,90).
WAIT UNTIL SHIP:ALTITUDE > 500.
UNTIL SHIP:APOAPSIS > 80000 {
	fly_this_thang().
}
LOCK THROTTLE TO 0.
PRINT "COASTING TO APOAPSIS".
PRINT " ".
WAIT 3.
SET WARPMODE TO "PHYSICS".
SET WARP TO 3.

//CIRCULARIZE
WAIT UNTIL SHIP:ALTITUDE > 65000.
SET WARP TO 1.
WAIT UNTIL SHIP:ALTITUDE > 70000.
PRINT "LEAVING " + BODY:NAME + " ATMOSPHERE".
PRINT " ".
PRINT "EXTENDING SOLAR PANELS AND POWERING LIGHTS".
PRINT " ".
WAIT 2.
BRAKES ON.
WAIT 2.
ABORT ON.
LOCK STEERING TO PROGRADE.
WAIT 3.
LOCK THROTTLE TO 1.
PRINT "INITIATE BURN TO KEO".
PRINT " ".
WAIT 3.
UNTIL SHIP:APOAPSIS > 2800000 {
	drop_it_like_it_is_hot().
	WAIT 0.2.
}
LOCK THROTTLE TO 0.
WAIT 3.
SET WARPMODE TO "RAILS".
SET WARP TO 4.
WAIT UNTIL ETA:APOAPSIS < 120.
SET WARP TO 0.
PRINT "PREPARING FOR CIRCULARIZATION BURN".
PRINT " ".
LOCK STEERING TO PROGRADE.
WAIT UNTIL ETA:APOAPSIS < 15.
LOCK THROTTLE TO 1.
UNTIL SHIP:PERIAPSIS > 2750000 {
	drop_it_like_it_is_hot().
	WAIT 0.2.
}
LOCK THROTTLE TO 0.
SET let_em_fly TO 0.
PRINT "YOU ARE NOW ORBITING KERBIN".
PRINT " ".
PRINT "DO YOU KNOW WHAT YOU'RE DOING, FUCKER?".
PRINT " ".
PRINT "SHUTTING DOWN PROGRAM".
PRINT " ".
WAIT 5.