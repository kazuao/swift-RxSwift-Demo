//
//  Article.swift
//  NewsApp-MVVM
//
//  Created by k-aoki on 2021/07/09.
//

import Foundation

struct Articles: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
}
