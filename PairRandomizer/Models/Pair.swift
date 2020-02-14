//
//  Pair.swift
//  PairRandomizer
//
//  Created by Devin Singh on 2/14/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation

class Pair: Codable {
    var firstPerson: String?
    var secondPerson: String?
    
    init(firstPerson: String?, secondPerson: String?) {
        self.firstPerson = firstPerson
        self.secondPerson = secondPerson
    }
}
