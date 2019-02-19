//
//  Kitchen+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension Kitchen: InteractDelegate {
    func action(callBy owner: GKEntity) {
        
        if let staff = owner as? Staff {
            if (staff.isholdItem) { return }
            
            print("Give a plate of Food")
            
            if let staff = owner as? Staff {
                print("É um Staff \(staff)")
            }
        }
        
        
    }
}
