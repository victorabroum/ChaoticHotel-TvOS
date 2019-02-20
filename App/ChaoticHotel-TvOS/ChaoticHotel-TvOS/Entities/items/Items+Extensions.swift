//
//  Items+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

// Protocol Action on interact
extension Items: InteractDelegate {
    func action(callBy owner: GKEntity) {
        if let staff = owner as? Staff {
            if (staff.holdItem != nil) {
                self.drop(callBy: owner)
            } else {
                self.hold(callBy: owner)
            }
        }
    }
}

// Extnsion to lead with hold an item
extension Items {
    func hold(callBy owner: GKEntity) {
        self.isHold = true
        
        // Stop LifeTime
        if let lifeTime = self.component(ofType: LifeTimeComponent.self) {
            lifeTime.isHold = true
        }
        
        // Set staff to hold
        if let staff = owner as? Staff {
            staff.holdItem = self
            staff.service = self.serviceCategory
        }
        
        guard let node = owner.component(ofType: RenderComponent.self)?.node else { return }
        guard let itemNode = self.component(ofType: RenderComponent.self)?.node else { return }
        
        itemNode.move(toParent: node)
        itemNode.zPosition = node.zPosition + 10
        itemNode.xScale = 2.5
        itemNode.yScale = 2.5
        itemNode.position = .zero
        itemNode.physicsBody = nil
        itemNode.entity?.removeComponent(ofType: PhysicsBoydComponent.self)
        
    }
    
    func drop(callBy owner: GKEntity) {
        self.isHold = false
        
        // Run LifeTime
        if let lifeTime = self.component(ofType: LifeTimeComponent.self) {
            lifeTime.isHold = false
        }
        
        if let staff = owner as? Staff {
            staff.holdItem = nil
            staff.service = .listen
        }
        
        guard let itemNode = self.component(ofType: RenderComponent.self)?.node else { return }
        
        itemNode.move(toParent: itemNode.scene!)
        itemNode.xScale = 1
        itemNode.yScale = 1
        itemNode.physicsBody = self.physicsBodyComp.physicBody
        
    }
}
