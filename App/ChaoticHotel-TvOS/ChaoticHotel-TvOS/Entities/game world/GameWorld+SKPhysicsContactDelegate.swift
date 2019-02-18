//
//  GameWorld+SKPhysicsContactDelegate.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

extension GameWorld: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contato")
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
