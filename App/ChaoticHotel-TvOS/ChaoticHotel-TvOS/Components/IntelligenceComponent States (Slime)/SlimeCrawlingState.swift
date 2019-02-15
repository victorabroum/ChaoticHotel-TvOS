//
//  SlimeCrawlingState.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 14/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class SlimeCrawlingState: GKState {
    let entity: Slime
    
    init(_ entity: Slime) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is SlimeIdleState.Type:
            return true
        default:
            return false
        }
    }

    override func didEnter(from previousState: GKState?) {
        
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {return}
        
        let movement = self.entity.component(ofType: MoveComponent.self)
        
        let pointRight = CGPoint.init(x: (node.scene?.size.width)! / 2, y: node.position.y)
        
        let pointLeft = CGPoint.init(x: -((node.scene?.size.width)! / 2), y: node.position.y)
        
        movement?.move(to: pointRight, withDuration: 20, withCompletion: {
            movement?.move(to: pointLeft, withDuration: 20, withCompletion: {
                self.entity.stateMachine.enter(SlimeIdleState.self)
            })
        })
        
    }
}
