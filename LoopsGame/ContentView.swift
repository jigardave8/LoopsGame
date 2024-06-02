//
//  ContentView.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI

struct Piece: Identifiable {
    let id = UUID()
    var rotation: Double
    var targetRotation: Double // Added targetRotation to store the solution rotation
    var path: Path
}

struct RotatablePieceView: View {
    @Binding var piece: Piece

    var body: some View {
        piece.path
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 80, height: 80) // Adjusted size of pieces
            .rotationEffect(.degrees(piece.rotation))
            .onTapGesture {
                withAnimation {
                    self.piece.rotation += 90
                }
            }
    }
}

struct ContentView: View {
    @State private var pieces: [Piece] = [
        // Half circle
        Piece(rotation: 0, targetRotation: 180, path: Path { path in
            path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
        }),
        // Half circle (different angle)
        Piece(rotation: 0, targetRotation: 180, path: Path { path in
            path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: false)
        }),
        // Half loop
        Piece(rotation: 0, targetRotation: 180, path: Path { path in
            path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
        }),
        // Half loop (different angle)
        Piece(rotation: 0, targetRotation: 180, path: Path { path in
            path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
        }),
        // Quarter circle
        Piece(rotation: 0, targetRotation: 90, path: Path { path in
            path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        }),
        // Quarter circle (different angle)
        Piece(rotation: 0, targetRotation: 90, path: Path { path in
            path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        }),
        // Line
        Piece(rotation: 0, targetRotation: 180, path: Path { path in
            path.move(to: CGPoint(x: 10, y: 40))
            path.addLine(to: CGPoint(x: 70, y: 40))
        }),
        // Line (different angle)
        Piece(rotation: 0, targetRotation: 180, path: Path { path in
            path.move(to: CGPoint(x: 40, y: 10))
            path.addLine(to: CGPoint(x: 40, y: 70))
        })
    ]
    
    @State private var isCompleted = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 500, height: 500) // Adjusted game area size
                    .padding()
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        ForEach(0..<4) { index in
                            RotatablePieceView(piece: self.$pieces[index])
                        }
                    }
                    HStack(spacing: 10) {
                        ForEach(4..<8) { index in
                            RotatablePieceView(piece: self.$pieces[index])
                        }
                    }
                }
                .padding(20) // Added padding to align pieces within the game area
                .opacity(self.isCompleted ? 0.5 : 1.0) // Reduce opacity if completed
            }
            
            HStack {
                Button("Reset Pieces") {
                    self.resetPieces()
                }
                .padding()
                Button("Check Solution") {
                    self.animateToSolution() // Animate pieces to solution angles
                }
                .padding()
            }
        }
    }
    
    func animateToSolution() {
        for index in pieces.indices {
            withAnimation(Animation.easeInOut(duration: 1.0).delay(Double(index) * 0.2)) {
                self.pieces[index].rotation = self.pieces[index].targetRotation
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkSolution() // Check solution after animation completes
        }
    }

    func checkSolution() {
        for piece in pieces {
            if piece.rotation != piece.targetRotation {
                self.isCompleted = false
                print("Solution is incorrect!")
                return
            }
        }
        self.isCompleted = true
        print("Solution is correct!")
    }

    func resetPieces() {
        for index in pieces.indices {
            var randomRotation = Double.random(in: 0...360)
            // Ensure the random rotation is not equal to the target rotation
            while randomRotation == pieces[index].targetRotation {
                randomRotation = Double.random(in: 0...360)
            }
            pieces[index].rotation = randomRotation
        }
        self.isCompleted = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
