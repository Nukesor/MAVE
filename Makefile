default: build run

clean:
	@[[ ! -e MAVE.love ]] || rm MAVE.love
	@[[ ! -e pkg ]] || rm -r pkg		

build: clean
	@zip -r -0 MAVE.love data/*
	@cd src/ && zip -r ../MAVE.love *

run: build
	@love MAVE.love
