//
//  Balloon+Utils.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 26/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

extension BallonComponent {
    func waitTime() -> TimeInterval {
        switch self.textureName {
        case "baloon_bag":
            return WaitTimer.bag
        case "baloon_checkIn", "baloon_checkOut":
            return WaitTimer.reception
        case "baloon_roomService":
            return WaitTimer.roomService
        default:
            return 0
        }
    }
}
