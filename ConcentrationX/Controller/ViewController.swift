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
            game.chooseCard(at: cardNumber){ (res) in [self]
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
//    get{
        return (cardbuttons.count+1)/2 ;
//        }
    }
  
    private(set) var flipCount = 0 { //property observer
        didSet{
//            print(flipCount)
            updateFlipCountLabel()
        }
    }
    private  var _cardBackColor : UIColor? //= cardBackColor
    private  var _backGroundColor : UIColor? //= backGroundColor
    override func viewDidLoad() {
        _cardBackColor = cardBackColor
        for index in cardbuttons.indices{
            let button = cardbuttons[index]
            button.backgroundColor = _cardBackColor
        }
         print("--------------\(_cardBackColor)")
        self.view.backgroundColor = backGroundColor
    }
    @IBAction func startNewGame(_ sender: Any) {
       emojiChoises = randomEmojiTheme
        
        emojiiDictionary = [:]
        flipCount = 0
        _cardBackColor = cardBackColor
        self.view.backgroundColor = backGroundColor
        game.startNewGame()
        updateViewFromModel() //buttons dependes on cards array

    }
    private var randomEmojiTheme : String{
        var arrOfEmoji =  Array(self.emojiChoisesDictionary.keys)
        //        return emojiChoisesArr[emojiChoisesArr.count.arc4random]
        return arrOfEmoji[arrOfEmoji.count.arc4random]
    }
   
    private lazy var emojiChoises : String = randomEmojiTheme
    private var emojiiDictionary = [Card:String]() //key card & value string
    private var emojiChoisesDictionary = ["🐶🐱🐭🐹🦊🦇🐼🐮🐵🐸🐷🙉🐧🐣🐥🦆🦅🐺🦄🦋🐝🐞🐏🐓":["backGroundColor":#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),"cardBackColor":#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)],
                                "🍎🍏🍐🍉🍇🍅🥦🌽🥒🍆🍍🍓🍋🍌🍊🥑🌶🥕🥥🥝🍍🍈🍒🍑":["backGroundColor":#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1),"cardBackColor":#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)],
                               "⚽️🏀🏈⚾️🎱🏉🏐🎾🏓🏸🏑🏏🏹🥊🥋⛸⛷🏂🤼‍♂️⛹️‍♀️🏊‍♂️🚣‍♀️🏆🥇":["backGroundColor":#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),"cardBackColor":#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)],
                               "🚗🚕🚙🚌🚎🏎🚓🚑🚛🚚🚐🚒🚜🛴🚲🛵🚍🚔🚨🏍🚘🚖🚡🚠":["backGroundColor":#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),"cardBackColor":#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)],
                                "😀😃😄😁🤣😂😇🤪😎🤩😏😡🤬🤯😤😓😥🤭🤔😈🤡👺👹👿":["backGroundColor":#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),"cardBackColor":#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)],
                               "⌚️📱📲💻⌨️🖥🖨🕹🖲📷📹🎥☎️📞📽⏰🕰🗑🔦🛢💵💰💎⚖️":["backGroundColor":#colorLiteral(red: 0.5259947777, green: 0.5551545024, blue: 0.3649410605, alpha: 1),"cardBackColor":#colorLiteral(red: 0.7476168275, green: 0.7574796081, blue: 0, alpha: 1)]
                                ]
   
    private func putEmojiOnCard(for card : Card) -> String {
//        print(card)
        if emojiiDictionary[card] == nil , emojiChoises.count > 0{
            //            let randomIndexForEmojiChoises = emojiChoises.count.arc4random
            let randomStringIndex = emojiChoises.index(emojiChoises.startIndex, offsetBy: emojiChoises.count.arc4random)
            emojiiDictionary[card] = String(emojiChoises.remove(at: randomStringIndex)) //Removes and returns the element at the specified position.
        }else{
//            if flipCount > 0{
//            print(card)
//                 flipCount = flipCount - 1
//            }
           
        }
        return emojiiDictionary[card] ?? "??" //if emojiiDictionary[card.identifier] == nil return "??" else return emojiiDictionary[card.identifier]
    }
//    func getAppTheme(emoji:String)->(backGroundColor:UIColor,cardBackColor:UIColor){
//        print(emojiChoisesDictionary[emoji]!["cardBackColor"]!)
//        var _backGroundColor:UIColor
//         var _cardBackColor:UIColor
//        if let emoji = emojiChoisesDictionary[emoji]{
//            if let backGroundColor = emoji["backGroundColor"],let cardBackColor = emoji["cardBackColor"]{
//                _cardBackColor = cardBackColor
//                _backGroundColor = backGroundColor
//
//            }
//        }
//        return (backGroundColor:_backGroundColor,cardBackColor: _cardBackColor)
//        return (backGroundColor:emojiChoisesDictionary[emoji]["backGroundColor"],cardBackColor: emojiChoisesDictionary[emoji]["cardBackColor"])
//    }


    var cardBackColor : UIColor{
        return emojiChoisesDictionary[emojiChoises]!["cardBackColor"]!
    }
    var backGroundColor : UIColor{
        return emojiChoisesDictionary[emojiChoises]!["backGroundColor"]!
    }

   private func updateViewFromModel (){
        print("--------------\(_cardBackColor)")
        for index in cardbuttons.indices{ //0..<12
            let button = cardbuttons[index]
            let card = game.cards[index]
            
            if card.isFaceUp { //put emojji for faceup card
                button.setTitle(putEmojiOnCard(for:card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle(" ", for: .normal)
//                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9397521615, green: 1, blue: 0.9613415599, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)  //clear (remove) matched one
//                print(index)
//                print(_cardBackColor)
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
