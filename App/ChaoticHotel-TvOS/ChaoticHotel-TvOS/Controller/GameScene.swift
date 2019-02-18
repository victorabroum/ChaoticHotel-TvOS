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
    var gameWorld: GameWorld!
    var receptionTable: Reception!
    var entityManager: EntityManager!
    
    var listOfRoomers = [Roomer]()
    
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
            renderComponent.node?.xScale = 0.3
            renderComponent.node?.yScale = 0.3
            renderComponent.node?.position = (self.childNode(withName: "elevatorGoUp")?.position)!
        }
        self.entityManager.add(staff)
        
        // GameWorld
        self.gameWorld = GameWorld(scene: self)
        self.hotel = self.gameWorld.hotelEntity
        
        self.physicsWorld.contactDelegate = self.gameWorld
        
        //Teste Slime Entity
        let slime = Slime.init(withImageNamed: "staff_placeHolder")
        
        guard let renderComponentSlime = slime.component(ofType: RenderComponent.self) else {return}
        
        renderComponentSlime.node?.xScale = 0.35
        renderComponentSlime.node?.yScale = 0.35
        let ySlime = self.childNode(withName: "elevatorGoDown")?.position
        
        renderComponentSlime.node?.position = CGPoint.init(
            x: -(self.size.width / 2) - 40,
                y: ySlime?.y ?? 0)
        
        self.entityManager.add(slime)
        slime.crawlingInFloor()
        
        // Reception Table Entity
        self.receptionTable = Reception(hotel: self.hotel)
        if let renderComp = self.receptionTable.component(ofType: RenderComponent.self) {
            renderComp.node?.position = self.childNode(withName: "reception")!.position
        }
        self.entityManager.add(self.receptionTable)
        
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //Slime shot goop in hotel - Teste
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }

        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime

        // Update entities
        for entity in self.entityManager.entities {
            entity.update(deltaTime: deltaTime)
        }
        
        // Just for Spawn Roomer
        // TODO: Improve Spawn Logic
        let spawnRoomerInterval = TimeInterval(5)
        if (CACurrentMediaTime() - lastSpawn > spawnRoomerInterval) {
            lastSpawn = CACurrentMediaTime()
            print("De \(spawnRoomerInterval) em \(spawnRoomerInterval) segundos")
            
            // Test Roomer
            roomer = Roomer(withImageNamed: "staff_placeHolder")
            guard let renderComponent = roomer.component(ofType: RenderComponent.self) else {
                return
            }
            renderComponent.node?.xScale = 0.35
            renderComponent.node?.yScale = 0.35
            renderComponent.node?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.3, duration: 0))
            self.entityManager.add(roomer)
            
            renderComponent.node?.position = (self.childNode(withName: "spawnRoomer")?.position)!
            
            self.roomer.stateMachine.enter(RoomerArriveState.self)
            
            self.listOfRoomers.append(roomer)
            
        }
        
        self.lastUpdateTime = currentTime
        
        self.entityManager.update(deltaTime)
        
    }
    
}
