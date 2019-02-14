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
    
    init(availableRooms: [SKNode]) {
        self.availableRooms = availableRooms
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enterOnRoom(roomer: Roomer) {
        if (!availableRooms.isEmpty) {
            // TODO: Logic to allocate a Roomer in a room
            
            // Change Roomer position to right Room
            let room = self.availableRooms.first!
            roomer.changeRoom(room)
            roomer.walkTo(room.position)
            
            
            // Remove this room for available
            self.availableRooms.removeFirst()
        }
    }
    
    func addAvailableRoom(_ room: SKNode) {
        self.availableRooms.append(room)
    }
    
}
