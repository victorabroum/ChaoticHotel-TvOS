//
//  RoomerGoOutState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerGoOutState: GKState {
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
        print("RoomerGoOutState didEnter")
        
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        let spawnPosition = node.scene?.childNode(withName: "spawnRoomer")?.position
        
        node.run(SKAction.move(to: spawnPosition!, duration: AnimationDuration.roomerGoOut)) {
            node.removeFromParent()
        }
    }

}
