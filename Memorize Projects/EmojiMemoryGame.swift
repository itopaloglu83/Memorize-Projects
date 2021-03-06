//
//  EmojiMemoryGame.swift
//  Memorize Project 1
//
//  Created by ฤฐhsan TOPALOฤLU on 7/16/21.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Game = MemoryGame<String>
    typealias Card = MemoryGame<String>.Card
    typealias Theme = GameTheme<String>
    
    private static let initialThemes = [
        Theme("Animals", ["๐ถ", "๐ฑ", "๐ญ", "๐ฅ", "๐ป", "๐ผ", "๐ฆ", "๐ฎ", "๐ธ", "๐ต", "๐ณ", "๐"], "red", 4),
        Theme("Foods", ["๐", "๐", "๐", "๐", "๐ฝ", "๐ฅ", "๐ฅจ", "๐ฅ", "๐", "๐", "๐ฐ", "๐"], "green", 6),
        Theme("Vehicles", ["๐ฒ", "๐", "๐", "๐" , "๐", "๐", "๐", "๐", "๐", "โ๏ธ", "๐", "๐ธ"], "blue", 8)
    ]
    
    private static func createMemoryGame(with theme: Theme) -> Game {
        let shuffledCardContents = theme.cardContents.shuffled()
        
        return Game(numberOfPairsOfCards: theme.numberOfPairsOfCardsToShow, createCardContent: { pairIndex in
            shuffledCardContents[pairIndex]
        })
    }
    
    private var currentTheme: Theme
    
    private var gameThemes: Array<Theme>
    
    @Published private var memoryGame: Game
    
    init() {
        gameThemes = EmojiMemoryGame.initialThemes
        currentTheme = gameThemes.randomElement()!
        memoryGame = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
    var themeName: String {
        currentTheme.name
    }
    
    var themeColor: Color {
        switch currentTheme.color {
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        default:
            return .orange
        }
    }
    
    var cards: Array<Card> {
        memoryGame.cards
    }
    
    var score: Int {
        memoryGame.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        memoryGame.choose(card)
    }
    
    func startNewGame() {
        currentTheme = gameThemes.randomElement()!
        memoryGame = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
}
