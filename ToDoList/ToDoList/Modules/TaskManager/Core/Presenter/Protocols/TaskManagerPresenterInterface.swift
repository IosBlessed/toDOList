//
//  TaskManagerPresenterInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
protocol TaskManagerPresenterInterface: AnyObject {
    var storage: StorageInterface { get set }
    func requestSections()
}
