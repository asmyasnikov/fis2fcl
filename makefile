CC	= g++
LEX	= flex -i
YACC	= bison

build: clean
	@if [ ! -d build ]; \
	then \
	    mkdir build; \
	fi
	@if [ ! -d build/src.gen ]; \
	then \
	    mkdir build/src.gen; \
	fi
	@if [ ! -d build/out ]; \
	then \
	    mkdir build/out; \
	fi
	$(LEX) -obuild/src.gen/fis2fcl-scan.cxx src/fis2fcl.l
#	$(YACC) -o build/src.gen/fis2fcl-parse.cxx src/fis2fcl.y
	$(CC) build/src.gen/fis2fcl-scan.cxx -o build/out/fis2fcl -lfl
#	$(CC) build/src.gen/fis2fcl-parse.cxx -o build/out/fis2fcl

clean:
	@rm -rf build

