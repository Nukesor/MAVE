TODO
====

## Version 0.1

### Code
- Möglichkeit, mehrere Cutiegegner zu spawnen
- Maussupport im Menu

### GFX
- Arena fertig
- Menubuttons

## Future

### Code
- Wichtig: Wenn eine Component von einer Entity entfernt wird, Systemeinträge über die Engine updaten
- Möglichkeit für Systeme implementieren, gar keine Entities als Targets zu haben

### GFX
- Backgrounds für GameOver-, Win-, und MenuState
- Neuen Font suchen, der nicht so beschissen ist

### Sonstiges
- Lizenz raussuchen

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

- Fehler tritt auf, bei Collision von Enemycutie und Shot. Nicht immer, nicht reproduzierbar.

Error: collisions/shotCutieCollision.lua:13: attempt to index a nil value
stack traceback:
        collisions/shotCutieCollision.lua:13: in function <collisions/shotCutieCollision.lua:10>
        systems/collisionSelectSystem.lua:35: in function 'fireEvent'
        core/engine.lua:107: in function 'fireEvent'
        states/MainState.lua:233: in function <states/MainState.lua:232>
        [C]: in function 'update'
        states/MainState.lua:191: in function 'update'
        core/stackhelper.lua:49: in function 'update'
        main.lua:54: in function 'update'
        [string "boot.lua"]:407: in function <[string "boot.lua"]:373>
        [C]: in function 'xpcall'