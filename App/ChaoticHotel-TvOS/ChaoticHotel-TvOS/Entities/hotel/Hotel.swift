//
//  Hotel.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 14/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Hotel: GKEntity {
    
    var availableRooms = [SKNode]()
    
    // Track queue of Roomers
    var receptionQueue = [Roomer]()
    
    // Position inital for roomer wait on reception
    var receptionPoint: CGPoint
    
    init(availableRooms: [SKNode], receptionPoint: CGPoint) {
        self.availableRooms = availableRooms
        self.receptionPoint = receptionPoint
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enterOnRoom(roomer: Roomer) {
        if (!availableRooms.isEmpty) {
            
            // Change Roomer position to right Room
            let room = self.availableRooms.first!
            room.run(SKAction(named: "closeDoor")!)
            roomer.changeRoom(room)
            
            guard let node = roomer.component(ofType: RenderComponent.self)?.node else { return }
            
            node.run(SKAction.move(to: room.position, duration: 0)) {
                node.position.y -= node.size.height / 1.6
            }
            
            // Remove this room for available
            self.availableRooms.removeFirst()
        }
    }
    
    func addAvailableRoom(_ room: SKNode) {
        room.run(SKAction(named: "closeDoor")!.reversed())
        self.availableRooms.append(room)
    }
    
}
