package main

import "core:fmt"
import "core:os"

main :: proc() {
    for name in os.args[1:] { 
        fmt.printfln("Hi there, %s!", name)
    }
}

//This divides by the words, which can cause problems in the command line. 
//To fix, just use speech marks in the command line argument. 

