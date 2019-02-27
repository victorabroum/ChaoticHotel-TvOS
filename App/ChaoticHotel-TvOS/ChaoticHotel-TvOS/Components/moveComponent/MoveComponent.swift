//
//  MovementComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum Direction: String, CaseIterable {
    case rigth =  "rigth-direction"
    case left  =  "left-direction"
    case idle  =  "idle-direction"
    
    static func getDirection(withValue value: String) -> Direction {
        for direction in Direction.allCases {
            if value == direction.rawValue {
                return direction
            } else {}
        }
        return Direction.idle
    }
    
}

class MoveComponent: GKAgent2D, GKAgentDelegate {
    
    var direction: Direction! = nil
    
    init(maxSpeed: Float) {
        super.init()
        self.maxSpeed = maxSpeed
        self.mass = 0.01
        self.maxAcceleration = 100
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: RenderComponent.self) else {
            return
        }
        print("WILL UPDATE AGENTE")
        position = float2(
            Float(spriteComponent.node.position.x),
            Float(spriteComponent.node.position.y))
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        
        guard let spriteComponent = entity?.component(ofType: RenderComponent.self) else {
            return
        }
        print("DID UPDATE AGENTE")
        spriteComponent.node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
    }
    
    func move(to direction: Direction) {
        
        guard let starffEntity = self.entity as? Starff else { return }
        
        guard let node = starffEntity.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        guard let animationComp = starffEntity.component(ofType: AnimationComponent.self) else { return }
        var animateState: AnimationState = starffEntity.holdItem != nil ? .idleHandsUp : .idle
        
        switch direction {
        case .rigth:
            if (node.xScale < 0) {
                node.xScale *= -1
            }
            node.position.x += CGFloat(self.maxSpeed)
            animateState = starffEntity.holdItem != nil ? .walkHandsUp : .walk
        case .left:
            if (node.xScale > 0) {
                node.xScale *= -1
            }
            node.position.x -= CGFloat(self.maxSpeed)
            animateState = starffEntity.holdItem != nil ? .walkHandsUp : .walk
        case .idle:
            animateState = starffEntity.holdItem != nil ? .idleHandsUp : .idle
        }
        
        animationComp.animateNode(withState: animateState)
    }
    
    func move(to point: CGPoint,
              withDuration duration: TimeInterval,
              withCompletion completion: @escaping () -> Void ) {
        if let node = self.entity!.component(ofType: RenderComponent.self)?.node {
            // TimeInterval, this time is to duration to arrive on reception
            
            guard let animateComp =
                self.entity!.component(ofType: AnimationComponent.self) else { return }
            
            animateComp.animateNode(withState: .walk)
            
            node.run(SKAction.move(to: point, duration: duration)) {
                animateComp.animateNode(withState: .idle)
                completion()
            }
        }
    }
}
