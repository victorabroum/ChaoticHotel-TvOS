//
//  MoveSystem.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension MoveComponent {
    override func update(deltaTime seconds: TimeInterval) {
        if (self.direction != nil) {
            self.move(to: self.direction)
        }
    }
}
