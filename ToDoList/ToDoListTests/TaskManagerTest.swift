//
//  TaskManagerTest.swift
//  ToDoListTests
//
//  Created by Никита Данилович on 18.05.2023.
//

import XCTest
@testable import ToDoList

final class TaskManagerPresenterTest: XCTestCase {
    
    var presenter: TaskManagerPresenterInterface!
    var mockView: MockTaskManagerView!
    var mockDataService: MockDataService!
    var task: TaskItem?
    
    override func setUp() {
        mockDataService = MockDataService(container: CoreDataStackTest.shared.persistentContainer)
        mockView = MockTaskManagerView()
        presenter = TaskManagerPresenter(view: mockView, dataService: mockDataService, task: task)
        mockView.presenter = presenter
        continueAfterFailure = false
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockDataService = nil
        task = nil
    }
    
    func testAddTask() {
        presenter.assignRoleToTaskManager()
        XCTAssertEqual(mockView.taskManagerGoal, .addTask, ToDoErrors.unableToAddTaskToStorage.rawValue)
        XCTAssertTrue(
            !mockDataService.taskIsAdded && mockDataService.manipulatedTask == nil,
            ToDoErrors.unabelToAddTaskToStorageTaskExists.rawValue
        )
        let taskTitle = "New Task"
        presenter.processTitleTextField(text: taskTitle)
        XCTAssertTrue(mockView.shouldNotHideAddButton, ToDoErrors.unableToProcessTextFieldIncorrectInput.rawValue)
        presenter.taskManagerButtonTapped(title: taskTitle, description: "some description")
        XCTAssertTrue(
            mockDataService.manipulatedTask != nil && mockDataService.taskIsAdded,
            ToDoErrors.unableToAddTaskToStorage.rawValue
        )
        print("✅ Test for adding task passed successfully!")
        task = nil
    }
    
    func testUpdateTask() {
        task = TaskItem(title: "Role for task manager")
        self.setUp()
        presenter.assignRoleToTaskManager()
        XCTAssertEqual(mockView.taskManagerGoal, .edit, ToDoErrors.unableToUpdateTask.rawValue)
        mockDataService.manipulatedTask = task
        let newTitle = "Task updated"
        presenter.processTitleTextField(text: newTitle)
        XCTAssertTrue(mockView.shouldNotHideAddButton, ToDoErrors.unableToProcessTextFieldIncorrectInput.rawValue)
        presenter.taskManagerButtonTapped(title: newTitle, description: "Test description")
        XCTAssertNotNil(mockDataService.manipulatedTask, ToDoErrors.unableToUpdateTask.rawValue)
        XCTAssertNotEqual(task, mockDataService.manipulatedTask, ToDoErrors.unableToUpdateTask.rawValue)
        print("✅ Test for updating task passed successfully!")
    }
}

final class MockTaskManagerView: TaskManagerViewControllerInterface {
    var presenter: ToDoList.TaskManagerPresenterInterface?
    var taskManagerGoal: TaskManagerGoal!
    var shouldNotHideAddButton: Bool!
    
    enum TaskManagerGoal {
        case edit
        case addTask
    }
    
    func initialViewSetup(
        title: String?,
        buttonIsHidden: Bool,
        buttonTitle: String?,
        taskTitle: String?,
        taskDescription: String?
    ) {
        taskManagerGoal = buttonIsHidden == true ? .addTask : .edit
    }
    
    func textFieldProcessed(with success: Bool) {
        shouldNotHideAddButton = success
    }
}
