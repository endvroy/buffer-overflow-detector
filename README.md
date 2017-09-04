This is a template for a project to help teach how to implement a static
dataflow analysis inside LLVM. It involves computing the possible ranges of
values for variables and using these ranges to identify potential buffer
overflows.

Building with CMake
==============================================
1. Create a new directory for building.

        mkdir overflowerbuild

2. Change into the new directory.

        cd overflowerbuild

3. Run CMake with the path to the LLVM source.

        cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=True \
            -DLLVM_DIR=</path/to/LLVM/build>/lib/cmake/llvm/ ../overflower-template

4. Run make inside the build directory:

        make

This produces a tool called `bin/overflower`.

Note, building with a tool like ninja can be done by adding `-G Ninja` to
the cmake invocation and running ninja instead of make.

Running
==============================================

First suppose that you have a program compiled to bitcode:

    clang -g -c -emit-llvm ../overflower-template/test/c/01-charbuffer.c -o 01.bc

Running the overflow analyzer:

    bin/overflower 01.bc

When you have successfully completed the project, running the overflower as
above should print the results in CSV format. The file should be formatted as
follows:

    <Context>, <Function of access>, <Line of access>, <Size of buffer>, <Possible range for access>

