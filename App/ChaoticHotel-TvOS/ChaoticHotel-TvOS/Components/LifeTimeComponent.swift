//
//  LifeTimeComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class LifeTimeComponent: GKComponent {
    var remainingTime: TimeInterval
    var lastTime: TimeInterval = 0
    
    init(lifeDuration: TimeInterval) {
        self.remainingTime = lifeDuration
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Life System
extension LifeTimeComponent {
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        let interval: TimeInterval = 1
        
        if (CACurrentMediaTime() - lastTime > interval) {
            lastTime = CACurrentMediaTime()
            self.remainingTime -= 1
        }
        
        if (self.remainingTime <= 0) {
            print("SUMIU")
        }
        
    }
}
