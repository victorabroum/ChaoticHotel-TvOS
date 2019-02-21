//
//  GameScene+Extesions.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import MultipeerConnectivity
// MARK: TouchMoved and Ended
extension GameScene {
    
    @objc func playPauseClicked() {
        self.players[self.peerTV]!.action()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)
        
        if (self.lastPoint == nil) {
            self.lastPoint = location
        } else {
            
            let direction: Direction
            
            if(self.lastPoint.y < location.y) {
                direction = .left
            } else {
                direction = .rigth
            }
            
            if let moveComp = staff.component(ofType: MoveComponent.self) {
                moveComp.direction = direction
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset last point
        self.lastPoint = nil
        
        // Stop move
        if let moveComp = staff.component(ofType: MoveComponent.self) {
            moveComp.direction = nil
        }
    }
    //Teste Function
    func move(staff: Staff, forDirection direction: Direction) {
        
        if let moveComp = staff.component(ofType: MoveComponent.self) {
            moveComp.direction = direction
        }
    }
    
    func tap(staff: Staff) {
        staff.action()
    }
}

extension GameScene: EasyMultiPeerDelegate {
    func connectedDevicesChanged(manager: EasyMultiPeerService, connectedDevices: [MCPeerID]) {
        self.createNewPlayer(forDevice: connectedDevices)
        
    }
    
    func createNewPlayer(forDevice device: [MCPeerID]) {
        guard self.players.count <= 4 else {
            return
        }
        let playerID = self.players.keys

        for deviceID in device {
            let exist = playerID.contains { (player) -> Bool in
                return player === deviceID
            }
            
            if exist {
                print("Existe!")
            } else {
              let newStaff = Staff.init(withImageNamed: "staff_placeHolder")
            if let renderComponent = newStaff.component(ofType: RenderComponent.self) {
                    renderComponent.node?.xScale = 0.3
                    renderComponent.node?.yScale = 0.3
                    renderComponent.node?.position = spawnStaff
            }
                
            self.players[deviceID] = newStaff
              self.entityManager.add(newStaff)

            }
        }
    }
    
    func didRecived(manager: EasyMultiPeerService, message: String, peerID: MCPeerID) {
        print("Recebeu => \(message)")
        var staffRecived: Staff?
        
        for player in self.players {
           if player.key == peerID {
                staffRecived = player.value
           } else {
                continue
           }
        }
        
        guard let actionStaff = staffRecived else {return}
        
        switch message {
        case JoystickAction.tap.rawValue:
            self.tap(staff: actionStaff)
        default:
            self.move(staff: actionStaff, forDirection: Direction.getDirection(withValue: message))
        }
    }
}
