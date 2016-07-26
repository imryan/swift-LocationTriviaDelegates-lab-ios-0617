//
//  Location.swift
//  SwiftLocationTriviaDelegates
//
//  Created by Ryan Cohen on 7/26/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

import UIKit

class Location {
    
    var name: String
    var trivia: [Trivium]
    
    init(name: String, trivia: [Trivium]) {
        self.name = name
        self.trivia = trivia
    }
    
}

class Trivium {
    
    var content: String
    var likes: Int = 0
    
    init(content: String, likes: Int) {
        self.content = content
        self.likes = likes
    }
}