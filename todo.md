TODO
====

## Version 0.1

### GFX
- Arena fertig
- Menubuttons

## Version 0.2

### GFX
- Wolkenplattformen (evtl particle system?). Ne man. particleSystems sehen zu unbeständig aus, da bekommst du Augenkrebs. lieber pngs
- Lebensleiste
- Blutpartikel
- Arena fertig
- Menubuttons
- Backgrounds für MenuState
- Neuen Font suchen, der nicht so beschissen ist
- Explosives Fass
- Granate
- Gewehr
- Schild ? Oder wollen wir das als normales Schild bloss mit love zeichnen?

### Code
- Fullscreen support
- SlowMotionSystem (?)
- Schadenssystem ausfeilen
- Lebensleiste
- Dynamische Schussposition fuer granaten und shots. 
- Menu Wobble in Systems bauen. Images den Parameter "wobble" mitgeben, um zu drawen. 
- Shop System bauen 
    - Table fuer Waffen erstellen, Funktion schreiben, die sich den Status aus der Tabelle holt.
    - ItemComponent fuer Playercutie erstellen und mit Tabelle verlinken


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


Gui Draw + scaling update problem. kein dt in draw. draw nach update auslagen ?