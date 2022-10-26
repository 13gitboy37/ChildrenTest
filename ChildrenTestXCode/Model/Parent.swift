//
//  Parent.swift
//  ChildrenTestXCode
//
//  Created by Никита Мошенцев on 26.10.2022.
//

import Foundation

struct Parent {
    var name: String
    var age: String
    var childrens: [Children]
}

struct Children {
    var name: String
    var age: String
    var id: Int
}
