#include <adv3.h>
#include <en_us.h>

versionInfo: GameID
    IFID = '6ea6787b-69be-f989-e03c-149ac8d00161'
;

gameMain: GameMainDef
    initialPlayerChar = me
;

me: Actor
    location = westOfHouse
;

westOfHouse : Room 'West of house'
    "You are standing in an open field west of
     a white house, with a boarded front door."
;

+ mailbox : OpenableContainer 'mailbox' 'small mailbox';

++ leaflet : Thing 'leaflet' 'leaflet';
