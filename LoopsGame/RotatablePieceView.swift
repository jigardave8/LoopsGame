//
//  RotatablePieceView.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI

struct RotatablePieceView: View {
    @Binding var piece: Piece

    var body: some View {
        piece.path
            .stroke(ThemeManager.currentTheme.pieceColor, lineWidth: 5)
            .frame(width: 80, height: 80)
            .rotationEffect(.degrees(piece.rotation))
            .onTapGesture {
                withAnimation {
                    self.piece.rotation += 90
                    self.piece.rotation = self.piece.rotation.truncatingRemainder(dividingBy: 360)
                }
            }
    }
}
