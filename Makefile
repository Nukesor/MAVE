default: build run

clean:
	@[[ ! -e game.love ]] || rm game.love
	@[[ ! -e pkg ]] || rm -r pkg		

build:
	@zip -r -0 MAVE.love data/*
	@cd src/ && zip -r ../MAVE.love *

run: build
	@love MAVE.love
