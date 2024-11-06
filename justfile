set shell := ["nu", "-c"]

files := "main.c lib/utils.c"

run: compile
    @ ./bin/main.exe

compile:
    @ rm -rf bin
    @ mkdir bin
    @ gcc {{files}} -o bin/main.exe
