//
//  InteractDeleate.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

protocol InteractDelegate: class {
    func action(callBy owner: GKEntity)
}
