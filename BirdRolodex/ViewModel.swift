//
//  ViewModel.swift
//  BirdRolodex
//
//  Created by Monisha Ravi on 9/27/21.
//

import Foundation

protocol Bird {
    var birdID: String { get }
    var birdName: String { get set } //when to use get versus set
    var imageURL: String { get } //should be these static
    var birdDescription: String { get }
    var verticalHeight: Int { get }
    var wingSpeed: Int { get }
    var canFly: Bool { get }
    var canSwim: Bool { get }
    var canSing: Bool { get }
    var canRun: Bool { get } //when to write init method
    
}
extension Bird {
    var canFly: Bool { self is Flyable }
    var canSwim: Bool { self is Swimmable }
    var canSing: Bool { self is Singable }
    var canRun: Bool { self is Runnable }
}

protocol Flyable { //protocols about abilities? or general ability protocol?
    var abilityID: String { get }
    var abilityName: String { get }
    var abilityDescription: String { get }
}
protocol Swimmable {
    var abilityID: String { get }
    var abilityName: String { get }
    var abilityDescription: String { get }
    
}
protocol Singable {
    var abilityID: String { get }
    var abilityName: String { get }
    var abilityDescription: String { get }
}
protocol Runnable {
    var abilityID: String { get }
    var abilityName: String { get }
    var abilityDescription: String { get }
}
struct Ostrich: Bird, Runnable { //how to map data, should this be getdata in viewcontroller or viewmodel what to put
    var canRun: Bool
    
    var canSing: Bool
    
    var canSwim: Bool
    
    var canFly: Bool
    
    var wingSpeed: Int
    
    var verticalHeight: Int
    
    var abilityName: String
    
    var abilityDescription: String
    
    var birdID: String
    
    var birdName: String
    
    var imageURL: String
    
    var birdDescription: String
    
    var abilityID: String
    
    
}
