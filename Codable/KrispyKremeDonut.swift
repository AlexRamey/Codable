//
//  KrispyKreme.swift
//  Codable
//
//  Created by Alex Ramey on 1/6/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

protocol Donut {
    var name: String { get set }
    var price: Double { get set }
}

struct KrispyKremeDonut : Codable, Donut {
    // Donut Conformance
    var name: String
    var price: Double
    
    // Krispy Kreme Specific Details
    var love: Int
    
    init(name: String, price: Double, love: Int){
        self.name = name
        self.price = price
        self.love = love
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "donut_name"
        case price
        case love
    }
}
