//
//  MainViewPresenter.swift
//  ChildrenTestXCode
//
//  Created by Никита Мошенцев on 24.10.2022.
//

import UIKit

protocol MainCellDelegate {
    func addNameChildren(name: String, id: Int)
    func addAgeChildren(age: String, id: Int)
    func deleteRow(id: Int)
}

