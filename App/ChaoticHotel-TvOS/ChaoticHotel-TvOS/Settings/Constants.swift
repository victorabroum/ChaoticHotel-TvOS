//
//  Constants.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

struct WaitTimer {
    static let reception: TimeInterval = 10
    static let roomService: TimeInterval = 20
    static let bag: TimeInterval = 10
    static let slimeSleep: TimeInterval = 5
    static let crawling: TimeInterval = 40
    static let spwanGoop: TimeInterval = 5.0
}

struct BallonSize {
    static let width: Double = 300.00
    static let height: Double = 300.00
    static let posY: CGFloat = 400.00
}

struct AnimationDuration {
    static let roomerGoOut: TimeInterval = 3
}

struct PlayerConstants {
    static let velocity: CGFloat = 20
}

enum ServiceCategory {
    case bag
    case food
    case checkIn
    case checkOut
    case clean
}

enum Itens {
    case bag
    case mop // Esfregão
    case food
}
