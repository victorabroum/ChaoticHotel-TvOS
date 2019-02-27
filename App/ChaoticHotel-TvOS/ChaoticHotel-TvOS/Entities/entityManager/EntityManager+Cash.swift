//
//  EntityManager+Cash.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 27/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

extension EntityManager {
    func refreshCashLabel(newContent content: String) {
        if let cashLabel = self.scene.childNode(withName: "cashLabel") as? SKLabelNode {
            cashLabel.text = "$ \(content)"
        }
    }
    
    func getCashRegisterComp() -> CashRegisterComponent {
        let gameWorld = self.entities.first { (entity) -> Bool in
            if( entity is GameWorld) { return true }
            return false
        }
        
        return (gameWorld?.component(ofType: CashRegisterComponent.self))!
    }
}
