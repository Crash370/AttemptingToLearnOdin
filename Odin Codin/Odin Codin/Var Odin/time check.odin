package main

import mainPack "core:fmt"
import t "core:time"
import "core:strconv"
import "core:strings"
//note - we can alias this package name. that what the t is for 
//obs be careful not to create matching names.  

main :: proc() { 
    tNow := t.now()
    h, _, _ := t.clock_from_time(tNow)
    //Creating a time object from time now and applying that to a strange new variable which
    // is presumably our clock. 

    //the _ are discarded variables. we aren't looking at the minutes and seconds so 
    // _ is effectively jettisoning 2 of the returns. 
    hourCorrection := h + 1

    if hourCorrection < 23 && hourCorrection >= 17 {
        mainPack.println("Good Evening")
    } else if hourCorrection < 17 && hourCorrection >= 12 {
        mainPack.println("Good Afternoon")
    } else if hourCorrection < 12 && hourCorrection >= 4 {
        mainPack.println("Good Morning")
    } else {
        mainPack.println("Good Night")
    }
    //this prints out the hour in 24h time = except the hour is one hour behind. no idea why.

    hour, m, s := t.clock_from_time(tNow)

    hour = hour + 1

    //Exercise 1 
    mainPack.println("The time is...")
    mainPack.printfln("%02d:%02d:%02d", hour,m,s)
    //There we go. 
    //Those codes in the string would be worth learning about. 

    //Exercise 2 - Add some string. 
    is_hungry := true

    if !is_hungry {
        mainPack.println("What would you not like to eat?")
        //Just like everywhere else we can use the explanation mark as NOT
    } else {
        mainPack.println("Would you like something to drink?")
    } 

    //Exercise 4 - Fizz Buzz again. > 15 too large, 3 fizz, 5 buzz, 15 fizzbuzz, 0 too low

    //import "core:strconv"
    //this must be done at the file scope - AKA, up there ^^^^

    for i in 0..=20 { 
        if i < 1 { mainPack.printfln("Too low")}
        else if i == 3 { mainPack.printfln("Fizz")}
        else if i == 5 { mainPack.printfln("Buzz")}
        else if i == 15 { mainPack.printfln("FizzBuzz")}
        else if i > 15 {mainPack.printfln("Too high")}
        else {
            mainPack.printfln("%1d", i)
            //theres a sort of regex present here - where removing the 0 here should
            //hopefully remove the 0 in front of our string. 
            //it did - unless the number was below 10. the 2 in the string represented 
            //how many values would be present at base. reducing to 1 meant no extra 0s
            //in front of the values. 
            }
    }

    //Exercise 5 - Good Day! 

    if hourCorrection < 23 && hourCorrection >= 17 {
        mainPack.println("Good Evening")
    } else if hourCorrection < 17 && hourCorrection >= 13 {
        mainPack.println("Good Afternoon")
    } else if hourCorrection < 13 && hourCorrection >= 12 { 
        mainPack.println("Good Day!")
    } else if hourCorrection < 11 && hourCorrection >= 4 {
        mainPack.println("Good Morning")
    } else {
        mainPack.println("Good Night")
    }

    //Exercise 6 - OR || | (Num lock, then alt, 124, release alt)
    for i in 1..=45 {
        if i < 20 || i > 40 {mainPack.printfln("out of range")}
    }

    //Exercise 7 - Minute Check

    _, mins, _ := t.clock_from_time(tNow)

    if mins <= 10 {mainPack.printfln("The hour has begun.")}
    else if mins >= 50 {mainPack.printfln("The hour nears its end.")} 
    else {mainPack.printfln("We are well into the hour.")}

    //Exercise 8 - Mod the above for the middle 

    //Exercise 9 - Program isn't working. Fix. 

    //"core:for" is not the correct import. also, >=, not =>

    //Exercise 10 - add time together 

    mainPack.printfln("The combined numbers of time are %1d", (hour+1)+m+s)

    //Exercise 11 - Can you add booleans? Probably 

    //intBool = true + false
    //mainPack.printfln(intBool)
    //Nope, currently struggling. 

    //Exercise 12 - Convert the clock_from_time into 12 hour time. 

    if hourCorrection > 12 {mainPack.printfln("%d:%d:%d", hourCorrection-12,m,s)}
    else {mainPack.printfln("%d:%d:%d", hourCorrection,m,s)}

    //Exercise 13 - Why doesn't the program work? 

    //You're declaring the values wrong. It's not =, it's :=

    //Exercise 15 (One was skipped for some reason)

    age := 27

    mainPack.printfln("I am now %d years old.", age)

    age2 := age + 1
    mainPack.println("A year passes")
    mainPack.printfln("I am now %d years old.", age2)

    //Exercise 16

    //stringyLinux := "Linux"
    stringyLinux := "NetBSD"

    mainPack.println("I use", stringyLinux)
    //printfline is different from println. println allows us to more simply combine 
    //strings while fline gives us more control over other aspects with string codes. 

}