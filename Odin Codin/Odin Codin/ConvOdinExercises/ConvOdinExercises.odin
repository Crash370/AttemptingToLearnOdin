package main 

//"C:\Users\Chris\Desktop\Code Repo\Odin Codin\ConvOdinExercises"

import "core:fmt"
import "core:strconv"
import "core:os"
import "core:strings"

endVal : int
valid : bool
minVal : string
maxVal : string

main :: proc() {
    fmt.println("----")
    fmt.println("MAIN")
    fmt.println("----")

    if len(os.args) == 3 { 
        equation_x_y()
        print_positives()
    } 

    if len(os.args) > 1 {

        //one_argument_multiplied()
        parser_for_bools_and_strings()
        bool_and_fifty_check()
        
        fmt.println("------------")
        fmt.println("INT AND EVEN")
        fmt.println("------------")
        for arg in os.args[1:] {
            int_and_even(arg)
        }
        string_followed_by_nums()
        max_and_min_numbers()
        greater_than_ten_less_than_thirty()
        average_of_numbers()

        fmt.println("DIVISIBLE BY TEN")
        for a in os.args[1:] {
            n, valid := strconv.parse_int(a)
            
            if valid_int_parse_check(valid, a) {
                if (n % 10) == 0 {
                    fmt.printfln("Divisible BY 10: %d", n)
                }
            }
        }
    }


    if len(os.args) > 1 {
        
        divisible_three_and_five(os.args[1], os.args[2])
    }
}

int_and_even :: proc(entry: string) { 

    endVal, valid = strconv.parse_int(entry)
    if valid && endVal % 2 == 0 {
        fmt.printfln("Caught one! %d", endVal)
    } 
}

string_followed_by_nums :: proc(){
    fmt.println("-----------------------")
    fmt.println("STRING FOLLOWED BY NUMS")
    fmt.println("-----------------------")
    

    even : bool
    argNew: int 

    if strings.to_lower(os.args[1]) == "even" {
        even = true
        fmt.println("LOOKING FOR EVENS")
    } else if strings.to_lower(os.args[1]) == "odd"{
        even = false
        fmt.println("LOOKING FOR ODDS")
    }  else {
        fmt.eprintfln("Initial string must be either 'even' or 'odd'")
    }

    for arg in os.args[2:] { 
        argNew,valid = strconv.parse_int(arg)

        if valid_int_parse_check(valid, arg) {
            if (even && argNew % 2 == 0) || (!even && argNew % 2 == 1){
                fmt.printfln("Success! Found %d", argNew)
            }
        }
    }
}

divisible_three_and_five :: proc(minimumP: string, maximumP: string) {

    fmt.println("------------------------")
    fmt.println("DIVISIBLE THREE AND FIVE")
    fmt.println("------------------------")

    minVal,valid := strconv.parse_int(minimumP)

    if valid_int_parse_check(valid, minimumP) {
        maxVal,valid := strconv.parse_int(maximumP)
        if valid_int_parse_check(valid, maximumP){

            if minimumP >= maximumP{
                fmt.eprintfln("The min value is higher than or equal to the max one.")
                fmt.eprintfln("This method will not run.")   
            } else {

                for i in minVal..=maxVal {
                if i % 3 == 0 && i % 5 == 0 { 
                    fmt.printfln("Found A Fizzbang! %d", i)
                }
            }
            }
            
        }
    }
}

max_and_min_numbers :: proc() {

    fmt.println("-------------------")
    fmt.println("MAX AND MIN NUMBERS")
    fmt.println("-------------------")

    highest := 0
    lowest : int
    first := true

    for arg in os.args[1:] {
        newVal,valid := strconv.parse_int(arg)
        if valid_int_parse_check(valid, arg){
            if first {
                highest = newVal
                lowest = newVal
                first = false
            } else {
                if newVal > highest {highest = newVal}
                if newVal < lowest {lowest = newVal}
            }
        }
    }

    fmt.printfln("The highest result is... %d", highest)
    fmt.printfln("The lowest result is... %d", lowest)
}

average_of_numbers :: proc() {

    fmt.println("------------------")
    fmt.println("AVERAGE OF NUMBERS")
    fmt.println("------------------")

    sum := 0
    lengthOf := 0

    for arg in os.args[1:] {
        newVal,valid := strconv.parse_int(arg)
        if valid_int_parse_check(valid, arg){
           sum += newVal
           lengthOf += 1
        }
    }

    fmt.printfln("The average of these numbers IS!!! %v", sum / lengthOf)
    fmt.println("(This is currently wrong due to it being whole integers and not floats)")
}

greater_than_ten_less_than_thirty :: proc() {
     
    fmt.println("---------------------------------")
    fmt.println("GREATER THAN TEN LESS THAN THIRTY")
    fmt.println("---------------------------------")

    for arg in os.args[1:] {
        newVal,valid := strconv.parse_int(arg)
        if valid_int_parse_check(valid, arg){
           if newVal < 10 || newVal > 30 {

                fmt.printfln("Found one!: %d", newVal)
           }
        }
    }
}

bool_and_fifty_check :: proc() {

    fmt.println("--------------------")
    fmt.println("BOOL AND FIFTY CHECK")
    fmt.println("--------------------")

    booCheck,valid := strconv.parse_bool(os.args[1]) 
    if !valid {
        fmt.eprintfln("First argument is not a bool. Exiting...")
        os.exit(-1)
    }
        
    for arg in os.args[2:] {
        newVal,valid := strconv.parse_int(arg)
        if valid_int_parse_check(valid, arg){

           if booCheck && newVal >= 50 {fmt.printfln("Caught val >= 50: %d", newVal)}
           else if !booCheck && newVal < 50 {fmt.printfln("Caught val below 50: %d", newVal)} 
        }
    }
}

one_argument_multiplied :: proc() {

    oneTarget,valid := strconv.parse_int(os.args[1])
    if valid_int_parse_check(valid, os.args[1]) {

        for i in 1..=12 {
            fmt.printfln("%d * %d = %d", oneTarget, i, oneTarget * i)
        }
    }
}

parser_for_bools_and_strings :: proc() {

    fmt.println("----------------------------")
    fmt.println("PARSER FOR BOOLS AND STRINGS")
    fmt.println("----------------------------")

    for arg in os.args[0:]{
        valid = false 
        either := false 
        endVal,valid = strconv.parse_int(arg)
        if valid{ 
            fmt.printfln("%s converted to an integer.", arg)
            either = true
        }
        newBool : bool
        newBool,valid = strconv.parse_bool(arg)
        if valid{
            fmt.printfln("%s converted to a bool.", arg)
            either = true
        } 
        if !either {
            fmt.printfln("Failed to convert target: %s", arg)
        }
    }
}

equation_x_y :: proc() { 

    fmt.println("------------")
    fmt.println("EQUATION X Y")
    fmt.println("------------")

    x : int
    y : int
    valid2: bool 
    x, valid = strconv.parse_int(os.args[1])
    y, valid2 = strconv.parse_int(os.args[2])

    if valid_int_parse_check(valid, os.args[1]) && valid_int_parse_check(valid2, os.args[2]) { 
        fmt.printfln("3x + 5y - 14 = %d", (3 * x) + (5 * y) - 14)
    }
}

print_positives :: proc() { 
    sum_of_evens := 0
    n : int
    for a in os.args[2:] {
    n, valid := strconv.parse_int(a)

        if valid && n % 2 == 0 && n > 0 {
            sum_of_evens += 1
        } 
    }

    fmt.printfln("The sum of all even numbers is: %d", n)
}

valid_int_parse_check :: proc (boolCheck : bool, vcValue : string) -> bool {
    // fmt.println("VALID INT PARSE CHECK")
    // fmt.println("---------------------")
    if !boolCheck {
        fmt.eprintfln("Value is not valid: %s", vcValue)
        return false
    } else {
        return true
    }
}

//Exercise 1 - return the values that can be converted into ints and are even. (DONE)

//Exercise 2 - Write a program that expects a string followed by numbers. first (DONE)
// argument should be even or odd.  

//Exercise 3 - Write a program that only prints numbers divisible by 3 and 5. (DONE)

//Exercise 4 - Write a program that reads the command line arguments and finds
// the highest and lowest number (DONE)

//Exercise 5 - Write a program that averages the numbers passed in. (DONE)

//Exercise 6 - Print numbers that are greater than 10 and less than 30. (DONE)

//Exercise 7 - Find issues in code (DONE) 

//Exercise 8 - Write a probgram expecting a boolean argument followed by 1+ (DONE) 
// integer arguments. If these fail print an error and exit. 
// If the bool is true print args >= 50, if false, less than 50

//Exercise 9 - One argument. Exitwith an error message if not. Covert the value ot a number and verify it is
// between 1 and 12. Then print out a multiplication table. (DONE) 

//Exercise 10 - Write a program that parses the command-line arguments that it receives. For each
// try to convert to an integer, try converting to a bool. if that fails, print an error. (DONE) 

//Exercise 11 - Write a program that takes two command line arguments and prints 3x + 5y - 14 (DONE)



