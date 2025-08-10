package main 

import "core:fmt"
import "core:os"
import t "core:time"

//md work to create a directory (folder) called work. 

main :: proc() {
    fmt.println(len(os.args))
    fmt.println("Value of first arg:", os.args[0])
    fmt.println("Value of the slice:", os.args[1:/*3*/]) //oh look, a python slice! starts
    // with this index. can end it early too - this slice only holds two pieces. 

    //note that if you have the borders of your array over long (ie, there's no data 
    //to gather) the program will simply crash. no handrails here!

    vals := os.args[1:]

    if len(vals) < 3 {fmt.println("This program requires two args.")}
    else{
        fmt.println("Thank You!")
        for a, i in os.args[1:] {
            fmt.println(i+1, a)
        }

        //Here we can capture the number (i) and the item (a) and print both
        // which is handy. 

        //we're going to use printfln to use placeholders in our printing now. 
        //this has come up before but we're learning more about it now. 

        for a, i in os.args[1:] {
            fmt.printfln("% 5d. %10s", i+1, a)
            //note that this can't be used to combine numbers. 


        } // d% is the placeholder for an integer - the number (3) is how much width 
        // we want to give it. the space is to indicate that we don't want 0s to fill
        //empty space - we just want to pad that space. 

        // the placeholder for a string is %s.

        //we then pass the variables (arguments) in in the ORDER that they should
        //appear in the formatting string.  

        //what happens when we do %-3d instead? dash fill is my guess.
        //no it fills the opposite side with zeros - so 1 becomes 100. odd. 
        //adding numbers before the s just adds more spaces
    }


//this measures the number of arguments given in the command line +1, because
// the first item always contains something - turns out, its the directory of 
// the application (C:\Users\Chris\Desktop\Code Repo\Odin Codin\args\args.exe)

//We screwed ourselves around a bit by being in the wrong directory (there are 
// two similarly named directories )

//It's important this file is names after the folder it is in. This is how we run it by default. 

//It's a good habit to keep running these programs! That way you can see the errors
//that arise as you build them. 


//Exercise 1 - Index numbers of first and last elements are 0 and 9

//Exercise 2 - [2:4] returns 3 and 4, [5:10] errors, [5:11] errors, [6:2]
// ... will error? Lets find out. 

    values := [10]int{10,20,30,40,50,60,70,80,90,100}
    fmt.println("Array Check")
    fmt.println(values[2:4])
    fmt.println("Errors")
    fmt.println(values[5:10]) //this works because the arr only gather values up 
// to the final one - not the final one. so no 10th index is targeted. 

//fmt.println(values[5:11])
//fmt.println(values[6:2]) both error on compile.

//Exercise 3 - did above. Wrote code which wants two arguments. (Checking len 
// of os.args) 

//Exercise 4 - Print over even indexed args. 

    for a, i in os.args[1:] {
        if (i+1) % 2 == 1 {fmt.println("No I refuse to print that entry because it is odd!")}
        else {
            fmt.println(i+1, a)
        }
    }

//Exercise 5 - Use time to properly greet. 

    timeNow := t.now()
    timeHour, _ ,_ := t.clock_from_time(timeNow)
    greet := ""
    if timeHour < 12 && timeHour >= 5 {greet = "Good Mornin"}
    else if timeHour < 17 && timeHour >= 23 {greet = "Gd 'fternun"}
    else {greet = "G'Nit"}

    for a, i in os.args[1:] {
        fmt.println(greet, a)
    }

//Exercise 6 - Fix this code so that the game and the date of release are printed 
// together. 

    games := []string{"Donkey Kong", "Pacman", "Breakout", "Defender"}
    years := []int{1981, 1980, 1976, 1981}

    fmt.printfln("%15s | %4s", "GAME", "YEAR")
    fmt.println("")
    for g, i in games {
	    fmt.printfln("%15s | % 4d", g, years[i])
    }

//Exercise 7 - Trying to write a true false program. Explain why this fails. 
//(Because a bool is not a string, it cannot convert and errors.)

    // if len(os.args[1:]) < 1 {
	//     fmt.println("You must provide a command-line argument")
	//     os.exit(-1)
    // } else if len(os.args[1:]) > 1 {
	//     fmt.println("You provided too much information")
	//     os.exit(-1)
    // }

    // if os.args[1] == false {
	//     fmt.println("I cannot continue")
    // } else {
	//     fmt.println("Welcome!")
    // }

//Exercise 8 - Fix errors in this program so it compiles and prints all the 
// command line arguments. 

    if len(os.args[1:]) < 1
    {
        fmt.println("You didn't pass any arguments")
        os.exit(-1)
    } else {
        for a in os.args[1:] {
            fmt.println(a)
        } //needed the library before the args. 
    }

//Exercise 9  - Mod the above to check for a minimum number of arguments. DONE!

//Exercise 10 - Find the first argument (The name of the program) in console
//Also change the app name to verify

    fmt.println(os.args[0])

    //You can change the name of an app in windows with 'ren args.exe argybargy.exe'

//Exercise 11 - Try this program

    s := "Hellope!"

    for r in s {
	    fmt.println(r)
    } //presumed result is printing of characters.
    //I was right! 

//Exercise 12 - Fix this program 

    name := "Kwaku"
    age := 32

    fmt.printfln("%s is %d years old", name, age) //added string arguments here. 
}