package OdinCatGame 

import "core:fmt"
import "core:strconv"
import "core:strings"
import "core:os"

endGame : bool = false
loopTerminator : int = 50

Stage :: enum{
    OPENING,
    MIDDLE,
    ENDING
}

//Where we organize our scenes for the performance. 
MomentEnums :: enum{

}

//A struct of harder results from certain choices - acquiring cat nip, for example.
//consequenceTweakMap 
Consequence :: struct {

    consequenceTweakMap: map[int]bool
}

//These are moments in the story, where the player will be asked to input choices. The script may change depending on the stage. 
// nameOfMoment:        the name of this moment in Enum form. 
// stage :              progression of time/story
// stageScriptMAP:      how we determine the script displayed
// accessibleMoments:   used to determine the valid inputs a player can make
Moment :: struct {
    nameOfMoment: int, 
    stage: i8,
    stageScriptMAP : []string,
    accessActiveCheck: []int,  
    accessibleMoments: [dynamic]int,
    availableChoices: bool,
    choiceOptions: [dynamic]int,
    consequence: Consequence
}



//bool Library (most default)
//bool: true/false ----- explanation

main :: proc() {
    setup()
    loopTerminator := 10
    //for !endGame {

    fmt.println("Cat is mad. What do?")
    prepareInput()
    loopBreak("main for !endgame")
    //}
}

setup :: proc() { 
    //temporary test setup

}

// we want to have pauses in the story - rather than an instant dump of script. 
//BONUS: lets fold some basic memory management in since that's half the point of lower level languages. 
// Do we want debugging? Why not? Let's set up some debugging capability. 
// OOH, and error handling! 

begin :: proc() {
    //the kickoff of the whole shebang. perhaps some aspects would be in main, but I'd rather isolate the beginning of the
    //process from main. 
}

prepareInput :: proc() {
    
    wordArray := strings.split(strInput("What will you do?")," ")
    scanString(wordArray)
}

process :: proc() {
    //where we wind through the results of player actions, the ongoing progression of the story etc, through connecting with 
    //other methods. 
}

nextMove :: proc() {
    //here we want to absorb the current state of play and use that to adjust the context of what the player is doing with their move. 
    //this is a looping method which is just there to absorb what the player writes, process it, and pass it on to scanString. 
}

scanString :: proc(scanStringPara: []string) {
    targetWordsArray := [3]string{"feed", "flee", "run away"}
    foundWord := false
    for word in scanStringPara {
        fmt.printfln("WORD ------ %s", word)
        if word == targetWordsArray[0]{
            fmt.println("Good feeding.")
            foundWord = true
            break
        } else if word == targetWordsArray[1] || word == targetWordsArray[2] {
            fmt.println("Oh now you fucked up.")
            foundWord = true
            break
        }   
    }   
        if !foundWord {
            fmt.println("You didn't feed or flee? Bad move, BUDDY!")
        }
}

scanPossibles :: proc() {

    //here we want to scan what is effectively a multilayered map which contains not just keywords for the story but also the different 
    // states of that keyword. this is our most complicated piece of the program - it effectively layers story arcs underneath the keywords. 
    // as the state of the game progresses, so do these story beats. 

    /* example map {keyword: {1:firstStoryLayer, 2:secondStoryLayer, 3:thirdStoryLayer}, keyword2 : {1: onlyStoryLayer}} */

    //we'd like some sort of file set up here where we can modify the story beats etc from outside the program itsef. so that when we build
    // we don't have to give access to the inner files. 
}

readAndLoad :: proc() {
    //Ideally we want to be able to read from a file in order to make this application more flexible in how we use it. To do 
    //that, we want to read from file

    //how do we want this setup to look? 

        /* EACH WORD SCAN SECTION CONSISTS OF 
        
            AN ARRAY/LIST OF STRINGS (cupboard/other words for cupboard)
            AN ADDITIONAL CODEWORD/ENUM WHICH REPRESENTS ALL OF THESE STRINGS
            AN INTEGER TO REPRESENT THE STAGE

         */

         /* EACH PLOT SECTION CONSISTS OF

            THE CODEWORD
            A MAP OF STRINGS
         
          */
}

end :: proc() {
    //A separate aspect of the thing where on certain conditions being activated the end game occurs, triggering an ending or the beginning of
    // an ending.
}

delayForEffect :: proc() {

}

strInput :: proc(chosenInput : string) -> string {
    fmt.print(chosenInput)
    buf : [100]byte
    n,err := os.read(os.stdin,buf[:])

    //Need to find an acceptable error set up for this. 
    if err != nil{
        fmt.println("Error: ", err)
        os.exit(-1)
    }
    return strings.clone(strings.trim_space(string(buf[:n-1])))
    //fmt.println("Caught ==", strName)
}

loopBreak :: proc(originPara: string) {
    loopTerminator -= 1
    if loopTerminator <= 0 { 
        fmt.eprintfln("Error - issue with loop: %s", originPara)
        os.exit(-1)
    }
}

//We're going to make a string absorption game. You have to feed a cat. 
//The game will attempt to detect words - when it does it will direct your attention to a part of the room. 
//Failure to find anything in too many turns will advance the doom clock - and make it more likely
// that the cat gets you. 