//
//  Hotel+ControlQueue.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 15/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

extension Hotel {
    
    // Enter on Queue
    func enterOnQueue(_ roomer: Roomer) {
        
        if (self.receptionQueueHasSpace()) {
            self.receptionQueue.append(roomer)
            
            // Now should update Nodes positions
            self.ornagizeQueue()
        }
    }
    
    // Exit from queue
    func exitQueue() {
        if (!self.receptionQueue.isEmpty) {
            let roomerAssisted = self.receptionQueue.first!
            self.enterOnRoom(roomer: roomerAssisted)
            self.receptionQueue.removeFirst()
            
            // Now should update Nodes positions
            self.ornagizeQueue()
        }
    }
    
    // Can Add new Roomer?
    func receptionQueueHasSpace() -> Bool {
        
        // Queue max is 5 Roomer
        if (self.receptionQueue.count <= 5) {
            return true
        }
        
        return false
    }
    
    func ornagizeQueue() {
        var index: CGFloat = 0
        for roomer in self.receptionQueue {
            guard let node = roomer.component(ofType: RenderComponent.self)?.node else { return }
            guard let moveComp = roomer.component(ofType: MoveComponent.self) else { return }
            
            let point = self.receptionPoint.x - (((node.size.width/2) * index) + 10)
            moveComp.move(to: CGPoint(x: point, y: node.position.y),
                          withDuration: 0.6) { }
            
            index += 1
        }
    }
}
