//
//  Model.swift
//  MultipleAPICalling
//
//  Created by Arpit iOS Dev. on 12/06/24.
//

import Foundation
import UIKit


// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let quote, author: String
    let category: String
    
}

typealias Welcome = [WelcomeElement]

// MARK: - Tags
struct Tags: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let query: String
    let tags: [String]
}


