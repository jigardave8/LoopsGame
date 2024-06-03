//
//  Achievement.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let reward: String
    var isCompleted: Bool = false
}
