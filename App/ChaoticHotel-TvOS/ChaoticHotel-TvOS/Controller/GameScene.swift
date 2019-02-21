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
        
        //Teste Slime Entity
        let slime = Slime(
            withImageNamed: "slime_placeHolder",
            entityManager: self.entityManager,
            possibleSpawnArea: self.childNode(withName: "slimeArea")!)
        
        guard let renderComponentSlime = slime.component(ofType: RenderComponent.self) else {return}
        
        let ySlime = self.childNode(withName: "elevatorGoDown")?.position
        
        renderComponentSlime.node.position = CGPoint.init(
            x: -(self.size.width / 2) - 100,
                y: ySlime!.y + 10)
        
        self.entityManager.add(slime)
        slime.crawlingInFloor()
        
        // Reception Table Entity
        self.receptionTable = Reception(hotel: self.hotel)
        if let renderComp = self.receptionTable.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.childNode(withName: "reception")!.position
        }
        self.entityManager.add(self.receptionTable)
        
        // Elevator Entity
        var elevator = Elevator(goTo: .down)
        if let renderComp = elevator.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.childNode(withName: "elevatorGoDown")!.position
        }
        self.entityManager.add(elevator)
        
        elevator = Elevator(goTo: .upper)
        if let renderComp = elevator.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.childNode(withName: "elevatorGoUp")!.position
        }
        self.entityManager.add(elevator)
        
        // Kitchen Entity
        let kitchen = Kitchen()
        if let renderComp = kitchen.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.childNode(withName: "roomServiceStation")!.position
        }
        self.entityManager.add(kitchen)
        
        // Items Entity
        let itemMop = Items(imageNamed: "", serviceCategory: .clean, isHold: false, categoryMask: .mop, lifeTime: -1)
        if let renderComp = itemMop.component(ofType: RenderComponent.self) {
            renderComp.node.position = self.childNode(withName: "rubber")!.position
        }
        self.entityManager.add(itemMop)
        
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
