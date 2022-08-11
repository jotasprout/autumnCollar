// Name of Owner
key charlotte                       = "686369a4-3469-4bc8-8eb9-b2d860fe39ff";
string textureLess                  = "cf6c76fa-8099-7d6a-233c-507d9dfcf8b5";
string textureHappy                 = "6b6650a8-ec90-4c7f-8f96-ce71b32eb873";
string textureHappier               = "45ce4150-b369-cc41-d8e9-ff8467a4c272";
string textureHappiest              = "3f7f5f8f-7abd-e4ab-9ad0-342ea7072be8";
float trigger                       = 1.00;
float ownerTimeout                  = 5.00;
float timeout                       = 0;
integer ownerPresent                = FALSE;
integer mutex                       = FALSE;

beLessHappy() {
    llSetTexture(textureLess, ALL_SIDES);
}

beHappy() {
    if( mutex == TRUE )
        return;
    llSetTexture(textureHappy, ALL_SIDES);
}

beHappier() {
    if( mutex == TRUE )
        return;
    llSetTexture(textureHappier, ALL_SIDES);
}

beHappiest() {
    if( mutex == TRUE )
        return;
    llSetTexture(textureHappiest, ALL_SIDES);
}

default
{ 
    state_entry() {
        llSetTexture(textureLess, ALL_SIDES);
        llSensorRepeat("", charlotte, AGENT_BY_LEGACY_NAME, 20.0, PI, trigger);
        llSetTimerEvent(1);
    }
    
    sensor(integer numDetected){
        ownerPresent = TRUE;
        timeout = ownerTimeout;
        vector detectedPos = llDetectedPos(0);
        vector myPos = llGetPos();
        float distance = llVecMag( detectedPos - myPos );    
        if( distance < 20.0 ){beHappy();} 
        else if( distance < 10.0 ){beHappier();} 
        else if( distance < 3.0 ){ beHappiest();}
    }

    timer(){
        timeout--;
        if( timeout == 0 )
        {
            ownerPresent = FALSE;
            beLessHappy();
        }
    }
}