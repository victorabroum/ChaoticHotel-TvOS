//
//  BackgroundHotelNode.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 20/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

class BackgroundHotelNode: SKNode {
    /*
     static let bgPortal: CGFloat = 11
     static let bgLamps: CGFloat = ZPosition.bgPortal
     static let bgReceptionTable: CGFloat = ZPosition.staff + 5
     static let bgLugaggeCart: CGFloat = -1
     static let bgScene: CGFloat = ZPosition.bgLugaggeCart - 5
     static let bgDoor: CGFloat = ZPosition.bgScene - 10
     static let bgSky: CGFloat = -50
     */
    
    var portalNode = SKNode()
    var lampsNode = SKSpriteNode(imageNamed: "bg_lamps")
    var receptionTable = SKSpriteNode(imageNamed: "bg_desk")
    var lugaggeCartNode = LugaggeCartNode(imageNamed: "bg_luggageCart")
    var bgSceneNode = SKSpriteNode(imageNamed: "bg_scene")
    var bgDoorNode = SKSpriteNode(imageNamed: "bg_doorBg")
    var skyNode = SKSpriteNode(imageNamed: "bg_sky")
    
    override init() {
        super.init()
        // Put right zPosition
        self.portalNode.zPosition = ZPosition.bgPortal
        self.lampsNode.zPosition = ZPosition.bgLamps
        self.receptionTable.zPosition = ZPosition.bgReceptionTable
        self.lugaggeCartNode.zPosition = ZPosition.bgLugaggeCart
        self.bgSceneNode.zPosition = ZPosition.bgScene
        self.skyNode.zPosition = ZPosition.bgSky
        
        // Add Portals to SKNode
        self.portalNode.addChild(SKSpriteNode(imageNamed: "bg_portal_2"))
        self.portalNode.addChild(SKSpriteNode(imageNamed: "bg_portal"))
        
        // Add childs to SKNode
        self.addChild(self.portalNode)
        self.addChild(self.lampsNode)
        self.addChild(self.receptionTable)
        self.addChild(self.lugaggeCartNode)
        self.addChild(self.bgSceneNode)
        self.addChild(self.skyNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
