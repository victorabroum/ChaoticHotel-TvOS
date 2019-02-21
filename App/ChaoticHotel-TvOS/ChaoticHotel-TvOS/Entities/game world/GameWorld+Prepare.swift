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
        self.prepareSlime()
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
}
