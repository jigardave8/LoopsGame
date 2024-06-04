//
//  ContentView.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        switch viewRouter.currentView {
        case .mainMenu:
            MainMenuView()
        case .level1:
            Level1View()
        }
    }
}

enum CurrentView {
    case mainMenu
    case level1
}


class ViewRouter: ObservableObject {
    @Published var currentView: ViewType = .mainMenu
}

enum ViewType {
    case mainMenu
    case level1
}
