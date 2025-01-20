# Lucia Raciti, Fundamentals of Computing, 12/15/24
# Makefile for lab11

project: project.c
	gcc project.c gfx2.o -lX11 -o project

clean:
	rm project 
