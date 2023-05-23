//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Никита Данилович on 17.05.2023.
//
import CoreData
import XCTest
@testable import ToDoList

final class TaskDisplayPresenterTest: XCTestCase {

    private var presenter: TaskDisplayPresenterInterface!
    private var mockView: MockTaskDisplayView!
    private var mockDataService: MockDataService!

    override func setUp() {
        super.setUp()
        mockDataService = MockDataService(container: CoreDataStackTest.shared.persistentContainer)
        mockView = MockTaskDisplayView()
        presenter = TaskDisplayPresenter(
            viewController: mockView,
            dataService: mockDataService
        )
        mockView.presenter = presenter
        continueAfterFailure = false
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockDataService = nil
    }

    func testGetTasks() {
        mockDataService.generateManipulatedTasks()
        presenter.requestDataFromStorage()
        XCTAssertNotNil(mockView.tasks, ToDoErrors.unableToExtractTasks.rawValue)
        print("✅ Test for getting tasks passed successfully!")
    }
    
    func testDeleteTask() {
        mockDataService.manipulatedTask = TaskItem(title: "test for removal")
        XCTAssertNotNil(mockDataService.manipulatedTask, ToDoErrors.unableToDeleteTaskDoesntExtists.rawValue)
        presenter.processTaskRowUserAction(for: mockDataService.manipulatedTask, action: .deleteTask)
        XCTAssertNil(mockDataService.manipulatedTask, ToDoErrors.taskDidNotDeleted.rawValue)
        print("✅ Test for removing tasks passed successfully!")
    }
    func testRearrangeTask() {
        mockDataService.generateManipulatedTasks()
        presenter.requestDataFromStorage()
        let arrayBeforeSwap = mockView.tasks
        let sourceIndexRow = 0
        let targetIndexRow = 1
        presenter.processSwitchingTask(
            source: IndexPath(row: sourceIndexRow, section: 0),
            destination: IndexPath(row: targetIndexRow, section: 0)
        )
        let arrayAfterSwap = mockView.tasks
        let movedToTargetIndex = arrayBeforeSwap[sourceIndexRow] == arrayAfterSwap[targetIndexRow]
        let movedToSourceIndex = arrayBeforeSwap[targetIndexRow] == arrayAfterSwap[sourceIndexRow]
        XCTAssertTrue(movedToTargetIndex && movedToSourceIndex, ToDoErrors.taskDidNotSwapped.rawValue)
        print("✅ Test for rearrange task passed successfully!")
    }
    
    func testToggleTaskAsCompleted() {
        mockDataService.manipulatedTask = TaskItem(title: "Nikita test")
        let previousStatus = mockDataService.manipulatedTask.status
        presenter.processTaskRowUserAction(for: mockDataService.manipulatedTask, action: .switchStatus)
        let changedStatus = mockDataService.manipulatedTask.status
        XCTAssertNotEqual(previousStatus, changedStatus, ToDoErrors.taskDidnotSwitchedStatus.rawValue)
        print("✅ Test for toggle task's statuc passed successfully!")
    }
    
    func testShowTableViewBackgroundImage() {
        mockDataService.tasks = []
        presenter.requestDataFromStorage()
        XCTAssertTrue(mockView.shouldShowBackgroundImage, ToDoErrors.unableToProcessTableViewBackgroundImage.rawValue)
        print("✅ Test for showing background image if tasks are empty passed successfully!")
    }
    func testTableViewEditingMode() {
        presenter.editTableViewButtonTapped(with: false)
        XCTAssertTrue(mockView.shouldSwitchTableViewEditingMode, ToDoErrors.unableToSwitchtableViewInEditingMode.rawValue)
    }
}

final class MockTaskDisplayView: TaskDisplayViewControllerInterface {
    var presenter: ToDoList.TaskDisplayPresenterInterface?

    var tasks = [TaskItem]()
    var shouldSwitchTableViewEditingMode: Bool = false
    var shouldShowBackgroundImage: Bool = false

    func updateTasksList(tasks: [ToDoList.TaskItem], sections: [ToDoList.TaskStatus]) {
        self.tasks = tasks
    }

    func showTableViewBackgroundImage(with isHidden: Bool) {
        shouldShowBackgroundImage = isHidden
    }

    func setTableViewToEditingMode(perform status: Bool) {
        self.shouldSwitchTableViewEditingMode = status
    }
}

final class MockDataService: DataServiceInterface {
    
    private let persistentContainer: NSPersistentContainer!
    private let context: NSManagedObjectContext!
    var tasks: [TaskListItem]?
    var manipulatedTask: TaskItem!
    var taskIsAdded: Bool = false
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.context = container.viewContext
    }
    
    func addTaskToCoreData(task: TaskItem) {
        taskIsAdded = true
        manipulatedTask = task
    }
    
    func getCoreDataTasks() -> [ToDoList.TaskListItem]? {
        return tasks
    }
    
    func getSections(for tasks: [ToDoList.TaskItem]) -> [ToDoList.TaskStatus] {
        var sections: [TaskStatus] = []
        for status in TaskStatus.allCases {
            if tasks.contains(where: { $0.status == status }) {
                sections.append(status)
            }
        }
        return sections
    }
    
    func changeStatusOfStoragedTask(for task: ToDoList.TaskItem, with newStatus: ToDoList.TaskStatus) {
        self.manipulatedTask.status = newStatus
    }
    
    func removeTask(task: ToDoList.TaskItem) {
       manipulatedTask = nil
    }
    
    func editTitleSubtitleTask(task: ToDoList.TaskItem, newTitle: String, newDescription: String?) {
        manipulatedTask.title = newTitle
        manipulatedTask.description = newDescription
        manipulatedTask.actionTime = Date()
    }
    
    func rearrangeCoreDataTasks(source: Int, target: Int) {
        tasks?.swapAt(source, target)
    }
    
    func reassignTaskActionDate() {
    }
    
    func generateManipulatedTasks() {
        self.tasks = [
            "First task",
            "Second task"
        ].map { title in
            let entityName = String(describing: TaskListItem.self)
            let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self.context)!
            let task = TaskListItem(entity: entityDescription, insertInto: nil)
            task.title = title
            task.subtitle = nil
            task.isActive = true
            task.actionTime = Date()
            return task
        }
    }
}
