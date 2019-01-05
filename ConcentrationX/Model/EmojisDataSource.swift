//
//  EmojisDataSource.swift
//  ConcentrationX
//
//  Created by abdelrahman mohamed on 1/5/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

struct EmojisDataSource {
    var emojiChoises : String
    
    var cardBackColor : UIColor{
        return EmojisDataSource.emojiChoisesDictionary[emojiChoises]!["cardBackColor"]!
    }
    var backGroundColor : UIColor{
        return EmojisDataSource.emojiChoisesDictionary[emojiChoises]!["backGroundColor"]!
    }
    
    static var randomEmojiTheme : String{
        var arrOfEmoji =  Array(self.emojiChoisesDictionary.keys)
        //        return emojiChoisesArr[emojiChoisesArr.count.arc4random]
        return arrOfEmoji[arrOfEmoji.count.arc4random]
    }
    
    init() {
        emojiChoises = EmojisDataSource.randomEmojiTheme
    }
    
    mutating func startGame() {
        emojiChoises = EmojisDataSource.randomEmojiTheme
    }

    static var emojiChoisesDictionary: [String : [String : UIColor]]{
        return ["🐶🐱🐭🐹🦊🦇🐼🐮🐵🐸🐷🙉🐧🐣🐥🦆🦅🐺🦄🦋🐝🐞🐏🐓":["backGroundColor":#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),"cardBackColor":#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)],
                "🍎🍏🍐🍉🍇🍅🥦🌽🥒🍆🍍🍓🍋🍌🍊🥑🌶🥕🥥🥝🍍🍈🍒🍑":["backGroundColor":#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1),"cardBackColor":#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)],
                "⚽️🏀🏈⚾️🎱🏉🏐🎾🏓🏸🏑🏏🏹🥊🥋⛸⛷🏂🤼‍♂️⛹️‍♀️🏊‍♂️🚣‍♀️🏆🥇":["backGroundColor":#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),"cardBackColor":#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)],
                "🚗🚕🚙🚌🚎🏎🚓🚑🚛🚚🚐🚒🚜🛴🚲🛵🚍🚔🚨🏍🚘🚖🚡🚠":["backGroundColor":#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),"cardBackColor":#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)],
                "😀😃😄😁🤣😂😇🤪😎🤩😏😡🤬🤯😤😓😥🤭🤔😈🤡👺👹👿":["backGroundColor":#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),"cardBackColor":#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)],
                "⌚️📱📲💻⌨️🖥🖨🕹🖲📷📹🎥☎️📞📽⏰🕰🗑🔦🛢💵💰💎⚖️":["backGroundColor":#colorLiteral(red: 0.5259947777, green: 0.5551545024, blue: 0.3649410605, alpha: 1),"cardBackColor":#colorLiteral(red: 0.7476168275, green: 0.7574796081, blue: 0, alpha: 1)]
        ]
    }
    
}
