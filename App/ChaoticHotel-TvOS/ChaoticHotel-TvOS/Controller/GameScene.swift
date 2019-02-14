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
    private var lastSpawn: TimeInterval = 0
    
    var lastPoint: CGPoint!
    
    var staff: Staff!
    var hotel: Hotel!
    var entityManager: EntityManager!
    
    // Test
    var roomer: Roomer!

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.entityManager = EntityManager(scene: self)
        
        // Test Staff Entity
        staff = Staff(withImageNamed: "staff_placeHolder")
        // Change Sprite scale
        if let renderComponent = staff.component(ofType: RenderComponent.self) {
            print("tem render")
            renderComponent.node?.xScale = 0.1
            renderComponent.node?.yScale = 0.1
        }
        self.entityManager.add(staff)
        
        // Entity Hotel
        self.hotel = Hotel(availableRooms: self.childNode(withName: "rooms")!.children)
        self.entityManager.add(self.hotel)
        
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
        
        // Just for Spawn Roomer
        // TODO: Improve Spawn Logic
        let spawnRoomerInterval = TimeInterval(50)
        if (CACurrentMediaTime() - lastSpawn > spawnRoomerInterval) {
            lastSpawn = CACurrentMediaTime()
            print("De \(spawnRoomerInterval) em \(spawnRoomerInterval) segundos")
            
            // Test Roomer
            roomer = Roomer(withImageNamed: "staff_placeHolder")
            guard let renderComponent = roomer.component(ofType: RenderComponent.self) else {
                return
            }
            renderComponent.node?.xScale = 0.07
            renderComponent.node?.yScale = 0.07
            renderComponent.node?.run(SKAction.colorize(with: .blue, colorBlendFactor: 1, duration: 0))
            self.entityManager.add(roomer)
            
            renderComponent.node?.position = (self.childNode(withName: "spawnRoomer")?.position)!
            
            // Poderia alguma lógica
            roomer.walkTo(self.childNode(withName: "receptionPoint")!.position, withDuration: 3) {
                print("Enter on First state")
                self.roomer.stateMachine.enter(RoomerListnerState.self)
            }
            
        }
        
        self.lastUpdateTime = currentTime
        
        self.entityManager.update(deltaTime)
        
    }
    
}
