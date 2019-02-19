//
//  MovementComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

enum Direction: String, CaseIterable {
    case rigth =  "rigth-direction"
    case left  =  "left-direction"
    case idle  =  "idle-direction"
    
    static func getDirection(withValue value: String) -> Direction {
        for direction in Direction.allCases {
            if value == direction.rawValue {
                return direction
            }
        }
        return Direction.idle
    }
    
}

class MoveComponent: GKComponent {
    
    var direction: Direction!
    
    func move(to direction: Direction) {
        
        guard let node = self.entity!.component(ofType: RenderComponent.self)?.node else {
            return
        }
        // TODO: Change orientation of Controller, x to y
        switch direction {
        case .rigth:
            node.position.x += PlayerConstants.velocity
        case .left:
            node.position.x -= PlayerConstants.velocity
        case .idle:
            return
        }
    }
    
    func move(to point: CGPoint,
              withDuration duration: TimeInterval,
              withCompletion completion: @escaping () -> Void ) {
        if let node = self.entity!.component(ofType: RenderComponent.self)?.node {
            // TimeInterval, this time is to duration to arrive on reception
            node.run(SKAction.move(to: point, duration: duration)) {
                completion()
            }
        }
    }
    
}
