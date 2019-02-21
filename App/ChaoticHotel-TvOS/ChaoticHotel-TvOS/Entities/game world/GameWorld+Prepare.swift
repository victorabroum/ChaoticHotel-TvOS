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
        self.prepareItems()
    }
    
    // Preapre Slime Enemy
    func prepareSlime() {
        let slime = Slime(
            withImageNamed: "slime_placeHolder",
            entityManager: self.scene.entityManager,
            possibleSpawnArea: self.scene.childNode(withName: "slimeArea")!)
        
        guard let renderComponentSlime = slime.component(ofType: RenderComponent.self) else {return}
        
        let ySlime = self.scene.childNode(withName: "elevatorGoDown")?.position
        let offset = renderComponentSlime.node.size.width + 100
        renderComponentSlime.node.position = CGPoint.init(
            x: -(self.scene.size.width / 2) - offset,
            y: ySlime!.y + 10)
        
        self.scene.entityManager.add(slime)
        slime.crawlingInFloor()
    }
    
    // Prepare Elevators
    func prepareElevators() {
        var elevator = Elevator(goTo: .down)
        if let renderComp = elevator.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.scene.childNode(withName: "elevatorGoDown")!.position
        }
        self.scene.entityManager.add(elevator)
        
        elevator = Elevator(goTo: .upper)
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
        let itemMop = Items(imageNamed: "mop", serviceCategory: .clean, isHold: false, categoryMask: .mop, lifeTime: -1)
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
}
