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

Ingame:

- Schadenssystem ausfeilen
- Dynamische Drawuebergangfunktion fuer verschiedene Imagegroeszen.
- Mine einbauen. Proximity
- Schuss loest explosives aus.

Engine/ Core:
- Dynamische Erstellung und updaten
 der Entitylists im Engine
- Gamestack problem beheben, bei pop wird current():load() ausgefuehrt. Alle pop ersetzen durch pop pop push auszer es wird anders vorrausgesetzt
- Fullscreen support


## BUGS
- Fehler Tritt auf, wenn Playercutie destroyed werden soll.

        Error: states/MainState.lua:210: A body has escaped Memoizer!
                stack traceback:
        [C]: in function 'destroy'
        states/MainState.lua:210: in function 'restart'
        states/GameOverState.lua:39: in function 'update'
        core/stackhelper.lua:49: in function 'update'
        main.lua:54: in function 'update'
        [string "boot.lua"]:407: in function <[string "boot.lua"]:373>
        [C]: in function 'xpcall'