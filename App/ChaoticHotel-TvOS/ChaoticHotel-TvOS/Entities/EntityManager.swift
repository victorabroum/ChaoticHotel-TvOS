//
//  EntityManager.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    
    // Variables
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    let scene: SKScene
    
    lazy var componentSystems: [GKComponentSystem] = {
        return []
    }()
    
    // Init with a Scene
    init(scene: SKScene) {
        self.scene = scene
    }
    
    // Add an Entity
    func add(_ entity: GKEntity) {
        self.entities.insert(entity)
        
        // If has SpriteComponent, so it's rendered on Scene
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        // Add rigth components systems
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }
    
    // Remove an Entity
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        
        self.entities.remove(entity)
        
        self.toRemove.insert(entity)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        // Update Components in System
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        // Remove right component
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        toRemove.removeAll()
    }
    
}
