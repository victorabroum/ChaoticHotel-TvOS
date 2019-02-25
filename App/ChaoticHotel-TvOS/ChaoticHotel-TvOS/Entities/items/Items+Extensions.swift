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
        if let staff = owner as? Starff {
            if (staff.holdItem == nil) {
                self.hold(callBy: owner)
            } else if let body = staff.component(ofType: PhysicsBoydComponent.self)?.physicBody {
                if (body.allContactedBodies().count <= 1) {
                    self.drop(callBy: owner)
                }
            }
        }
    }
}

// Extnsion to lead with hold an item
extension Items {
    func hold(callBy owner: GKEntity) {
        // Stop LifeTime
        
        if let lifeTime = self.component(ofType: LifeTimeComponent.self) {
            lifeTime.isHold = true
        }
        
        self.isHold = true
        
        // Set staff to hold
        if let staff = owner as? Starff {
            staff.holdItem = self
            staff.service = self.serviceCategory
        }
        
        guard let node = owner.component(ofType: RenderComponent.self)?.node else { return }
        guard let itemNode = self.component(ofType: RenderComponent.self)?.node else { return }
        
        if (self.rotation != nil) {
            itemNode.zRotation = self.rotation!
        }
        
        itemNode.move(toParent: node)
        itemNode.zPosition = 2
        itemNode.position.x = -(PlayerConstants.width/2 - 20)
        print("ITEM HEIHT \(itemNode.size.height)")
        itemNode.position.y = (PlayerConstants.height/2 - 35)
        itemNode.physicsBody = nil
    }
    
    func drop(callBy owner: GKEntity) {
        self.isHold = false
        
        // Run LifeTime
        if let lifeTime = self.component(ofType: LifeTimeComponent.self) {
            lifeTime.isHold = false
        }
        
        if let staff = owner as? Starff {
            staff.holdItem = nil
            staff.service = .listen
        }
        
        guard let itemNode = self.component(ofType: RenderComponent.self)?.node else { return }
        
        itemNode.move(toParent: itemNode.scene!)
        itemNode.zPosition = ZPosition.items
        itemNode.physicsBody = self.physicsBodyComp.physicBody
        
    }
}
