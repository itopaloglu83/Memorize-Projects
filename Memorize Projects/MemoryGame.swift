//
//  MemoryGame.swift
//  Memorize Project 1
//
//  Created by İhsan TOPALOĞLU on 7/16/21.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    private var previouslySeenIndices: Array<Array<Card>.Index> = []
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnlyElement }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    [chosenIndex, potentialMatchIndex].forEach({ index in
                        if previouslySeenIndices.contains(where: {$0 == index}) {
                            score -= 1
                        } else {
                            previouslySeenIndices.append(index)
                        }
                    })
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

fileprivate extension Array {
    var oneAndOnlyElement: Element? { count == 1 ? first : nil }
}
