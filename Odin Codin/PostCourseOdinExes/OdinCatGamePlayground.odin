//package main
package OdinCatGame

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:unicode/utf8"
import "core:math/rand"

/* LEARNING THROUGH DOING

    We're going to use a book to learn how to do some more work with Odin. We're hoping to add some of what we learn to 
    the game itself as well, but for now we'll work here. 

    Use this link file:///C:/Users/Chris/Dropbox/1-%20Projects%2010%20to%2020/odin_book.html in Chrome. 

    COMBINED PACKAGES
    1) When using 'odin run .' This combines all the projects in the current folder into one (the . targets all .odin files) - assuming they share the same package. 
    This is important. It means that you can't have duplicate methods between these scripts - such as MAIN. 
    
    This tells us that we need one main with which to kick off the two scripts - if we were to combine them in this way (We've renoted
    the package back to main above.)
    I'm going to use this to refactor to allow the playground to be used when needed. It's super easy to combine them when running this command
    in this way - just can't duplicate procedure/method/function names. 
    ALSO ALSO, no imported package can have the same name. Be careful about that. 

    FMT - is short for 'format'

    LIBRARIES
    You can run odin build -help, which tells you more about creating more then executables like above - for example, a library. 

    ODIN OPTIONS
        odin build .
        ./filename run .
        odin run . 
        odin run filename.odin -file
        odin run . -vet -semicolon (runs but checks for ; in the script - because they're not recommended for use even if they do work.)
        odin run . -vet -strict-style (enables vetting rules and enforces the code style of core)

    NUMBERS AND DECIMALS
        int is a NUMBER in odin, and a sub type of int. to store any decimal number we use f32 - a floating point number which uses 32 bits of memory. 

    BASIC TYPES
        SIGNED INTS: int (i32 on a 32 bit computer, i64 on a 64 bit computer) i8 i16 i32 i64 i128
        Positive or negative

        UNSIGNED INTS: uint (32 or 64 depending on the PC), u8, u16, u32, u64, u128, uintptr (Special unsigned int of pointer size (We'll learn))
        These are positive whole numbers (including 0)

        FLOATS: f16, f32, f64
        Positive and negative decimals. More bits, bigger, more precise decimals. Can assign however large a number you want. If the number is too high, 
        the float WILL TAKE ON POSITIVE OR NEGATIVE INFINITY.

        BOOLS: bool (equivalent to b8 - uses 8 bits/1 byte), b8, b16, b32, b64
        false or true. 0 = false. the other variants are for interfacing with other programming languages and won't be used often. 

        STRING: string
        Possible values: test as UTF-8. Zero value is ""(empty string). There's also a cstring type for interfacing with the C programming language. 
        There are procedures to covert back and fourth in core:strings. More on strings later. 

        RUNES: rune
        A single UTF-8 string code point (in many cases a single character, but can be part of a grapheme cluster. More on this later.) A 32 bit signed integer internally.
 */

//main :: proc() {
mainPlayground :: proc() {
    initializingADecimal()
    //dynamicArray()
    //randTest()
    //testResult := strInput("Punctuation Clean Check. Please enter a sentence with punctuation:")
    //os.exit(-1)
}

initializingADecimal :: proc() {
    decimal_no: f32 = 7
    decimal_no_alt := f32(7)
    //bothof these work for setting up a whole number in a decimal. 
    fmt.println(decimal_no)
    fmt.println(decimal_no_alt)

    decimal_64 := 7.42
    fmt.println(decimal_64) // oddly this prints 7.4199999999999999. Needs some rounding. 
    //the above defaults to f64 - a floating point with 64 bits of memory.

    pig_no := 7
    //decimal_fail: f32 = number //This FAILS
    decimal_fail :: 27.12
    //int_fail: int = decimal_fail //And this FAILS - An int and can't accomodate numbers with a fractional part. If it had all 00 in the decimals it would be a-OK.
    // (If it fits into the relevant type of number - a high number might still fail on i8 for example.)
    decimal_success := f32(decimal_fail) //This works
    decimal_zeros :: 27.00
    int_succ: int = decimal_zeros
    //This is because Odin is strongly typed - so that variable has been set with an int and won't be changed. An untyped number is still alterable. 
    //Untyped floats can be converted to integers as long as no part of it is truncated (cut off).
    //by default decimals covert to f32 and whole to int. but we can prepare to covert them. 
    f32dec : f32
    f32dec = 7.42
}

dynamicArray :: proc() {
    dyn_arr: [dynamic]string

	// Will make `dyn_arr` grow:
	append(&dyn_arr, "test")
	
	fmt.println("After first append:")
	fmt.println("Capacity:", cap(dyn_arr)) // 8
	fmt.println("Length:", len(dyn_arr)) // 1

	// append 7 numbers to the dynamic
	// array. This will not make `dyn_arr`
	// grow since capacity is `8` after
	// first `append`.
	for i in 0..<7 {
		append(&dyn_arr, "test")
	}

	fmt.println("\nAfter 7 more appends:")
	fmt.println("Capacity:", cap(dyn_arr)) // 8
	fmt.println("Length:", len(dyn_arr)) // 8

	// Capacity is 8, length is 8. This
	// call to `append` will make `dyn_arr`
	// grow:
	append(&dyn_arr, "final")

	fmt.println("\nAfter one more append:")
	fmt.println("Capacity:", cap(dyn_arr)) // 24
	fmt.println("Length:", len(dyn_arr)) // 9

    for st in dyn_arr {
        fmt.println(st)
    }

    delete(dyn_arr)
}

randTest :: proc() { 
    data: [4]string = {"Hello", "There", "You", "Scallywag"}
    for i in 1..=10{
        fmt.println(rand.choice(data[:]))
    }
}

// strInput :: proc(chosenInput : string) -> string {
strInputPlayground :: proc(chosenInput : string) -> string {
    fmt.println(chosenInput)  
    buf : [100]byte
    n,err := os.read(os.stdin,buf[:])

    //Need to find an acceptable error set up for this. 
    if err != nil{
        fmt.println("Error: ", err)
        os.exit(-1)
    }
    modString := strings.clone(strings.to_lower(strings.trim_space(string(buf[:n-1]))))
    punctuation : = "abcdefghijklmnopqrstuvwxyz "
    cloneModString := strings.clone(modString)
    for character in cloneModString{
        if !(strings.contains_rune(punctuation, character)) {
            buf, n := utf8.encode_rune(character)
            charConv := string(buf[:n])
            modString, _ = strings.remove_all(modString, charConv)
        } 
    }
    
    fmt.printfln("result of clean ---%s---", modString)
    return strings.clone(modString)
    //fmt.println("Caught ==", strName)
}