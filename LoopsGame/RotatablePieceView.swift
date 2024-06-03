//
//  RotatablePieceView.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

//import SwiftUI
//
//struct RotatablePieceView: View {
//    @Binding var piece: Piece
//
//    var body: some View {
//        piece.path
//            .stroke(Color(#colorLiteral(red: 0.9960784314, green: 0.7882352941, blue: 0.007843137255, alpha: 1)), lineWidth: 8) // Neon color stroke with increased thickness
//            .frame(width: 80, height: 80)
//            .rotationEffect(.degrees(piece.rotation))
//            .onTapGesture {
//                withAnimation {
//                    self.piece.rotation += 90
//                    self.piece.rotation = self.piece.rotation.truncatingRemainder(dividingBy: 360)
//                }
//            }
//    }
//}
//
