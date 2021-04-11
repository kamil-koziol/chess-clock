//
//  Player.swift
//  Chess Clock
//
//  Created by Kamil Kozioł on 05/04/2021.
//

import Foundation

struct Player {
    var timeRemaining: Int = 300
    var increment: Int = 0
    var moves: Int = 0
    
    mutating func decreaseTime(amount: Int) {
        if(timeRemaining > 0) {
            self.timeRemaining -= amount;
        }
    }
    
    mutating func onTurnEnd() {
        if(moves > 0) {
            addIncrement();
        }
        moves += 1;
    }
    
    mutating func addIncrement() {
        self.timeRemaining += increment;
    }
}
