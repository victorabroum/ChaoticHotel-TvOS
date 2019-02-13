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
    
    var direction: Direction!
    
    func move(to direction: Direction) {
        
        guard let node = self.entity!.component(ofType: RenderComponent.self)?.node else {
            return
        }
        
        // TODO: Put Player Velocity in order to put a constant
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
