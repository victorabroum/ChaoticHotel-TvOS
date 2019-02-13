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

class MovementComponent: GKComponent {
    
    var toPoint: CGPoint?
    
    // TODO: Don't need pass time interval
//    func move(to point: CGPoint, duration: TimeInterval = 1.0) {
//        guard let node = self.entity!.component(ofType: RenderComponent.self)?.node else {
//            return
//        }
//        
//        node.run(SKAction.move(to: point, duration: duration))
//    }
    
    func move(to direction: Direction) {
        
        guard let node = self.entity!.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        switch direction {
        case .rigth:
            print("GO TO Right")
            node.position.x += 10
        case .left:
            print("GO TO Left")
            node.position.x -= 10
        }
    }
    
}
