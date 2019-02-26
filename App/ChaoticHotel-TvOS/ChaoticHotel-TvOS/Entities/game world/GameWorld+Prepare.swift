//
//  GameWorld+Prepare.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 21/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameWorld {
    
    func prepareLevel() {
        self.prepareElevators()
        self.prepareReceptionTable()
        self.prepareKitchen()
        self.prepareSlime()
        self.prepareFloor()
        self.prepareItems()
        self.prepareWalls()
    }
    
    // Preapre Slime Enemy
    func prepareSlime() {
        let slime = Slime(
            withImageNamed: "slime",
            entityManager: self.scene.entityManager,
            possibleSpawnArea: self.scene.childNode(withName: "slimeArea")!)
        
        guard let renderComponentSlime = slime.component(ofType: RenderComponent.self) else {return}
        
        let slimeSpawnPos = self.scene.childNode(withName: "slimeSpawn")!.position
        renderComponentSlime.node.position = slimeSpawnPos
        
        self.scene.entityManager.add(slime)
        slime.crawlingInFloor()
    }
    
    // Prepare Elevators
    func prepareElevators() {
        var elevator = Elevator(goTo: .goDown)
        if let renderComp = elevator.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.scene.childNode(withName: "elevatorGoDown")!.position
        }
        self.scene.entityManager.add(elevator)
        
        elevator = Elevator(goTo: .goUp)
        if let renderComp = elevator.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.scene.childNode(withName: "elevatorGoUp")!.position
        }
        self.scene.entityManager.add(elevator)
    }
    
    // Preapre Kitchen
    func prepareKitchen() {
        let kitchen = Kitchen()
        if let renderComp = kitchen.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.scene.childNode(withName: "roomServiceStation")!.position
        }
        self.scene.entityManager.add(kitchen)
    }
    
    // Prepare Level itens
    func prepareItems() {
        // Mop
//        let itemMop = Items(
//            imageNamed: "mop",
//            serviceCategory: .clean,
//            isHold: false,
//            categoryMask: CategoryMask.items,
//            lifeTime: -1,
//            rotation: CGFloat.pi/2)
        let itemMop = Mop()
        if let renderComp = itemMop.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.scene.childNode(withName: "rubber")!.position
        }
        self.scene.entityManager.add(itemMop)
    }
    
    // Preprare Reception table entity
    func prepareReceptionTable() {
        let receptionTable = Reception(hotel: self.hotelEntity)
        if let renderComp = receptionTable.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.scene.childNode(withName: "reception")!.position
        }
        self.scene.entityManager.add(receptionTable)
    }
    
    func prepareWalls() {
        // Right wall
        var wall = SKSpriteNode(
            texture: nil,
            color: .clear,
            size: CGSize(width: 100, height: self.scene.frame.height))
        // Physics
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody!.affectedByGravity = false
        wall.physicsBody!.allowsRotation = false
        wall.physicsBody!.pinned = true
        wall.physicsBody!.categoryBitMask = CategoryMask.walls
        wall.physicsBody!.collisionBitMask = CategoryMask.starff
        // Position
        wall.position.x = self.scene.frame.width / 2
        self.scene.addChild(wall)
        
        // Left wall
        wall = SKSpriteNode(
            texture: nil,
            color: .clear,
            size: CGSize(width: 100, height: self.scene.frame.height))
        // Physics
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody!.affectedByGravity = false
        wall.physicsBody!.allowsRotation = false
        wall.physicsBody!.pinned = true
        wall.physicsBody!.categoryBitMask = CategoryMask.walls
        wall.physicsBody!.collisionBitMask = CategoryMask.starff
        // Position
        wall.position.x = -(self.scene.frame.width / 2)
        self.scene.addChild(wall)
        
    }
    
    func prepareFloor() {
        // 1st Floor
        var floorNode = SKSpriteNode(
            texture: nil,
            color: .clear,
            size: CGSize(width: self.scene.frame.width, height: 30))
        
        // Physics
        floorNode.physicsBody = SKPhysicsBody(rectangleOf: floorNode.size)
        floorNode.physicsBody?.affectedByGravity = false
        floorNode.physicsBody?.pinned = true
        floorNode.physicsBody?.allowsRotation = false
        floorNode.physicsBody?.categoryBitMask = CategoryMask.floor
        floorNode.physicsBody?.collisionBitMask = CategoryMask.items
        // Position
        floorNode.position.y = -(self.scene.frame.height / 2)
        self.scene.addChild(floorNode)
        
        // 2st Floor
        floorNode = SKSpriteNode(
            texture: nil,
            color: .clear,
            size: CGSize(width: self.scene.frame.width, height: 20))
        
        // Physics
        floorNode.physicsBody = SKPhysicsBody(rectangleOf: floorNode.size)
        floorNode.physicsBody?.affectedByGravity = false
        floorNode.physicsBody?.pinned = true
        floorNode.physicsBody?.allowsRotation = false
        floorNode.physicsBody?.categoryBitMask = CategoryMask.floor
        floorNode.physicsBody?.collisionBitMask = CategoryMask.items
        // Position
        floorNode.position.y -= 105
        self.scene.addChild(floorNode)
    }
}
