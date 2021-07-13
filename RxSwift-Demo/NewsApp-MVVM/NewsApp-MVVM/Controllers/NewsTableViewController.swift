//
//  NewsTableViewController.swift
//  NewsApp-MVVM
//
//  Created by k-aoki on 2021/07/09.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
}

private extension NewsTableViewController {
    
    func populateNews() {
        
        let resource = Resource<Articles>(url: URL(string:"https://newsapi.org/v2/top-headlines?country=jp&category=business&apiKey=c6955cdeb0a845c2bd94d4dad349d14e")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] articleResponse in
                
                guard let _self = self else { return }
                
                let articles = articleResponse.articles
                _self.articleListVM = ArticleListViewModel(articles)
                
                DispatchQueue.main.async {
                    _self.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDatasource
extension NewsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM == nil ? 0 : articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell",
                                                       for: indexPath) as? ArticleTableViewCell else {
            fatalError("cell is not found")
        }
        
        let articleVM = articleListVM.articleAt(indexPath.row)
        
        articleVM.title
            .asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description
            .asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
}
