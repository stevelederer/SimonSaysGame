//
//  GamePlay.swift
//  SimonSaysGame
//
//  Created by Steve Lederer on 1/7/19.
//  Copyright © 2019 Steve Lederer. All rights reserved.
//

import Foundation

class GamePlay {
    // userMoves array
    private var userMoves: [Int] = []
    // correctMoves array
    private(set) var correctMoves: [Int]  = []
    
    enum Move {
        case correctAndContinue
        case correctAndNewRound
        case incorrect
    }
    // function userSelected value -> Move
    func userSelected(_ value: Int) -> Move {
        userMoves.append(value)
        
        if correctMoves.count == userMoves.count {
            if correctMoves == userMoves {
                print("Correct! User got all moves right. Time to move to next round.")
                createNextRound()
                return Move.correctAndNewRound
            } else {
                print("Incorrect")
                return Move.incorrect
            }
        } else {
            // user is in mid-game
            for number in 0..<userMoves.count {
                if correctMoves[number] != userMoves[number] {
                    print("Incorrect")
                    return Move.incorrect
                }
            }
            print("All of the moves so far are correct")
            return Move.correctAndContinue
        }
    }
    
    
    // function createNextRound
    func createNextRound() {
        correctMoves.append(pickRandomNumberBetween0And3())
        userMoves = []
        print("Here's the right moves \(correctMoves)")
    }
    
    // function startNewGame
    func startNewGame() {
        correctMoves = [pickRandomNumberBetween0And3(), pickRandomNumberBetween0And3(), pickRandomNumberBetween0And3()]
        userMoves = []
        print("Here's the right moves \(correctMoves)")
    }
    
    // function pick a random number 0-3
    private func pickRandomNumberBetween0And3() -> Int {
        return Int(arc4random_uniform(4))
    }
}
