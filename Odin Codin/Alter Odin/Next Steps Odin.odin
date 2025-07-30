package main        

import "core:fmt"

main :: proc() { 
    //What happens if we change proc to PROC? 
    // A cascase of syntax errors.

    //what happens if we change main to start? 
    // it errors due to an undefined entry point (no main)

    first := "First"
    second := "Second"
    third := "Third"

    fmt.println(first)
    fmt.println(second)
    fmt.println(third)

    //Ex 1 - Print name 
    fmt.println("Rob")
    
    //Ex 2 - Print 1-10. How would you print 1-10000?

    num1 := 10

    for i in 1..=num1 {
        mes := "The number is:"
        fmt.println(mes,i) //this auto adds spaces between entries, interestingly.
        //To clear powershell, type in 'clear'
    }

    //Ex 3 - print instead of println

    fmt.print("The print one") 
    fmt.print("The print one") 
    fmt.print("The print one") //They combine lines. 


    //Ex 4 - Print every month of the year using only what you know now. 
    fmt.println("January")
    fmt.println("February")
    fmt.println("March")
    fmt.println("April")
    fmt.println("May")
    fmt.println("June")
    fmt.println("July")
    fmt.println("August")
    fmt.println("September")
    fmt.println("October")
    fmt.println("November")
    fmt.println("December")

    //Ex 5 - You use double quotes for strings. Exercise end. 

    //Ex 6 - String interpolation? 
    lang := "Odin"
    fmt.printfln("I am currently learning %s", lang)

    //you need the f in printfln for this to work

    //Ex 7 - ODIN IS CASE SENSITIVE

    //Ex 8 - package shouldn't be Package. You need to import the sub library of core ("core:fmt")
    // not just core. main :: proc not proc :: main. println, not printn

    //Ex 9/11 (Because two of the exercises are buried in main, above) -
    // What does this do?  

            /* package main

        import "core:fmt"

        main :: proc() { */
            a := 3
            b := 1

            fmt.println("a + b =", a+b)
            fmt.println("a - b =", a-b)
            fmt.println("a * b =", a*b)
            fmt.println("a / b =", a/b) //dividing integers results in 1 - rounded down.
            //transforming the number to 0 means the program stops.
        

    // Sets up a and b as variables before printing out the results of adding, subtracting,
    // multiplying and dividing the two. 

    //Ex 10/12 - What does this do? 

    knows_odin := true

    if knows_odin {
        fmt.println("Huh, he knows a bit of Odin")
    } else {
        fmt.println("Lol, knows nothing about Odin.")
    }

    //Print "I'll take it"

    //Ex 11/13 - Loops

    for i in 5..=20 {
        fmt.println(i)
    } 
    //Can we get this to print from 5 to 20? Yes. 

    //Default order of execution is from top to bottom? 

    //Final Ex - Can you use a loop to print every letter from A to Z

    //for r in 'A'..='Z' {
    //    fmt.println(r)
    //} //You sure can! 
}
