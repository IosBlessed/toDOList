//
//  AddTaskBuilder.swift
//  ToDoList
//
//  Created by Никита Данилович on 05.05.2023.
//

import UIKit

class AddTaskBuilder {
 
    static let shared = AddTaskBuilder()
    
    
    func buildAddTask() -> AddTaskViewController {
        
        let addTaskVC = AddTaskViewController(
            nibName: String(describing: AddTaskViewController.self),
            bundle: nil
        )
        
        return addTaskVC
    }
    
}
