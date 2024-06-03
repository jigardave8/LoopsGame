//
//  Piece.swift
//  LoopsGame
//
//  Created by Jigar on 02/06/24.
//

import SwiftUI


import SwiftUI

struct Piece: Identifiable, Equatable {
    let id = UUID()
    var rotation: Double
    var targetRotation: Double
    var path: Path
}
