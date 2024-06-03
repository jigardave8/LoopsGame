//
//  ContentView.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI

enum PipeType {
    case straight
    case curve
}

struct Pipe: View {
    var type: PipeType
    @Binding var rotation: Angle
    
    var body: some View {
        ZStack {
            switch type {
            case .straight:
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 50, height: 10)
                    
            case .curve:
                Path { path in
                    path.move(to: CGPoint(x: 50, y: 0))
                    path.addLine(to: CGPoint(x: 50, y: 50))
                    path.addLine(to: CGPoint(x: 0, y: 50))
                }
                .stroke(Color.blue, lineWidth: 10)
            }
        }
        .rotationEffect(rotation)
        .onTapGesture {
            rotation += .degrees(90)
        }
    }
}

struct ContentView: View {
    @State private var rotations: [[Angle]] = Array(repeating: Array(repeating: .degrees(0), count: 6), count: 6)
    let grid: [[PipeType]] = [
        [.curve, .straight, .curve, .straight, .curve, .straight],
        [.straight, .curve, .straight, .curve, .straight, .curve],
        [.curve, .straight, .curve, .straight, .curve, .straight],
        [.straight, .curve, .straight, .curve, .straight, .curve],
        [.curve, .straight, .curve, .straight, .curve, .straight],
        [.straight, .curve, .straight, .curve, .straight, .curve]
    ]
    
    let solutionRotations: [[Angle]] = [
        [.degrees(90), .degrees(0), .degrees(180), .degrees(0), .degrees(90), .degrees(0)],
        [.degrees(0), .degrees(90), .degrees(0), .degrees(90), .degrees(0), .degrees(90)],
        [.degrees(180), .degrees(0), .degrees(90), .degrees(0), .degrees(90), .degrees(0)],
        [.degrees(0), .degrees(90), .degrees(0), .degrees(90), .degrees(0), .degrees(90)],
        [.degrees(180), .degrees(0), .degrees(90), .degrees(0), .degrees(90), .degrees(0)],
        [.degrees(0), .degrees(90), .degrees(0), .degrees(90), .degrees(0), .degrees(90)]
    ]
    
    var body: some View {
        VStack {
            Text("Loop Connecting Game")
                .font(.title)
                .padding()

            VStack(spacing: -50) { // Adjust spacing for seamless connection
                ForEach(0..<grid.count, id: \.self) { row in
                    HStack(spacing: -50) { // Adjust spacing for seamless connection
                        ForEach(0..<grid[row].count, id: \.self) { col in
                            Pipe(type: grid[row][col], rotation: $rotations[row][col])
                                .frame(width: 100, height: 100)
                                .padding(0)
                        }
                    }
                }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding()

            Button(action: {
                solvePipes()
            }) {
                Text("Show Solution")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }

    func solvePipes() {
        for row in 0..<rotations.count {
            for col in 0..<rotations[row].count {
                rotations[row][col] = solutionRotations[row][col]
            }
        }
    }
}

