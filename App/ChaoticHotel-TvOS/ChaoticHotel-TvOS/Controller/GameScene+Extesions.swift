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

// MARK: TouchMoved and Ended
extension GameScene {
    
    @objc func playPauseClicked() {
        staff.action()
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
    func moveStaff(forDirection direction: Direction) {
        if let moveComp = staff.component(ofType: MoveComponent.self) {
            moveComp.direction = direction
        }
    }
    
    func tapStaff() {
        self.staff.action()
    }
}

extension GameScene: EasyMultiPeerDelegate {
    func connectedDevicesChanged(manager: EasyMultiPeerService, connectedDevices: [String]) {
        print("Devices changed // \(connectedDevices)")
    }
    
    func didRecived(manager: EasyMultiPeerService, message: String) {
        print("Recebeu => \(message)")
        switch message {
        case JoystickAction.tap.rawValue:
            self.tapStaff()
        default:
            self.moveStaff(forDirection: Direction.getDirection(withValue: message))
        }
    }
}
