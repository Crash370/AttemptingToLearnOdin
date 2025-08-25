package OdinCatGame 

import "core:fmt"
import "core:strconv"
import "core:strings"
import "core:os"
import "core:math/rand"
import "core:unicode/utf8"
import "core:time"

import "core:testing"

//READ THE BOOK - APPLY WHAT YOU LEARN HERE OR IN THE PLAYGROUND. 

/* HOW THIS ALL WORKS (AS THINGS STAND - 24/08/2025)

    MAIN - Begins set up 
    SET UP - Sets up the used variables from JSON, including moments, consquences, end game and other bits.
    MAIN - Begins the beginning
        BEGIN - Sets up the first moment and begins the loop. 
        PREPARE INPUT - Takes player input. 
        SCAN STRING - Catches words which are used to determine which moment the player will move to next.
        PROCESS - Process the results of the caught player input. Loop back to prepare input. 

    Where we should be going: 
        Need tests for end game - to define how new consequences are opened. We have the beginnings of this with
        the available momentsActive list, but want to further concrete this system. 

        We also want to look into sorting this JSON set up out so we can begin to define that structure and build 
        it out. 



 */


    /* OBJECTIVES
    
    NEXT: 
        -Sort out the process - what happens when the player has made their input and we know where we are going? 
        
        -Check out whether we need all the methods we do. 
        
        -Look into JSON processing in ODIN. Or config processing in Odin..?

        -LETS PRIORITIZE THE START FIRST, and for that we need to be able to access X text file. 

        -Let's convert to the styling used by the core collection at some point. (https://github.com/odin-lang/Odin/wiki/Naming-Convention)
        
         */

endGame : bool = false
loopTerminator : int = 50 
nextMoment : Moment
currentMoment : Moment
noWordArray : []string
delayActive : bool

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
    keyWordArray: []string,
    targetMomentsKeywordsArray: [dynamic]string,
    stage: int, //Should be set to 1 as default
    stageScriptArray : []string,
    accessActiveCheck: []int,  
    accessibleMoments: [dynamic]int,
    inaccessibleMoments: [dynamic]int,
    availableChoices: bool,
    choiceOptions: [dynamic]int,
    consequence: int,
    endGameAvailable : bool,
    advancePreviousMoment: bool

}

//Beginning moment - how this story kicks off
firstMoment : Moment

//This determines if a moment is active for another moment 
momentsActive : map[int]bool

//This is a map of moments found by their enums
mapOfMoments : map[int]Moment

//This is a map of keywords to enums (connected to moments as above)
mapOfKeywordsAndCodewords : map[string]int

//This is a list of strings for the next move ('what are you doing now?') step of the game. 
whatNowStrings : [dynamic]string

//bool Library (most default)
//bool: true/false ----- explanation

//If using playground, this will be set to true and we'll redirect to OdinCatGamePlayground
usingPlayground : bool = true

//MAIN===============================================================================================================
main :: proc() {
    if !usingPlayground{
        setup()
        begin()
        deallocateMemory()
    } else {
        fmt.println("Redirect to playground.")
        mainPlayground() //Redirecting to playground script?
    }
}

//SETUP===============================================================================================================
setup :: proc() { 
    //temporary test setup

}

// we want to have pauses in the story - rather than an instant dump of script. 
//BONUS: lets fold some basic memory management in since that's half the point of lower level languages. 
// Do we want debugging? Why not? Let's set up some debugging capability. 
// OOH, and error handling! 
// Do we want to be able to pass over multiple paragraphs of a story stage? Potentially requires rewriting of moments. 


//Where the story begins. Pulls from the opening moment of the story and prints it, then passes onto prepare input.
//BEGIN===============================================================================================================
begin :: proc() {
    //set up first moment. 
    currentMoment = firstMoment
    fmt.println(firstMoment.stageScriptArray[0])
    prepareInput()
}

//where we wind through the results of player actions, the ongoing progression of the story etc, through connecting with 
    //other methods. 
//1) Check consequences of the action
//2) Check if previous moment should be advanced. If so, do the advance check (check if the stage has adv)

//3) Print results of the action from the currentMoment
//4) We move to next move and complete transition to the next moment. 
//PROCESS===============================================================================================================
process :: proc(currentMomentKeyPara : int) {

    targetCurrentMoment := mapOfMoments[currentMomentKeyPara]
// 1)
    consequenceChecker(nextMoment.consequence, nextMoment.stage)
// 2)
    if nextMoment.advancePreviousMoment { 

        if targetCurrentMoment.stage < len(targetCurrentMoment.stageScriptArray) {
            targetCurrentMoment.stage = targetCurrentMoment.stage + 1
        }
    }
//
//    delayForEffect(delayActive)
// 3)
    fmt.println(nextMoment.keyWordArray[nextMoment.stage])
// 4) 
    currentMoment = nextMoment
// 4)
    prepareInput()
}

//This chooses a random string from the 'what now strings' (For example one might say 'What are you going to do now? The world is watching...')
//And sends it to the strInput to capture and clean the input. Then we break it up into a string array for use in scan now. 
//PREPARE INPUT===============================================================================================================
prepareInput :: proc() {
    
    wordArray := strings.split(strInput(rand.choice(whatNowStrings[:]))," ")
    scanString(wordArray)
}

//This method: 

// We will have an enum processor to check either if this moment has arrived at a certain stage or if this moment is reached at all. 

//1) We create the available word options list (targetMomentsKeywordsArray) based on the available options. 
//2) We also remove the unavailable words from targetMomentsKeywordsArray based on the available options.
//3) We scan the words in the list against the targetKeyWordsArray
//4) If found, we set that up as the next moment
//5) We pass to process to process the outcomes of the input. 
//0) Enforced delays in scanString (Just for effect right now, but perhaps using threading later.)
//SCAN STRING===============================================================================================================
scanString :: proc(scanStringPara: []string) {

// Can we use threading to Delay while certain things happen? 
//For now we will use the delay to break up scanstring. 

// 1)
    for num in currentMoment.accessActiveCheck {
        ind := checkForInt(currentMoment.accessibleMoments[:], num)
        if momentsActive[num] && ind == -1 {

            append(&currentMoment.accessibleMoments, num)
            unordered_remove(&currentMoment.inaccessibleMoments, ind)

        } else if !momentsActive[num] && ind != -1 {

            unordered_remove(&currentMoment.accessibleMoments, ind)
            append(&currentMoment.inaccessibleMoments, num)
        }
    }

// 0) 
    delayForEffect("Loading... 25%")
// 2) 
    for moment in currentMoment.accessibleMoments {
        for keyWord in mapOfMoments[moment].keyWordArray {

            ind := checkForString(currentMoment.targetMomentsKeywordsArray[:], keyWord)
            if ind != -1 {

                append(&currentMoment.targetMomentsKeywordsArray, keyWord)
            }
        }
    }
// 0) 
    delayForEffect("Loading... 50%")
// 3) 
    for moment in currentMoment.inaccessibleMoments {

        for keyWord in mapOfMoments[moment].keyWordArray {

            ind := checkForString(currentMoment.targetMomentsKeywordsArray[:], keyWord) 
            if ind != -1 {

                unordered_remove(&currentMoment.targetMomentsKeywordsArray, ind)
            }
        }
    }
// 0) 
    delayForEffect("Loading... 75%")
// 4)
    foundWord := false
    for word in scanStringPara {
        if checkForString(currentMoment.targetMomentsKeywordsArray[:], word) != -1{
            // 5)
            nextMoment = mapOfMoments[mapOfKeywordsAndCodewords[word]]
            foundWord = true
            break
        }   
        if !foundWord {
            fmt.println()
        }
    }
// 5)
        process(currentMoment.nameOfMoment) 
}

//CONSEQUENCE CHECKER===============================================================================================================
//Checks for conditions that might alter the game state in some way. 
consequenceChecker :: proc(consequenceCodePara : int, stagePara : int) {

}

//READ AND LOAD===============================================================================================================
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

//END===============================================================================================================
end :: proc() {
    //A separate aspect of the thing where on certain conditions being activated the end game occurs, triggering an ending or the beginning of
    // an ending.
}

//DELAY FOR EFFECT===============================================================================================================
//Intended to cause small delays so that the player waits for the outcome of their decisions. 
delayForEffect :: proc(loadingMessagePara: string) {
    
    if delayActive{

        for i in 1..=3 {
            fmt.printfln(loadingMessagePara)
            time.sleep(50 * time.Millisecond)
        }
    }
}

//STR INPUT===============================================================================================================
//The string input has been modified to take the string, set it all to lower case, trim extra spaces
//and clean out any unwanted punctuation which might mess up the string scan.
strInput :: proc(chosenInput : string) -> string {
    fmt.println(chosenInput)  
    buf : [100]byte
    n,err := os.read(os.stdin,buf[:])

    //Need to find an acceptable error set up for this. 
    if err != nil{
        fmt.println("Error: ", err)
        os.exit(-1)
    }
    modString := strings.clone(strings.to_lower(strings.trim_space(string(buf[:n-1]))))
    punctuation : = "abcdefghijklmnopqrstuvwxyz "
    cloneModString := strings.clone(modString)
    for character in cloneModString{
        if !(strings.contains_rune(punctuation, character)) {
            buf, n := utf8.encode_rune(character)
            charConv := string(buf[:n])
            modString, _ = strings.remove_all(modString, charConv)
        } 
    }
    
    fmt.printfln("result of clean ---%s---", modString)
    return strings.clone(modString)
    //fmt.println("Caught ==", strName)
}

//LOOP BREAK===============================================================================================================
//A loop testing method to check if infinite loops or loop errors are present.
loopBreak :: proc(originPara: string) {
    loopTerminator -= 1
    if loopTerminator <= 0 { 
        fmt.eprintfln("Error - issue with loop: %s", originPara)
        os.exit(-1)
    }
}

//CHECK FOR INT===============================================================================================================
//Checks for the index of the int we're looking for and returns that index if it exists. 
//If it can't be found, returns -1
checkForInt :: proc(intArrayPara: []int, targetIntPara: int) -> int {
    for num, ind in intArrayPara{
        if num == targetIntPara {
            return ind
        }
    }
    return -1
}

//CHECK FOR STRING===============================================================================================================
//Checks for the index of the string we're looking for and returns that index if it exists. 
//If it can't be found, returns -1
checkForString :: proc(stringArrayPara: []string, targetStringPara: string) -> int {
    for str, ind in stringArrayPara{
        if str == targetStringPara {
            return ind
        }
    }
    return -1
}


//DEALLOCATE MEMORY===============================================================================================================
//Cleans up the dynamic arrays when the program is done. 
deallocateMemory :: proc() {

    for mom in mapOfMoments{
        delete(mapOfMoments[mom].targetMomentsKeywordsArray)
        delete(mapOfMoments[mom].accessibleMoments)
        delete(mapOfMoments[mom].inaccessibleMoments)
        delete(mapOfMoments[mom].choiceOptions)
    }

    delete(whatNowStrings)
}

//We're going to make a string absorption game. You have to feed a cat. 
//The game will attempt to detect words - when it does it will direct your attention to a part of the room. 
//Failure to find anything in too many turns will advance the doom clock - and make it more likely
// that the cat gets you. 

