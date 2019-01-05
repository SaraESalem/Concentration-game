//
//  Card.swift
//  ConcentrationX
//
//  Created by Sara Elsayed Salem on 8/13/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

struct Card : Hashable {
    //every button has its card object
    //make card hashable //Card : Hashable bz it will be key of dict which is Dictionary<<#Key: Hashable#>, Any>
    var hashValue: Int {return identifier}
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
  
    
    var isFaceUp = false
    var isMatched = false
    private var identifier:Int // index 1...
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier () -> Int {
        identifierFactory+=1
        return identifierFactory
    }
    
    init() { // bz we don't initialize it
        self.identifier = Card.getUniqueIdentifier() //index
    }
}
