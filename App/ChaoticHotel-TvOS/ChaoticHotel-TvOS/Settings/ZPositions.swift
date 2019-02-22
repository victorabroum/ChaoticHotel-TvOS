//
//  ZPositions.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 20/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

struct ZPosition {
    static let starff: CGFloat = 10
    static let roomer: CGFloat = ZPosition.starff - 2
    static let items: CGFloat = 2
    static let slime: CGFloat = ZPosition.starff + 5
    
    // About Background
    static let bgPortal: CGFloat = 11
    static let bgLamps: CGFloat = ZPosition.bgPortal
    static let bgReceptionTable: CGFloat = ZPosition.starff + 20
    static let bgLugaggeCart: CGFloat = -1
    static let bgScene: CGFloat = ZPosition.bgLugaggeCart - 5
    static let door: CGFloat = ZPosition.bgScene - 5
    static let bgDoor: CGFloat = ZPosition.bgScene - 10
    static let bgSky: CGFloat = -50
}
