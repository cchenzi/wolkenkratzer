module Main (main) where

import Wolkenkratzer
import Matrices
import Data.Time

main = do
    print("=================")
    print("= Wolkenkratzer =")
    print("=================")

    start <- getCurrentTime
    print("==========Solve Matrix [3x3]======")
    case solverWk (myExample 9) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

    start <- getCurrentTime
    
    print("==========Solve Matrix [4x4]======")
    print("==========#26  from janko.at=======")
    case solverWk (myExample 10) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

    start <- getCurrentTime
    print("==========Solve Matrix [4x4]======")
    print("==========#73  from janko.at=======")
    case solverWk (myExample 11) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

    start <- getCurrentTime
    print("==========Solve Matrix [5x5]======")
    print("==========#01  from janko.at=======")
    case solverWk (myExample 12) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

    start <- getCurrentTime
    print("==========Solve Matrix [5x5]======")
    print("==========#31  from janko.at=======")
    case solverWk (myExample 13) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

    start <- getCurrentTime
    print("==========Solve Matrix [5x5]======")
    print("==========#32  from janko.at=======")
    case solverWk (myExample 14) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

    start <- getCurrentTime
    print("==========Solve Matrix [6x6]======")
    print("==========#03  from janko.at=======")
    case solverWk (myExample 15) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

    start <- getCurrentTime
    print("==========Solve Matrix [6x6]======")
    print("==========#41  from janko.at=======")
    case solverWk (myExample 16) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

    start <- getCurrentTime
    print("==========Solve Matrix [6x6]=======")
    print("==========#42  from janko.at=======")
    case solverWk (myExample 66) of
        Nothing    -> putStrLn "Sorry, I did not find a solution."
        Just matrix' -> putStrLn $ showMatrix matrix'
    end <- getCurrentTime
    print (diffUTCTime end start)

