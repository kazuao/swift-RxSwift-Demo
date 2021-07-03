//
//  Article.swift
//  GoodNews
//
//  Created by Kazunori Aoki on 2021/06/30.
//

import Foundation

struct ArticleList: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String
}
