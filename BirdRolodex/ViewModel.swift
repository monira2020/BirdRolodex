//
//  ViewModel.swift
//  BirdRolodex
//
//  Created by Monisha Ravi on 9/27/21.
//

import Foundation

protocol Bird {
    var birdID: String { get }
    var birdName: String { get set }
    var imageURL: String { get }
    var birdDescription: String { get }
    
}
extension Bird {
    var canFly: Bool { self is Flyable }
    var canSwim: Bool { self is Swimmable }
    var canSing: Bool { self is Singable }
    var canRun: Bool { self is Runnable }
}

protocol Flyable {
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
struct Ostrich: Bird, Runnable {
    var abilityName: String
    
    var abilityDescription: String
    
    var birdID: String
    
    var birdName: String
    
    var imageURL: String
    
    var birdDescription: String
    
    var abilityID: String
    
    
}
