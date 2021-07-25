//
//  GameTheme.swift
//  Memorize Projects
//
//  Created by İhsan TOPALOĞLU on 7/17/21.
//

import Foundation

struct GameTheme<CardContent: Equatable> {
    var name: String
    var cardContents: Array<CardContent>
    var color: String
    var numberOfPairsOfCardsToShow: Int
    
    init(_ name: String, _ cardContents: Array<CardContent>, _ color: String, _ numberOfPairsOfCardsToShow: Int) {
        let uniqueCardContents = cardContents.duplicatesRemoved()
        
        self.name = name
        self.cardContents = uniqueCardContents
        self.color = color
        self.numberOfPairsOfCardsToShow = min(numberOfPairsOfCardsToShow, uniqueCardContents.count)
    }
}

fileprivate extension Array where Element: Equatable {
    func duplicatesRemoved() -> Array<Element> {
        var uniqueElements: Array<Element> = []
        forEach { item in
            if !uniqueElements.contains(item) {
                uniqueElements.append(item)
            }
        }
        return uniqueElements
    }
}
