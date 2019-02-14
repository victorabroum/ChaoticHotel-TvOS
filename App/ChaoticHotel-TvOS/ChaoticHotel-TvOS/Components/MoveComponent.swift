//
//  MovementComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

enum Direction {
    case rigth
    case left
}

class MoveComponent: GKComponent {
    
    var direction: Direction!
    
    func move(to direction: Direction) {
        
        guard let node = self.entity!.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        // TODO: #04 Put Player Velocity in order to put a constant
        // TODO: Change orientation of Controller, x to y
        switch direction {
        case .rigth:
            print("GO TO Right")
            node.position.x += 10
        case .left:
            print("GO TO Left")
            node.position.x -= 10
        }
    }
    
    func move(to point: CGPoint, withCompletion completion: @escaping () -> Void ) {
        if let node = self.entity!.component(ofType: RenderComponent.self)?.node {
            // TimeInterval, this time is to duration to arrive on reception
            node.run(SKAction.move(to: point, duration: 3)) {
                completion()
            }
        }
    }
    
}
