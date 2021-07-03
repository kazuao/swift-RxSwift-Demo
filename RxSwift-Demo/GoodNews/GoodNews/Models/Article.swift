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

extension ArticleList {
    
    static var all: Resource<ArticleList> = {
       let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c6955cdeb0a845c2bd94d4dad349d14e")!
        return Resource(url: url)
    }()
}

struct Article: Codable {
    let title: String
    let description: String?
}
