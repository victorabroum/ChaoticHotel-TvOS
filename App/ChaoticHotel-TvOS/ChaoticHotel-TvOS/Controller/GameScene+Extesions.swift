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
       self.players.firstPlayerWhere(peerIsEqual: peerTV)?.entity.action()
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
            if let moveComp = self.players.firstPlayerWhere(peerIsEqual: peerTV)?.entity.component(ofType: MoveComponent.self){
                moveComp.direction = direction
            }
           
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset last point
        self.lastPoint = nil
        
        // Stop move
        
        if let moveComp = self.players.firstPlayerWhere(peerIsEqual: peerTV)?.entity.component(ofType: MoveComponent.self) {
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
    func peerIsDisconnected(peer: MCPeerID) {
        self.deletePlayerToScene(peer: peer)
    }
    
    func connectedDevicesChanged(manager: EasyMultiPeerService, connectedDevices: [MCPeerID]) {
        self.createNewPlayer(forDevice: connectedDevices)
        
    }
    
    func createNewPlayer(forDevice device: [MCPeerID]) {
        guard self.players.count < 4 else {
            return
        }

        for deviceID in device {
            let player = self.players.firstPlayerWhere(peerIsEqual: deviceID)
            
            if player != nil {
                print("Existe!")
            } else {
              let newStaff = Staff.init(withImageNamed: "staff_placeHolder")
              self.service.send(message: PlayerColors.yellow.rawValue, forPeer: deviceID)
              if let renderComponent = newStaff.component(ofType: RenderComponent.self) {
                    renderComponent.node.position = spawnStaff
                
            }
              self.entityManager.add(newStaff)
                
              let newPlayer = Player.init(
                idPeer: deviceID,
                entity: newStaff,
                colorPlayer: UIColor.white)
                self.players.append(newPlayer)
            }
        }
    }
    
    func deletePlayerToScene(peer: MCPeerID) {
        self.players.removeAll { (ply) -> Bool in
            if ply.idPeer == peer {
                let node = ply.entity.component(ofType: RenderComponent.self)
                node?.node.isHidden = true
                self.entityManager.remove(ply.entity)
                return true
            } else {
                return false
            }
        }
        
        print("Total de players => \(self.players.count)")
    }
    
    func didRecived(manager: EasyMultiPeerService, message: String, peerID: MCPeerID) {
        print("Recebeu => \(message)")
        var staffRecived: Staff?
        
        for player in self.players {
           if player.idPeer == peerID {
                staffRecived = player.entity
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
