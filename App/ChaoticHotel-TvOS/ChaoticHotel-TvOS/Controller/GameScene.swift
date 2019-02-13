//
//  GameScene.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 12/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()

    private var lastUpdateTime: TimeInterval = 0
    
    var lastPoint: CGPoint!
    
    var staff: Staff!
    var entityManager: EntityManager!

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.entityManager = EntityManager(scene: self)
        
        staff = Staff(withImageNamed: "staff_placeHolder")
        // Change Sprite scale
        if let renderComponent = staff.component(ofType: RenderComponent.self) {
            print("tem render")
            renderComponent.node?.xScale = 0.1
            renderComponent.node?.yScale = 0.1
        }
        
        self.entityManager.add(staff)
        
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }

        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime

        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: deltaTime)
        }

        self.lastUpdateTime = currentTime
        
        self.entityManager.update(deltaTime)
    }
    
}
