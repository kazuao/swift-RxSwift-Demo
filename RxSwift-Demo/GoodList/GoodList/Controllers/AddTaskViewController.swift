//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Kazunori Aoki on 2021/06/28.
//

import Foundation
import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    // MARK: Properties
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    // MARK: IBAction
    @IBAction func tapSave(_ sender: UIButton) {
        
        guard
            let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex),
            let title = taskTitleTextField.text
        else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        
        dismiss(animated: true, completion: nil)
    }
}

