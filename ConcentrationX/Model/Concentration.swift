//
//  Concentration.swift
//  ConcentrationX
//
//  Created by Sara Elsayed Salem on 8/13/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

struct Concentration {
    
   private(set) var cards =  [Card]() //to map every button in the view with its object
    
   private var indexOfOneAndOnlyFaceupCard : Int? {
        get{
            return cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly // 'hello'.oneAndOnly //nil more than one character //[cards].oneAndOnly
        }
        set{
            for index in cards.indices {
               cards[index].isFaceUp = (index == newValue) //rest is false down
            }
        }
    }
    
    mutating func chooseCard(at index : Int , update matched : @escaping (Bool) -> Void)  {
        
        assert(cards.indices.contains(index), "sorry this \(index) not inside cards ")
        //ignore matched card
        if(!cards[index].isMatched){
            //one card or two faceup //matchedIndex old card
            if let matchedIndex = indexOfOneAndOnlyFaceupCard , index != matchedIndex {    //get   //second card
                
                if(cards[matchedIndex] == cards[index]){ //old == new
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    matched(true);
                }else{
                    matched(false);
                }
                cards[index].isFaceUp = true //new
            }else{
                //no card or any one are faced up    //first card
                indexOfOneAndOnlyFaceupCard = index   //set
            }
        }
    }
    mutating func startNewGame(){
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    init(numberOfPairsOfCards:Int) {
        
        assert(numberOfPairsOfCards > 0, " this \(numberOfPairsOfCards) u must have at least one pairs of cards")
        for _ in 1...numberOfPairsOfCards { // = 0..<numberOfPairsOfCards
            let card = Card()
            //card is struct value type so it is copied here twice
            cards += [card,card] //= cards.append (card);cards.append (card) //+= append //every two card has same identifier //1,1,2,2,3,3,..
        }
        
        //TODO: shuffle the cards
        cards.shuffle()
        
    }
}

extension Collection { //dict , array ,..
    var oneAndOnly: Element? { //element the type of the thing in collection
        return count == 1 ? first : nil //return index // ex. 2
    }
}
