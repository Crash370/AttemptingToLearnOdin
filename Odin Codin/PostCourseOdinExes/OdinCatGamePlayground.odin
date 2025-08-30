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

//global test variable
testStepOne := 7


//main :: proc() {
mainPlayground :: proc() {
    fixedArrays()
    //allTheLoops()
    //precedenceInAndOr()
    //ifStatementsWithoutCurlies()
    //untypedTypes()
    //initializingADecimal()
    //dynamicArray()
    //randTest()
    //testResult := strInput("Punctuation Clean Check. Please enter a sentence with punctuation:")
    //os.exit(-1)
}

fixedArrays :: proc() {
    lookAFixedArray: [10]int 
    aFilledArray := [10]int {1,2,3,4,5,6,7,8,9,10}
    fmt.printfln("We're going to fetch an item now: %d", aFilledArray[1])
    captureValue := aFilledArray[4]
    aFilledArray[4] = 32
    fmt.printfln("Also look! The [4] value isn't %d anymore, its %d", captureValue, aFilledArray[4])

    for n in aFilledArray{
        fmt.println(n)
    }
    //and you can reverse it! 
    #reverse for m in aFilledArray{
        fmt.println(m)
    } 
}

allTheLoops :: proc() {
    counter : int = 0
    //prints forever untill we break it
    for {
        counter += 1
        fmt.println("Looping...")
        if counter == 3 do break
    }
    fmt.println("Break")
    //for with condition
    for counter < 6 {
        counter += 1
        fmt.println("Looping 2...")
    }
    fmt.println("Break")
    //for with fixed number of loops
    for j:= 0; j < 4; j += 1 {
        fmt.print("Looping 3...")
    }
    fmt.println("Break")
    //another one
    for i in 0..< 4 { // or... for i in 0..=10 for exmaple. that one runs untill it's more than 10 (a little unintuitive but sure)
        fmt.print("Looping 4...")
    }
    //labels! 
    outer: for i in 0..=5{
        inner: for y in 0..=2{
            fmt.printfln("Looping 5...")
            fmt.println("Breaking outer")
            break outer
        }
        fmt.println("Looping just kidding this won't run.")
    }
    //continues of course! 
    outerAgain: for j in 0..=20 {  //can't duplicate loop labels!!!
        if j % 2 == 0 do continue 
        else do fmt.printfln("Looping... %d", j)
    }
}

ifStatementsWithoutCurlies :: proc() {
    if true do precedenceInAndOrExtension() 
    fmt.printfln("This does work as an if call. testStepOne is now %d. Not that we should write Odin this way...", testStepOne)
}

precedenceInAndOr :: proc() {
    // && and || are shortcurcuiting. the moment one part of the condition is confirmed true (for ||) or false for && the check stops. lets demonstrate
    //testStepOne currently == 7
    if true || precedenceInAndOrExtension(){
        fmt.printfln("TestStepOne equals: %d", testStepOne)
        fmt.println("This should equal 7, because the extension never gets a chance to run.") 
    }
}

precedenceInAndOrExtension :: proc() -> bool {
    testStepOne = 8
    return true
}

untypedTypes :: proc() {
    //Untyped types are the types used by CONSTANTS - like constants, they only exist at compile time. 
    CONSBOOL :: true //any constant value of true or false. 
    CONSINT :: 7 //type of any numeric constant without a . (So not 1.23 eg)
    CONSFLOAT :: 7.42 //type of any numeric constant with a period, like 7.42
    CONSSTRING :: "A string" //type of anything between the speech marks.
    CONSRUNE :: 'A' //type of any single character constant. Some chinese characters do not compile as an inferred rune - must be cast to i16 instead.
                                                            //========================================================================================
    //CONSNIL :: nil -------- a type of nil. can be cast to anything that supports being in a nil state - pointers, enums and unions for example. 
    // Can't be used with type inference. some_variable := nil won't compile. (But does it work in runtime?)
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
    decimal_zeros :: 27.00 //CONSTANT
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