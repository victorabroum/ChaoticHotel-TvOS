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
        
        guard let ballonNode = self.entity.component(ofType: BallonComponent.self) else { return }
        guard let node = self.entity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        node.xScale = -1
        
        guard let gameScene = node.scene as? GameScene else { return }
        guard let position = gameScene.childNode(withName: "spawnRoomer")?.position else { return }
        
        if (previousState is RoomerAssistState) {
            ballonNode.changeTexture(forTexture: SKTexture(imageNamed: "baloon_happy"))
            ballonNode.showBallon()
            print("AMEI O HOTEL")
        }
        
        // This a Simple Solution
//        guard let animateRoomer = self.entity.component(ofType: AnimationComponent.self) else { return }
//        animateRoomer.animateNode(withState: .walk)
//        node.run(SKAction.moveBy(x: position.x, y: 0, duration: AnimationDuration.roomerGoOut)) {
//            node.removeFromParent()
//        }
        guard let animateRoomer = self.entity.component(ofType: AnimationComponent.self) else { return }
        
        if !(self.entity.isInRoom) {
            // If is first floor
            animateRoomer.animateNode(withState: .walk)
            node.run(SKAction.moveBy(x: position.x, y: 0, duration: AnimationDuration.roomerGoOut)) {
                node.removeFromParent()
            }
        } else {
            
            animateRoomer.animationState = .wait
            animateRoomer.animateNode(withState: .idle)
            
            // If is second floor
            let zapNode = SKSpriteNode(imageNamed: "zap")
            
            zapNode.anchorPoint = CGPoint(x: 0.5, y: 0)
            zapNode.zPosition = node.zPosition + 10
            node.addChild(zapNode)
            
            zapNode.run(SKAction(named: "zap")!) {
                node.removeFromParent()
            }
        }
        
    }

}
