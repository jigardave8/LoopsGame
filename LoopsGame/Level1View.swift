//
//  Level1View.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI
import AVFoundation

enum PipeType {
    case straight
    case curve
}

struct Pipe: View {
    var type: PipeType
    @Binding var rotation: Angle
    var isCorrect: Bool
    
    var body: some View {
        ZStack {
            switch type {
            case .straight:
                Rectangle()
                    .fill(isCorrect ? Color.green : Color.blue)
                    .frame(width: 50, height: 10)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    
            case .curve:
                Path { path in
                    path.move(to: CGPoint(x: 50, y: 0))
                    path.addLine(to: CGPoint(x: 50, y: 50))
                    path.addLine(to: CGPoint(x: 0, y: 50))
                }
                .stroke(isCorrect ? Color.green : Color.blue, lineWidth: 10)
                .shadow(radius: 5)
            }
        }
        .rotationEffect(rotation)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                rotation += .degrees(90)
            }
//            playSound(named: "rotate")
        }
    }
}

struct Level1View: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var rotations: [[Angle]] = Array(repeating: Array(repeating: .degrees(0), count: 6), count: 6)
    @State private var timeRemaining = 60
    @State private var score = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Text("Time: \(timeRemaining)")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Text("Score: \(score)")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding()

                Text("Loop Connecting Game")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)

                VStack(spacing: -50) {
                    ForEach(0..<grid.count, id: \.self) { row in
                        HStack(spacing: -50) {
                            ForEach(0..<grid[row].count, id: \.self) { col in
                                Pipe(type: grid[row][col], rotation: $rotations[row][col], isCorrect: rotations[row][col] == solutionRotations[row][col])
                                    .frame(width: 100, height: 100)
                                    .padding(0)
                            }
                        }
                    }
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()

                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            solvePipes()
                        }
                    }) {
                        Text("Show Solution")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .padding()

                    Button(action: {
                        showHint()
                    }) {
                        Text("Show Hint")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .padding()
                }
                
                Spacer()

                // Exit Button
                Button(action: {
                    viewRouter.currentView = .mainMenu
                }) {
                    Text("Exit to Main Menu")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .padding()
            }
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }

    func solvePipes() {
        for row in 0..<rotations.count {
            for col in 0..<rotations[row].count {
                rotations[row][col] = solutionRotations[row][col]
            }
        }
        score += 100
        playSound(named: "solution")
    }

    func showHint() {
        for row in 0..<rotations.count {
            for col in 0..<rotations[row].count {
                if rotations[row][col] != solutionRotations[row][col] {
                    rotations[row][col] = solutionRotations[row][col]
                    return
                }
            }
        }
    }

    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}

struct Level1View_Previews: PreviewProvider {
    static var previews: some View {
        Level1View().environmentObject(ViewRouter())
    }
}
