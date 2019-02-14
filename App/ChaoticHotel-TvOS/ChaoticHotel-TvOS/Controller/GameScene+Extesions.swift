//
//  GameScene+Extesions.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

// MARK: TouchMoved and Ended
extension GameScene {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)
        
        if (self.lastPoint == nil) {
            self.lastPoint = location
        } else {
            
            let direction: Direction
            
            if(self.lastPoint.x > location.x) {
                direction = .left
            } else {
                direction = .rigth
            }
            
            if let moveComp = staff.component(ofType: MoveComponent.self) {
                moveComp.direction = direction
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset last point
        self.lastPoint = nil
        
        // Stop move
        if let moveComp = staff.component(ofType: MoveComponent.self) {
            moveComp.direction = nil
        }
    }
}
