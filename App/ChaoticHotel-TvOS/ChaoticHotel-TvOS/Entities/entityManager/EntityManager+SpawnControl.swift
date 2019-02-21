//
//  EntityManager+SpawnControl.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 21/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

// Control Spawn Goop
extension EntityManager {
    func spawnGoop(onParentNode parentNode: SKSpriteNode) {
        let goop = Goop(withImage: "slime_placeHolder", parentNode: parentNode)
        goop.stateMachine.enter(GoopIdleState.self)
        self.add(goop)
    }
}
