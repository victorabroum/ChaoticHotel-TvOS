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
            if let moveComp = self.players.firstPlayerWhere(peerIsEqual: peerTV)?.entity.component(
                ofType: MoveComponent.self) {
                moveComp.direction = direction
            }
           
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset last point
        self.lastPoint = nil
        
        // Stop move
        
        if let moveComp = self.players.firstPlayerWhere(peerIsEqual: peerTV)?.entity.component(
            ofType: MoveComponent.self) {
            moveComp.direction = .idle
        }
    }
    //Teste Function
    func move(staff: Starff, forDirection direction: Direction) {
        
        if let moveComp = staff.component(ofType: MoveComponent.self) {
            moveComp.direction = direction
        }
    }
    
    func tap(staff: Starff) {
        staff.action()
    }
}

extension GameScene: EasyMultiPeerDelegate {
    func peerIsDisconnected(peer: MCPeerID) {
        self.deletePlayerToScene(peer: peer)
    }
    
    func createAllPlayers() {
        for color in PlayerColors.allCases {
            let starff = Starff.init(withImageNamed: color.rawValue)
            var player: Player
            
            if color == PlayerColors.pink {
               player = Player.init(idPeer: peerTV, entity: starff, colorPlayer: color)
                let node = player.entity.component(ofType: RenderComponent.self)?.node
                node?.position = spawnStaff
                self.entityManager.add(starff)
                
            } else {
               player = Player.init(entity: starff, colorPlayer: color)
            }
               self.players.append(player)
        }
    }
    
    func connectedDevicesChanged(manager: EasyMultiPeerService, connectedDevices: [MCPeerID]) {
        self.createNewPlayer(forDevice: connectedDevices)
        
    }
    
    func createNewPlayer(forDevice device: [MCPeerID]) {

        for deviceID in device {
            let player = self.players.firstPlayerWhere(peerIsEqual: deviceID)
            
            if player != nil {
                print("Existe!")
            } else {
                let getPlayer = self.players.first { (firstPlayer) -> Bool in
                    return firstPlayer.idPeer == nil
                }
                guard let player = getPlayer else {return}
                let entity = player.entity
                player.idPeer = deviceID
                self.service.send(message: player.colorPlayer.rawValue, forPeer: deviceID)
                
                if let renderComponent = entity.component(ofType: RenderComponent.self) {
                
                    renderComponent.node.position = spawnStaff
                    self.entityManager.add(entity)
                
              }
                
            }
        }
    }
    
    func deletePlayerToScene(peer: MCPeerID) {
   
            let firstPlayer = self.players.first(where: { (ply) -> Bool in
                return ply.idPeer == peer
            })
            
            guard let player = firstPlayer else {return}
        
            player.idPeer = nil
            let entity = player.entity
            self.entityManager.remove(entity)
        
            print("Total de players => \(self.players.count)")
    }
    
    func didRecived(manager: EasyMultiPeerService, message: String, peerID: MCPeerID) {
        print("Recebeu => \(message)")
        var staffRecived: Starff?
        
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
