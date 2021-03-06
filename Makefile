all: libfizz.a rust c

c: main.c libfizz.a
	gcc -o main -L. -lfizz main.c

rust: rust/main.rs libfizz.a
	rustc -o rust_main -L. -lfizz rust/main.rs

libfizz.a: fizz.asm
	nasm -felf64 -o libfizz.a fizz.asm

clean:
	rm ./main ./rust_main libfizz.a *txt

test: c
	time ./main > c.txt
	time ./main asm > asm.txt
	diff -q c.txt asm.txt

.PHONY: rust c clean test
