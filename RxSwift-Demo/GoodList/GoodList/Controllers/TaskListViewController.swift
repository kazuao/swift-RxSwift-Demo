//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Kazunori Aoki on 2021/06/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private let disposeBag = DisposeBag()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard
            let navC = segue.destination as? UINavigationController,
            let addTVC = navC.viewControllers.first as? AddTaskViewController
        else {
            fatalError("AddTaskViewController is not found")
        }
        
        let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex - 1)
        
        // unowned: クロージャ内でアクセスするself変数がnilにならない場合
        // weak: クロージャ内でアクセスするself変数がnilになる可能性がある場合
        addTVC.taskSubjectObservable.subscribe(onNext: { [unowned self] task in
            
            var value = self.tasks.value
            value.append(task)
            self.tasks.accept(value)
            
            self.filterTasks(by: priority)
            
        }).disposed(by: disposeBag)
    }
    
    // MARK: Functions
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func filterTasks(by priority: Priority?) {
        
        if priority == nil {
            
            self.filteredTasks = self.tasks.value
            self.updateTableView()
            
        } else {
            
            // mapで配列内の全変数にアクセスする
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }
                
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
                
            }).disposed(by: disposeBag)
        }
    }
    
    // MARK: IBAction
    @IBAction func priorityValueChanged(_ sender: UISegmentedControl) {
        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
}

// MARK: UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") else {
            fatalError("cell is not found")
        }
        
        cell.textLabel?.text = filteredTasks[indexPath.row].title
        
        return cell
    }
}
