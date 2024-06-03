//
//  ContentView.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI

struct Level {
    var initialPieces: [Piece]
    var solutionPieces: [Piece]
}


import SwiftUI

struct ContentView: View {
    @State private var levels: [Level] = [
        Level(initialPieces: [
            Piece(rotation: 0, targetRotation: 0, path: Path { path in
                path.move(to: CGPoint(x: 0, y: 40))
                path.addLine(to: CGPoint(x: 80, y: 40))
            }),
            Piece(rotation: 90, targetRotation: 0, path: Path { path in
                path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
            }),
            Piece(rotation: 180, targetRotation: 90, path: Path { path in
                path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            }),
            Piece(rotation: 270, targetRotation: 180, path: Path { path in
                path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(180), endAngle: .degrees(360), clockwise: false)
            }),
            Piece(rotation: 0, targetRotation: 270, path: Path { path in
                path.move(to: CGPoint(x: 40, y: 0))
                path.addLine(to: CGPoint(x: 40, y: 80))
            }),
            Piece(rotation: 90, targetRotation: 90, path: Path { path in
                path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
            }),
            Piece(rotation: 180, targetRotation: 180, path: Path { path in
                path.move(to: CGPoint(x: 0, y: 40))
                path.addLine(to: CGPoint(x: 80, y: 40))
            }),
            Piece(rotation: 270, targetRotation: 270, path: Path { path in
                path.move(to: CGPoint(x: 40, y: 0))
                path.addLine(to: CGPoint(x: 40, y: 80))
            })
        ], solutionPieces: [
            Piece(rotation: 0, targetRotation: 0, path: Path { path in
                path.move(to: CGPoint(x: 0, y: 40))
                path.addLine(to: CGPoint(x: 80, y: 40))
            }),
            Piece(rotation: 0, targetRotation: 0, path: Path { path in
                path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
            }),
            Piece(rotation: 90, targetRotation: 90, path: Path { path in
                path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            }),
            Piece(rotation: 180, targetRotation: 180, path: Path { path in
                path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(180), endAngle: .degrees(360), clockwise: false)
            }),
            Piece(rotation: 270, targetRotation: 270, path: Path { path in
                path.move(to: CGPoint(x: 40, y: 0))
                path.addLine(to: CGPoint(x: 40, y: 80))
            }),
            Piece(rotation: 90, targetRotation: 90, path: Path { path in
                path.addArc(center: CGPoint(x: 40, y: 40), radius: 30, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
            }),
            Piece(rotation: 180, targetRotation: 180, path: Path { path in
                path.move(to: CGPoint(x: 0, y: 40))
                path.addLine(to: CGPoint(x: 80, y: 40))
            }),
            Piece(rotation: 270, targetRotation: 270, path: Path { path in
                path.move(to: CGPoint(x: 40, y: 0))
                path.addLine(to: CGPoint(x: 40, y: 80))
            })
        ])
        // Add more levels as needed
    ]
    
    @State private var currentLevelIndex: Int = 0
    @State private var currentPieces: [Piece] = []
    @State private var isCompleted = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40)
                    .padding()
                
                VStack(spacing: 0) { // Zero spacing here
                    ForEach(0..<2) { row in
                        HStack(spacing: 0) { // Zero spacing here
                            ForEach(0..<4) { col in
                                if row * 4 + col < self.currentPieces.count {
                                    RotatablePieceView(piece: self.$currentPieces[row * 4 + col])
                                }
                            }
                        }
                    }
                }
                .padding(20)
                .opacity(self.isCompleted ? 0.5 : 1.0)
            }
            
            HStack {
                Button("Reset Pieces") {
                    self.resetPieces()
                }
                .padding()
                Button("Check Solution") {
                    self.checkSolution()
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            self.loadLevel(index: self.currentLevelIndex)
        }
    }
    
    func loadLevel(index: Int) {
        guard index < levels.count else { return }
        let level = levels[index]
        currentPieces = level.initialPieces
        isCompleted = false
    }
    
    func resetPieces() {
        loadLevel(index: currentLevelIndex)
    }
    
    func checkSolution() {
        let solution = levels[currentLevelIndex].solutionPieces
        var isSolutionCorrect = true
        
        for (index, piece) in currentPieces.enumerated() {
            if piece.rotation.truncatingRemainder(dividingBy: 360) != solution[index].targetRotation {
                isSolutionCorrect = false
                break
            }
        }
        
        if isSolutionCorrect {
            withAnimation {
                for index in currentPieces.indices {
                    currentPieces[index].rotation = solution[index].targetRotation
                }
                self.isCompleted = true
                print("Solution is correct!")
            }
        } else {
            print("Solution is incorrect!")
        }
    }
}
