//
//  Staff+HoldItens.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension Starff {
    func deliver(entityManager: EntityManager, aService service: ServiceComponent) {
        
        if (service.waitForServiceType == self.service) {
            
            self.hideChildrens()
            
            self.removeComponent(ofType: MoveComponent.self)
            guard let animateComp = self.component(ofType: AnimationComponent.self) else { return }
            
            animateComp.animateNode(withState: self.deliverAnimate()) {
                self.showChildrens()
                self.addComponent(MoveComponent(maxSpeed: PlayerConstants.normal))
                if let moveComp = self.component(ofType: MoveComponent.self) {
                    moveComp.direction = .idle
                }
                service.deliverService(ofType: self.service)
                if (self.holdItem != nil && self.service != .clean) {
                    entityManager.remove(self.holdItem)
                    self.holdItem = nil
                    self.service = .listen
                }
            }
        }
    }
    
    func hideChildrens() {
        guard let node = self.component(ofType: RenderComponent.self)?.node else { return }
        
        for child in node.children {
            child.run(SKAction.hide())
        }
    }
    
    func showChildrens() {
        guard let node = self.component(ofType: RenderComponent.self)?.node else { return }
        
        for child in node.children {
            child.run(SKAction.unhide())
        }
    }
    
    func deliverAnimate() -> AnimationState! {
        switch self.service {
        case .clean:
            return AnimationState.interactMop
        default:
            return nil
        }
    }
}
