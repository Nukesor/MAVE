default: run

clean:
	@[[ ! -e MAVE.love ]] || rm MAVE.love
	@[[ ! -e pkg ]] || rm -r pkg        

build: clean
	@zip -r -0 MAVE.love data/*
	@zip -r -0 MAVE.love lib
	@cd src/ && zip -r ../MAVE.love *

run: build
	@love MAVE.love
