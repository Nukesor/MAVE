default: build run

build:
	zip -r MAVE.love data/*
	cd src/ && zip -r ../MAVE.love *

run:
	make build
	love MAVE.love