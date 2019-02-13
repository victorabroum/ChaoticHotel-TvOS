//
//  GameViewController.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 12/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var rootScene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Detect Swipe
        
        var swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameViewController.swipeRight))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
        
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameViewController.swipeLeft))
        swipeRecognizer.direction = .left
        self.view.addGestureRecognizer(swipeRecognizer)

        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {

            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as? GameScene? {
                
                self.rootScene = sceneNode

                // Copy gameplay related content over to the scene
                sceneNode!.entities = scene.entities
                sceneNode!.graphs = scene.graphs

                // Set the scale mode to scale to fit the window
                sceneNode!.scaleMode = .aspectFill

                // Present the scene
                if let view = self.view as? SKView? {
                    view!.presentScene(sceneNode)

                    view!.ignoresSiblingOrder = true

                    view!.showsFPS = true
                    view!.showsNodeCount = true
                }
            }
        }
    }
    
    @objc func swipeRight() {
        print("SWIPE RIGHT")
        if let moveComp = self.rootScene.staff.component(ofType: MovementComponent.self) {
            
            moveComp.move(to: .rigth)
            
        }
    }
    
    @objc func swipeLeft() {
        print("SWIPE Left")
        if let moveComp = self.rootScene.staff.component(ofType: MovementComponent.self) {
            
            moveComp.move(to: .left)
            
        }
    }

}
