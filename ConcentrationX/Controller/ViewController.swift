//
//  ViewController.swift
//  ConcentrationX
//
//  Created by Sara Elsayed Salem on 8/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController { 
    
    @IBOutlet private weak var flipCountLabel: UILabel! { //when app start and create a connection to its outlet it get initialized
        didSet{ //oulet get set by ios
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardbuttons: [UIButton]! // to make all buttons has indexes
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardbuttons.index(of: sender){ //return optional binding
            // flipCard(withEmoji: emojiChoises[cardNumber], on: sender) //set cards emoji
            game.chooseCard(at: cardNumber){[unowned self] (res) in 
                if res { //matched
                    self.flipCount+=2
                }else{ //not matched and seen before
                    let emojiiDictionaryKeys = Array(self.emojiiDictionary.keys)
                    let card = self.game.cards[cardNumber]
                    if emojiiDictionaryKeys.contains(card) {
                        self.flipCount = self.flipCount - 1
                    }
                }
                
            }
            //to put imojj on the button
            updateViewFromModel()
            
        }else{
            print("this card number not exist in cardbuttons")
        }
        
    }
    
    //Cannot use instance member 'cardbuttons' within property initializer; property initializers run before 'self' is available   we use lazy
    //he will define concentration class before viewcontroller self //game object not defined untill using it
    //now controller talk to model
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    
    var numberOfPairsOfCards:Int{
        return (cardbuttons.count+1)/2 ;
    }
    
    private(set) var flipCount = 0 { //property observer
        didSet{
            updateFlipCountLabel()
        }
    }
    private  var _cardBackColor : UIColor? //= cardBackColor
    private  var _backGroundColor : UIColor? //= backGroundColor
    
    private var dataSource = EmojisDataSource()
    
    override func viewDidLoad() {
        _cardBackColor = dataSource.backGroundColor
        for index in cardbuttons.indices{
            let button = cardbuttons[index]
            button.backgroundColor = _cardBackColor
        }
        self.view.backgroundColor = dataSource.backGroundColor
    }
    
    
    @IBAction func startNewGame(_ sender: Any) {
        
        emojiiDictionary = [:]
        flipCount = 0
        _cardBackColor = dataSource.cardBackColor
        self.view.backgroundColor = dataSource.backGroundColor
        game.startNewGame()
        updateViewFromModel() //buttons dependes on cards array
        
    }
  
    private var emojiiDictionary = [Card:String]() //key card & value string
    
    
    private func putEmojiOnCard(for card : Card) -> String {
        //        print(card)
        guard emojiiDictionary[card] == nil,
            dataSource.emojiChoises.count > 0 else {
            return "??"
        }
        let randomStringIndex = dataSource.emojiChoises.index(dataSource.emojiChoises.startIndex, offsetBy: dataSource.emojiChoises.count.arc4random)
        emojiiDictionary[card] = String(dataSource.emojiChoises.remove(at: randomStringIndex)) //Removes and returns the element at the specified position.

        return emojiiDictionary[card] ?? "??"
    }
    
    
    
    private func updateViewFromModel (){
        for index in cardbuttons.indices{ //0..<12
            let button = cardbuttons[index]
            let card = game.cards[index]
            
            if card.isFaceUp { //put emojji for faceup card
                button.setTitle(putEmojiOnCard(for:card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle(" ", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9397521615, green: 1, blue: 0.9613415599, alpha: 0) : _cardBackColor  //clear (remove) matched one
                
            }
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor : UIColor.orange
        ]
        
        let attribText = NSAttributedString(string: "Score: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attribText
    }
    
    
    
}
extension Int{
    var arc4random : Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{ // = zero
            return 0
        }
    }
}
