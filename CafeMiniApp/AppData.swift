//
//  AppData.swift
//  CafeMiniApp
//
//  Created by BRENNAN REINHARD on 9/12/24.
//

import Foundation

class AppData {
    // parallel arrays are 👎
    static var foods: [String] = ["Taco", "Burger", "Hot Dog", "Pretzel", "Chicken"]
    static var prices: [Double] = [2.50, 6.00, 4.00, 2.25, 5.50]
    
    // name: quantity
    static var cart: [String: Int] = [:]
}
