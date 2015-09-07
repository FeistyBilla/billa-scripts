//This script is used to trim satallites
//without RCS into a stable user-specified orbit.
PARAMETER user_period.

FUNCTION trim {
PARAMETER orbper_new.

//Variables
SET orbper TO (OBT:PERIOD / 3600) - orbper_new.
SET orbper_old TO OBT:PERIOD / 3600.
SET vthrot TO 0.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
SAS OFF.

//Steer Craft in Correct Direction
IF orbper > 0 LOCK STEERING TO RETROGRADE.
IF orbper < 0 LOCK STEERING TO PROGRADE.
CLEARSCREEN.
PRINT "STABALIZING CRAFT".
PRINT " ".
WAIT 30.

//Trim the Orbit
PRINT "TRIMMING ORBIT".
PRINT " ".
WAIT 3.
UNTIL ABS(orbper) < 0.00001 {
	LOCK orbper TO ABS((OBT:PERIOD / 3600) - orbper_new).
	LOCK vthrot TO orbper * 2.
	IF vthrot > 1 LOCK vthrot TO 1.
	LOCK THROTTLE TO vthrot.
	WAIT 0.001.
}	
LOCK THROTTLE TO 0.

//Provide Output.
PRINT "ORBITAL PERIOD WAS " + ROUND(orbper_old , 6) + " HRS".
PRINT " ".
PRINT "ORBITAL PERIOD IS NOW " + ROUND((OBT:PERIOD / 3600) , 6) + " HRS". 
PRINT " ".

}

trim(user_period).

//End of Script
