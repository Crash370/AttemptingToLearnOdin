package main

import "core:fmt"
import "core:os"
import "core:strconv"

main :: proc() {
    buf: [100]byte

    fmt.print("Enter something: ")
    bytes_read, err := os.read(os.stdin, buf[:])
    if err != nil {
        fmt.eprintln("Unable to open stdin:", err)
        os.exit(-1)
    }
    s := string(buf[:bytes_read-1])
    n, valid := strconv.parse_int(s)
    fmt.println(valid)
    if !valid{
        fmt.printfln("Not a valid number:---%s---", s)
        os.exit(-1)
    }

    //Some 

    fmt.printfln("I got a number %d", n)
    //the 'bytes_read -1' is to remove the enter value which is taken in the process
    // of taking the string. 
    //oddly the above works! but of course it does - the array is full of bytes. 
    fmt.println("You typed:", s)

    fmt.print("GHI")
    fmt.println("JKL")
    //print and print combine on the same line. but println and then print do not. 
    //print and then println do combine on the same line, which is odd.

    //enter is the 10 in the byte array, which explains why it is in the byte array
    //when we type something and it processes it as a byte array. 
}

// main :: proc() {
//     buf: [100]byte

//     fmt.print("Enter something: ")
//     bytes_read, err := os.read(os.stdin, buf[:])
//     if err != nil {
// 		fmt.eprintln("Unable to read from stdin:", err)
// 		os.exit(-1)
//     }

// 	s := string(buf[:bytes_read-1])
// 	n, ok := strconv.parse_int(s)
//     if !ok {
// 		fmt.eprintfln("Not a valid number: %s looklooklook", s)
// 		os.exit(-1)
//     }

//     fmt.printfln("I got a number: %d", n)
// }

//This one below read strings properly 

// main :: proc() {
// 	buf: [256]byte
// 	fmt.println("Please enter some text:")
// 	n, err := os.read(os.stdin, buf[:])
// 	if err != nil {
// 		fmt.eprintln("Error reading: ", err)
// 		return
// 	}
// 	str := string(buf[:n])
// 	fmt.println("Outputted text:", str)
// }



