//
//  MemorizeProjectsApp.swift
//  Memorize Projects
//
//  Created by İhsan TOPALOĞLU on 7/16/21.
//

import SwiftUI

@main
struct MemorizeProjectsApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
