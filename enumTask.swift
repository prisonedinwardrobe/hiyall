//
//  enumTask.swift
//  
//
//  Created by leonid on 29.03.2018.
//

import Foundation

enum Direction: Int {
    case north
    case south
    case east
    case west
    
    var direction: Int {
        switch self {
        case .north, .east:
            return 1
        case .south, .west:
            return -1
        }
    }
}

let movements: [Direction] = [.north, .north, .west, .south, .west, .south, .south, .east, .east, .south, .east]

var location = (x: 0, y: 0)
location.x = movements.filter {$0 == .north || $0 == .south}.reduce(0) {$0 + $1.direction}
location.y = movements.filter {$0 == .east || $0 == .west}.reduce(0) {$0 + $1.direction}
