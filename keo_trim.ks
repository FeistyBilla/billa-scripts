//This script is used to trim satallites
//without RCS into a stable KEO orbit.

//Variables
SET orbper TO (OBT:PERIOD / 3600) - 6.
SET orbper_old TO OBT:PERIOD / 3600.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
SAS OFF.

//Steer Craft in Correct Direction
IF orbper > 0 LOCK STEERING TO RETROGRADE.
IF orbper < 0 LOCK STEERING TO PROGRADE.
CLEARSCREEN.
PRINT "STABALIZING CRAFT".
PRINT " ".
WAIT 10.

//Trim the Orbit
PRINT "TRIMMING ORBIT".
PRINT " ".
WAIT 3.
UNTIL ABS(orbper) < 0.000001 {
	LOCK orbper TO ABS((OBT:PERIOD / 3600) - 6).
	IF orbper > 1 LOCK orbper TO 1.
	LOCK THROTTLE TO orbper.
	WAIT 0.001.
}	
LOCK THROTTLE TO 0.

//Provide Output.
PRINT "ORBITAL PERIOD WAS " + ROUND(orbper_old , 7) + " HRS".
PRINT " ".
PRINT "ORBITAL PERIOD IS NOW " + ROUND((OBT:PERIOD / 3600) , 7) + " HRS". 
PRINT " ".

//End of Script
