package main

import "core:fmt"
import "core:strconv"
import "core:os"

total: int = 0

main :: proc() {
    //the + operator is not supported for strings. 
    //to do it we need strconv above. 
    a, b: int
    

    for arg in os.args[1:] {
        fmt.printfln("Got the number %d", checkValidVal_OrFail(arg))
    }
    fmt.printfln("TOTAL: %d", total)

    //the latter value of parse_int is a boolean - it will return false if a 
    // number can't be returned.

    //note - the okayA and okayB variables aren't ideal - we don't
    //want to repeat variables. so we can predeclare variables 
    //above and then redeclare them in the method calls

    //you can see here that the integer conversion will happen 
    //regardless - the string will come out as a 0.
    //but not with printfln - it will error if one of the arguments
    // is a string.  

    //to declare a variable in Odin use := . To change it's value
    //use = as per normal.
    
    name := "Fun New Name!"
    name = "Even More Fun Updated Title"

    newBoolTest := "floooooo"
    boo, ok := strconv.parse_bool(newBoolTest)
    fmt.println(boo, ok)
    fmt.printfln("the entry %v is a bool? %v", newBoolTest, ok)
    //we can also convert strings to a bool in a similar way to how we converted 
    // the int earlier. 
    //we can also use %v in strings for interpolation. v is a more generic 
    // placeholder for variables, but this works perfectly well. 

    // 
}

double :: proc(newNum: int = 0) -> int {
    return newNum * 2
}

//when writing the arguments here, it's the name of the variable first, 
// then the data type. nameOfVariable : dataType
checkValidVal_OrFail :: proc(targetString: string) -> int {
    
    n, valid := strconv.parse_int(targetString)
    
    if !valid 
    {
        fmt.eprintfln("Not a valid integer ( %s ) 0 will be used", targetString)
        //this is an error message (which prints to stderr instead of stdout - in red!)
        //os.exit(-1)
        return double(n)    
    }
    else 
    { 
        fmt.println(n)
        doubleN := double(n)
        total += doubleN
        return doubleN  
    }
}

//here we see how a method can be - and how the order of operation
// can change. (parameter in the brackets, name at the start, 
// return after the ->)
//this parameter is currently required - but you can add a default
//value on the end as well. 




