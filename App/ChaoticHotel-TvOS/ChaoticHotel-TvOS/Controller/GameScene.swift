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
    
    var players: [Player] = []
    var gameWorld: GameWorld!
    var entityManager: EntityManager!
    
    let peerTV = MCPeerID.init(displayName: "AppleTV-OS")
    
    override func sceneDidLoad() {
        // Multipeer Service Delegate
        service.delegate = self
        
        // Initiate entity manager
        self.entityManager = EntityManager(scene: self)
        
        self.spawnStaff = (self.childNode(withName: "elevatorGoUp")?.position)!
        self.createAllPlayers()
        // GameWorld
        self.gameWorld = GameWorld(scene: self)
        
    }
    
    override func didMove(to view: SKView) {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameScene.playPauseClicked))
        tapRecognizer.allowedPressTypes = [UIPress.PressType.playPause.rawValue] as [NSNumber]
        self.view!.addGestureRecognizer(tapRecognizer)
        
        self.addChild(BackgroundHotelNode())

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
