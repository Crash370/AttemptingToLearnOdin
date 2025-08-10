package main 

import "core:fmt"

main :: proc() { 

    for i in 1..=10 {
        fmt.println(i)
    }

    for i := 10; i >= 1; i -= 1 { 
        fmt.println(i)
    }
    //we can make more custom forms of the for loop like so. much more like c# these.

    for i := 0; i <= 100; i += 5 { 
        fmt.printfln("In the loop: %d",i)
    }
    fmt.println("Blast me off!")

    //for i := 0; i != 10; i += 3
    //be careful of loops like this - where the condition will never be fulfilled and so will go
    //forever.

    //for i := 1; i <= 1024; i *= 2
    //this would double the i untill it reached or exceeded 1024. just make sure the modifier 
    //does eventually hit the target value

    //of course you can't call the i outside of the loop - the i is local to the loop. 

    //but check this out
    i:int
    for i in 1..= 10 {
        fmt.printfln("In the loop: %d", i)
    }

    fmt.printfln("Out of the loop: %d", i)
    //these are two different variables - one outside the loop and one inside. The i outside
    //currently values at 0

    //we can make the variable part of the loop
    
    j : int 

    for j = 1; j <= 20; j+= 2 {
        //here the j is reused from its creation
        //note that even though the 21 is false in the loop check, the int will still take
        //that variable.
        fmt.printfln("EN DA LUP: %d", j)
    }
    fmt.printfln("Oot lup: %d", j)

    //some for loops never end. these can be useful sometimes (like when you are waiting for
    //something to occur, or when you don't know when )
    //this type of loop can also be forcefully stopped with ctrl+z (on windows)

    // for {
    //     fmt.println("This will never end.")
    // }

    //we can use breaks to escape these loops though

    l: int = 1
    k: int = 2

    for {
        if (l * k) % 3 == 0 && (l * k) % 5 == 0 {
            break 
        }

        l += 1
        k += 2

        
    }

    fmt.printfln("Broke out of loop! l= %d and k= %d", l, k)

    // ./LoopOdin to run by the way. You forgot before. 

    //continue also exists in Odin 

    for i in 1..=10 {
        if i % 2 == 0 { continue }
    
        fmt.printfln("Printing no evens: %d", i)
    }

    //loops in loops 
    fmt.println()
    fmt.print("    |")
    for h in 1..=12 {
        fmt.printf("% 4d|", h)
    }
    fmt.println()

    for d in 1..=13 {
        fmt.print("----+")
    }
    fmt.println()

    for r in 1..=12 {
        fmt.printf("% 4d|", r)
    
        for c in 1..=12 {
            fmt.printf("% 4d|", r * c)
        }
        fmt.println()
    }

    //above we create a times table using loops in loops. 
    fmt.println()

    ii, jj: int

    outer: for ii = 1; ii < 1000; ii += 1 {
        for jj = 2; jj < 1000; jj += 1 { 
            if(ii * jj) % 3 == 0 && (ii * jj) % 5 == 0 {
                break outer
            }
        }
    }
    fmt.printfln("Broke out of loop with ii = %d and jj = %d", ii, jj)

    // previously this broke the inner loop, meaning the outer goes untill completion. but 
    // we can break a certain loop with break labels. thats what 'break outer' is doing - targeting
    // the 'outer' label on the outer loop 

    //we can iterate over arrays too, predictably. here are arrays, by the way!  
    nums := []int{4,8,10,11,-1,7,9}

    for i := 0; i < len(nums); i+=1 {
        fmt.printfln("ARRAY NUM: %d",nums[i])
    } 

    for n in nums {
        fmt.printfln("FOR IN LOOP ARRAY NUM: %d", n)
    }

    for n, i in nums {
        fmt.printfln("%d. %d", i+1, n)
    }

    //you can also do it in reverse and it is so easy jesus christ. just
    // add #reverse to the for loop

    #reverse for n in nums {
        fmt.printfln("Array reversed! %d", n)
    }

    //  If you use #reverse with a loop that also includes an index (for n, i in nums), 
    //  be aware of the fact that the index is also reversed. This may or may not be what 
    //  you want.

    // String looping

    for r in "Welcome to Odin" {
        if r == 'e' {
            fmt.printf("%c ", '*')
            continue
        }
        fmt.printf("%c ", r)
    }

    //%c for characters in interpolation
}