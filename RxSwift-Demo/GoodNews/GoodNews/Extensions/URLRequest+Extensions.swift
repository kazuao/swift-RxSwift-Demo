//
//  URLRequest+Extensions.swift
//  GoodNews
//
//  Created by Kazunori Aoki on 2021/07/01.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        
    }
}
