package main 

import "core:fmt"
import "core:strconv"
import "core:os"

main :: proc() {
     
    rangeMethodIncrement(10,30,1, "EXERCISE 1")
    rangeMethodIncrement(0,200,10, "EXERCISE 2")
    rangeMethodDecrement(100,5,5, "EXERCISE 3")
    rangeMethodIncrementBlackList(1,100,1,7,"EXCERCISE 4")
    rangeMethodIncrementFizzBuzz(1,100,1,"EXERCISE 5")
    rangeMethodIncrementWhiteList(1,30,1,3,"EXERCISE 6")
    printStringArrayReverse("EXERCISE 7")
    printStringArrayMonths("EXERCISE 8")

    if len(os.args[1:]) == 3 {
        commandLinePrintArgsTwoOnly()
    }
    
}

rangeMethodIncrement :: proc(min: int = 0, max: int = 0, increment: int = 1, title: string) {
    fmt.printf("%s: ", title) 
    for i := min; i <= max; i += increment { 
        fmt.printf("%d--", i)
    }
    fmt.println()
    fmt.println()
}

rangeMethodDecrement :: proc(min: int = 0, max: int = 0, decrement: int = 1, title: string) {
    fmt.printf("%s: ", title) 
    for i := min; i >= max; i -= decrement { 
        fmt.printf("%d--", i)
    }
    fmt.println()
    fmt.println()
}

rangeMethodIncrementBlackList :: proc
(min: int = 0, max: int = 0, increment: int = 1, excepting: int, title: string) {
    fmt.printf("%s: ", title) 
    for i := min; i <= max; i += increment { 
        if i % excepting == 0 { continue }
        fmt.printf("%d--", i)
    }
    fmt.println()
    fmt.println()
}

rangeMethodIncrementFizzBuzz :: proc
(min: int = 0, max: int = 0, increment: int = 1, title: string) {
    fmt.printf("%s: ", title) 
    for i := min; i <= max; i += increment { 
        if i % 15 == 0 { fmt.printf("FizzBuzz--") }
        else if i % 5 == 0 { fmt.printf("Buzz--") }
        else if i % 3 == 0 { fmt.printf("Fizz--") }
        else {fmt.printf("%d--", i)}
    }
    fmt.println()
    fmt.println()
}

rangeMethodIncrementWhiteList :: proc
(min: int = 0, max: int = 0, increment: int = 1, whiteMatch: int, title: string) {
    fmt.printf("%s: ", title) 
    for i := min; i <= max; i += increment { 
        if i % whiteMatch != 0 { continue }
        fmt.printf("%d--", i)
    }
    fmt.println()
    fmt.println()
}

printStringArrayReverse :: proc(title: string) {
    fmt.printf("%s: ", title)  
    weekdays := []string{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
    #reverse for day in weekdays{
        fmt.printf("%s--",day)
    }
}

printStringArrayMonths :: proc(title: string) {
    fmt.printf("%s: ", title)  
    months := []string{"January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November", "December"}
    for mon, i in months{
        if mon == "March" {
            fmt.printfln("%d. *** %s ***", i, mon)
            continue
        }
        fmt.printfln("%d. %s", i+1, mon)
    }
}

commandLinePrintArgsTwoOnly :: proc(oddNumbers: bool = false) {
    
    min: int 
    for arg, i in os.args[1:3] {
        newArg, valid := strconv.parse_int(arg)
        
        if valid {

            if i == 0 { 
                min = newArg
                if boolAndNumCheck(oddNumbers, newArg){
                    fmt.println(newArg)
                } else { fmt.println("NOT FOUND")}
                continue            
            }
            if newArg <= min{
                fmt.eprintfln("ERROR: Number is not greater than the previous number")
                os.exit(-1)
            }    
            if boolAndNumCheck(oddNumbers, newArg){
                fmt.println(newArg)
            } else { fmt.println("NOT FOUND")}
        }

    }
}

boolAndNumCheck :: proc(oddNumberExt: bool = false, numExt: int) -> bool {
    return (!oddNumberExt && numExt % 2 != 0) || (oddNumberExt && numExt % 2 == 0)
}
