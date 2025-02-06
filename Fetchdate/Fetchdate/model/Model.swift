//
//  Model.swift
//  Fetchdate
//
//  Created by Sirarpi Bayramyan on 06.02.25.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: Int
    var title: String
    var userId: Int
}

struct User: Identifiable, Codable {
    var id: Int
    var name: String
}
