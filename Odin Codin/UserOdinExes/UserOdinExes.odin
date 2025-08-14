package main 

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

strName : string

main :: proc() {
    //strInput("YOU! What's your name?!!? ")    EXERCISE 1 DONE
    //fmt.println("Hi,", strName)           

    //dayOfTheWeek()                            EXERCISE 2 DONE

    // a: rune = 'A'
    // b := a + 2

    // fmt.println(b, "HERE")                   EXERCISE 3 DONE

    //Will this work? Doubt it. But a character (Rune?) could be incremented by a 
    // integer maybe? 
    //Correct - it increments to C

    // buf: [512]byte

    // fmt.print("Enter something: ")
    // bytes_read, err := os.read(os.stdin, buf[:])
    // if err != nil {
	// fmt.eprintln("Unable to read from stdin:", err)
    //     os.exit(-1)
    // }

    // s := string(buf[:bytes_read-1])
    // lc := strings.to_upper(strings.trim_right_space(s))
    // fmt.printfln(" You wrote: '%s'", lc)      // EXERCISE 4 DONE

    //This will transform the strings to lower at the end, in theory. 

    // buf: [10]byte

    // fmt.print("Enter something: ")
    // bytes_read, err := os.read(os.stdin, buf[:])
    // if err != nil {
	// fmt.eprintln("Unable to read from stdin:", err)
    //     os.exit(-1)
    // }

    // s := string(buf[:bytes_read-1])
    // fmt.printfln("You wrote: '%s'", s)           EXERCISE 5 DONE

    //This is going to fail if our argument is too long isn't it? 
    //Nope. It just captures what it can of what you enter. 

    //multipleOfTen()                               EXERCISE 6 DONE

    //oddsOrEvens()                                 EXERCISE 7 DONE

    //greatestNumber()                              EXERCISE 8 DONE
}

strInput :: proc(chosenInput : string) {
    fmt.print(chosenInput)
    buf : [100]byte
    n,err := os.read(os.stdin,buf[:])

    if err != nil{
        fmt.println("Error: ", err)
        os.exit(-1)
    }
    strName = strings.clone(strings.trim_space(string(buf[:n-1])))
    //fmt.println("Caught ==", strName)
}

dayOfTheWeek :: proc() {
    
    days := [7]string{"monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"}
    // targetDay := strings.to_lower(strInput("Enter a day of the week:"))
    // targetDay := strInput("Enter a day of the week:")
    // for day in days{
    //     fmt.printfln("TARGET%sTARGET", day)
    // }
    strInput("Enter a day of the week:")
    strName = strings.trim_space(strings.to_lower(strName))
    if strName == days[0] {
//OKAY, REALLY IMPORTANT. WE'VE BEEN BANGING OUR HEAD AGAINST THIS FOR THE PAST
//TWO DAYS AND AS IT TURNS OUT YOU NEED TO TRIM THE SPACE EITHER SIDE OF THE 
//COMMAND - BECAUSE IT ISN'T ENOUGH THAT THE ANSWER HAS BEEN CARVED FROM THE BYTES
// - IT ALSO NEEDS TO HAVE THE SPACE TRIMMED EITHER SIDE.

//IF THE CAPITALS FEELS LIKE FRUSTRATION ITS BECAUSE THEY ARE.
        fmt.println("Go back to bed, it's Monday.")
    } else {
        found := false
        for day in days[1:5] {
            //fmt.println(day, "TODAY")
            if day == strName {
                fmt.println("Go to work maybe, it's the other working days.")
                found = true
                break
            }
            
        }
        if !found {
            for day in days[5:] {
                if day == strName {
                    fmt.println("It's the weekend!")
                    found = true
                    break
                }
            }
        }
        if !found { fmt.println("This day doesn't exist.")}
    } 
}

multipleOfTen :: proc() {
    
    strInput("Enter a number:")
    numConv, valid := strconv.parse_int(strName)
    if !valid{
        fmt.eprintln("Could not convert argument to a number. Exiting...")
        os.exit(-1)
    } 
    if numConv % 10 == 0 {
        fmt.println("WOO")
        fmt.printfln("The number %d is divisibly by 10!", numConv)
    } else {
        fmt.printfln("The number %d is not divisible by ten. Sadness.", numConv)
    }

}

// convInt :: proc(target: string) -> int,bool {

//     numConv, valid := strconv.parse_int(target)
//     if !valid{
//         fmt.eprintln("Could not convert argument to a number. Exiting...")
//         return 0, false
//     } 
//     return numConv, true
// }

oddsOrEvens :: proc() {
    numbers := 5
    for i in 1..=5 {
        fmt.printfln("You have %d inputs remaining.", numbers)
        numbers = numbers - 1
        strInput("Enter a number:")

        numConv, valid := strconv.parse_int(strName)
        if !valid{
        fmt.eprintln("Could not convert argument to a number.")
        } else if numConv % 2 == 1 { 
            fmt.printfln("That is an odd number.")
        }
    }

    fmt.println("You are out of numbers!")
}

greatestNumber :: proc() {
    numbers := 10
    highest : int 
    first : bool = true
    for i in 1..=10 {
        fmt.printfln("You have %d inputs remaining.", numbers)
        numbers = numbers - 1
        strInput("Enter a number:")

        numConv, valid := strconv.parse_int(strName)
        if !valid{
        fmt.eprintln("Could not convert argument to a number.")
        } else if first { 
            first = false
            highest = numConv
        } else if numConv > highest {
            highest = numConv
        }
    }

    fmt.println("You are out of numbers!")
    fmt.printfln("THE GREATEST. WAS. FRIENDSHIP!")
    fmt.printfln("But actually it was %d", highest)
}

