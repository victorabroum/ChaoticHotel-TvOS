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
    static let crawling: TimeInterval = 50
    static let spwanGoop: TimeInterval = 5.0
    static let foodLifeTime: TimeInterval = 5.0
    static let spawnRoomer: TimeInterval = 15.0
}

struct BallonSize {
    static let width: Double = 100.00
    static let height: Double = 100.00
    static let posY: CGFloat = 55.00
}

struct AnimationDuration {
    static let roomerGoOut: TimeInterval = 3
}

struct PlayerConstants {
    static var velocity: Float = PlayerConstants.normal
    static let slow: Float = 2
    static let normal: Float = 5
    static let width: CGFloat = 115
    static let height: CGFloat = 155
}

enum ServiceCategory {
    case bag
    case food
    case listen
    case checkIn
    case clean
}

enum Itens {
    case bag
    case mop // Esfregão
    case food
}

enum PlayerColors: String, CaseIterable {
    case red = "red"
    case yellow = "yellow"
    case blue = "blue"
    case pink = "pink"
}

struct ListOfRoomers {
    static let assests = [
        "astro",
        "krillbert"
    ]
}
