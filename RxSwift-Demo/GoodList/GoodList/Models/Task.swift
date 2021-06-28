//
//  Task.swift
//  GoodList
//
//  Created by Kazunori Aoki on 2021/06/28.
//

import Foundation

enum Priority: Int {
    case hight
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
