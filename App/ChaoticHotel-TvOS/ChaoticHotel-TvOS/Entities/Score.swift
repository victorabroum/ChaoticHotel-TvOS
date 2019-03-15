//
//  Score.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 14/03/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class Score: GKEntity {
    
    override init() {
        super.init()
        
        // Add Render Component
        let renderComp = RenderComponent(imageNamed: "coin")
        renderComp.node.entity = self
        renderComp.node.zPosition = ZPosition.baseHUD
        self.addComponent(renderComp)
        
        // Add Label component
        let labelComp = LabelComponent()
        
        // Customize font of label Node
        labelComp.labelNode.fontSize = FontSize.score
        
        labelComp.content = "0"
        labelComp.labelNode.zPosition = ZPosition.baseHUD
        labelComp.labelNode.position.x = renderComp.node.position.x + renderComp.node.size.width
        renderComp.node.addChild(labelComp.labelNode)
        self.addComponent(labelComp)
        
        // Add Cash Register
        let cashRegister = CashRegisterComponent()
        self.addComponent(cashRegister)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
