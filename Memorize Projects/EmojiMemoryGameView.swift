//
//  EmojiMemoryGameView.swift
//  Memorize Project 1
//
//  Created by İhsan TOPALOĞLU on 7/16/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
            Text(game.themeName)
                .font(.title)
            Text("Score: \(game.score)")
                .font(.subheadline)
            Spacer()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .padding(.horizontal)
            .foregroundColor(game.themeColor)
            Spacer()
            Button(action: {
                game.startNewGame()
            }, label: {
                Text("New Game").font(.title)
            })
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(bestFontSize(for: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func bestFontSize(for size: CGSize) -> Font {
        let lesserOfHeightAndWidth = min(size.height, size.width)
        return Font.system(size: lesserOfHeightAndWidth * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
