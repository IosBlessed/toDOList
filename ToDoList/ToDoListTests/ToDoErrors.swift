//
//  ToDoErrors.swift
//  ToDoList
//
//  Created by Никита Данилович on 17.05.2023.
//

import Foundation

enum ToDoErrors: String, Error {
    case titleOfTaskCannotBeEmpty
    case titleOfTaskCannotHasLessThan2Symbols
    case unableToAddTaskToStorage
    case unableToExtractTasks
    case unableToUpdateTask
    case unableToGetElementByIndex
    case taskDidnotSwitchedStatus
    case taskDidNotSwapped
    case taskDidNotDeleted
    case unableToSwitchtableViewInEditingMode
    case unableToProcessTableViewBackgroundImage
    case unableToDeleteTaskDoesntExtists
    case unableToAddTaskTitleHasProblem
    case unabelToAddTaskToStorageTaskAlreadyExists
    case unableToDeleteTaskInteractionError
}
