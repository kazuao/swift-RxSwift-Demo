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
        
        // Modelに移動
//        guard
//            let url
//                = URL(string:
//                "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c6955cdeb0a845c2bd94d4dad349d14e")
//        else { return }
//
//        let resource = Resource<ArticleList>(url: url)
        
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
                
                guard let sSelf = self else { return }
                
                if let result = result {
                    sSelf.articles = result.articles
                    DispatchQueue.main.async {
                        sSelf.tableView.reloadData()
                    }
                }
            })
            .disposed(by: disposeBag)
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
