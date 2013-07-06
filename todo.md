TODO
====

## Version 0.1

### GFX
- Arena fertig
- Menubuttons

## Version 0.2

### GFX
- Wolkenplattformen 
- Lebensleiste
- Blutpartikel
- Arena fertig
- Menubuttons
- Backgrounds für MenuState
- Neuen Font suchen, der nicht so beschissen ist
- Explosives Fass
- Mine
- Gewehr
- Schild ? Oder wollen wir das als normales Schild bloss mit love zeichnen?

### Code

Shop/Menus:
- Shop System bauen 
    - Table fuer Waffen erstellen, Funktion schreiben, die sich den Status aus der Tabelle holt.
    - ItemComponent fuer Playercutie erstellen und mit Tabelle verlinken
- Boxmodel erstellen. 2 Boxmodels. Einmal fuer menu und einemal fuer item. Fertiges Layout fuer den Shop entwerfen.
- Images dynamisch auf Menu runterscalen. Funktion dafuer raussuchen. 
- Umstellen des SelectStates auf EntitySystem

Ingame:

- Schadenssystem ausfeilen
- Dynamische Drawuebergangfunktion fuer verschiedene Imagegroeszen.
- Mine einbauen. Proximity

Engine/ Core:
- Gamestack problem beheben, bei pop wird current():load() ausgefuehrt. Alle pop ersetzen durch pop pop push auszer es wird anders vorrausgesetzt
- Fullscreen support


## Bugs