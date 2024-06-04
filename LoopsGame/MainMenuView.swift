//
//  MainMenuView.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var animateGradient = false
    @State private var animateShape = false
    
    var body: some View {
        ZStack {
            // Background Gradient Animation
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple, Color.orange, Color.pink]),
                startPoint: animateGradient ? .topLeading : .bottomTrailing,
                endPoint: animateGradient ? .bottomTrailing : .topLeading
            )
            .edgesIgnoringSafeArea(.all)
            .animation(Animation.linear(duration: 5).repeatForever(autoreverses: true))
            .onAppear {
                self.animateGradient.toggle()
            }
            
            VStack(spacing: 50) {
                // Title with Animation
                Text(" Pipe Loops")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .scaleEffect(animateShape ? 1.1 : 1.0)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                    .onAppear {
                        self.animateShape.toggle()
                    }
                
                // Buttons
                VStack(spacing: 20) {
                    Button(action: {
                        viewRouter.currentView = .level1
                    }) {
                        Text("Start Game")
                            .font(.title2)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }

                    Button(action: {
                        // Add action for Skip Ad
                    }) {
                        Text("Skip Ad")
                            .font(.title2)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }

                    Button(action: {
                        // Add action for Choose Level
                    }) {
                        Text("Choose Level")
                            .font(.title2)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }
                }
                .padding()
                
                // Looping Shape Animation
                LoopingShape()
                    .frame(width: 150, height: 150)
                    .rotationEffect(animateShape ? .degrees(360) : .degrees(0))
                    .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
                    .onAppear {
                        self.animateShape.toggle()
                    }
            }
            .padding(.horizontal, 40)
        }
    }
}

// Custom Looping Shape
struct LoopingShape: View {
    var body: some View {
        ZStack {
            ForEach(0..<10) { i in
                Rectangle()
                    .stroke(lineWidth: 3)
                    .foregroundColor(Color.white.opacity(Double(i) / 10.0))
                    .scaleEffect(CGFloat(i) / 10.0)
                    .rotationEffect(.degrees(Double(i) * 120))
                    
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView().environmentObject(ViewRouter())
    }
}
