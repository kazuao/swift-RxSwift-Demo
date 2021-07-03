//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Kazunori Aoki on 2021/06/29.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.dataSource = self
        
        populateNews()
    }
    
    private func populateNews() {
        guard
            let url
                = URL(string:
                "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c6955cdeb0a845c2bd94d4dad349d14e")
        else { return }
        
        Observable.just(url)
            .flatMap { url -> Observable<Data> in
                
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
                
            }.map { data -> [Article]? in
                
                return try! JSONDecoder().decode(ArticleList.self, from: data).articles
                
            }.subscribe(onNext: { [weak self] articles in
                
                
                if let articles = articles {
                    self?.articles = articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
                
            }).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension NewsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell
                = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell")
                    as? ArticleTableViewCell
        else {
            fatalError("cell is not found")
        }
        
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        
        return cell
    }
}
