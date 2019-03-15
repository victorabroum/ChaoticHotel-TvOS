//
//  LabelComponent.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 14/03/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class LabelComponent: GKComponent {
    var content: String = "" {
        didSet {
            labelNode.text = content
        }
    }
    
    var labelNode = SKLabelNode()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
