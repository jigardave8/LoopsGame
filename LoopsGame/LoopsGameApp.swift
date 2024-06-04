//
//  LoopsGameApp.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI

@main
struct LoopsGameApp: App {
    @StateObject var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
        }
    }
}


