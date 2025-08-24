package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:unicode/utf8"
import "core:math/rand"

main :: proc() {
    dynamicArray()
    //randTest()
    //testResult := strInput("Punctuation Clean Check. Please enter a sentence with punctuation:")
    //os.exit(-1)
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

strInput :: proc(chosenInput : string) -> string {
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