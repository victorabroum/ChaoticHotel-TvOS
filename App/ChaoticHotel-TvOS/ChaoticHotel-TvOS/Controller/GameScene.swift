//
//  GameScene.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 12/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit
import MultipeerConnectivity

class GameScene: SKScene {

    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()

    var spawnStaff = CGPoint.init(x: 0, y: 0)
    let service = EasyMultiPeerService.init(serviceType: "chaotic-hotel")
    
    private var lastUpdateTime: TimeInterval = 0
    private var lastSpawn: TimeInterval = 0
    
    var lastPoint: CGPoint!
    
    var staff: Staff!
    var players: [MCPeerID: Staff]  = [:]
    var hotel: Hotel!
    var gameWorld: GameWorld!
    var receptionTable: Reception!
    var entityManager: EntityManager!
    
    let peerTV = MCPeerID.init(displayName: "AppleTV-OS")
    
    // Test
    var roomer: Roomer!

    override func sceneDidLoad() {
        // Multipeer Service Delegate
        service.delegate = self
        
        // Initiate entity manager
        self.entityManager = EntityManager(scene: self)
        
        self.spawnStaff = (self.childNode(withName: "elevatorGoUp")?.position)!

        // Test Staff Entity
        staff = Staff(withImageNamed: "staff_placeHolder")
        self.players = [peerTV: staff]
        // Change Sprite position
        if let renderComponent = staff.component(ofType: RenderComponent.self) {
            renderComponent.node.position = spawnStaff
        }
        self.entityManager.add(staff)
        
        // GameWorld
        self.gameWorld = GameWorld(scene: self)
        self.hotel = self.gameWorld.hotelEntity
        
    }
    
    override func didMove(to view: SKView) {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameScene.playPauseClicked))
        tapRecognizer.allowedPressTypes = [UIPress.PressType.playPause.rawValue] as [NSNumber]
        self.view!.addGestureRecognizer(tapRecognizer)
        
//         self.addChild(BackgroundHotelNode())
    }

    override func update(_ currentTime: TimeInterval) {
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }

        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime
        
        self.entityManager.update(deltaTime)
        
        self.lastUpdateTime = currentTime
    }
    
}
