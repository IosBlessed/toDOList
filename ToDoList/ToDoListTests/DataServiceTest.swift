//
//  DataServiceTest.swift
//  ToDoListTests
//
//  Created by Никита Данилович on 22.05.2023.
//
import CoreData
import XCTest

@testable import ToDoList

final class DataServiceTest: XCTestCase {
    
    var dataService: DataServiceInterface!
    
    override func setUp() {
        dataService = DataService(persistentContainer: CoreDataStackTest.shared.persistentContainer)
        continueAfterFailure = false
    }
    
    override func tearDown() {
        dataService = nil
        CoreDataStackTest.shared.deleteAll()
    }
    
    func testAddTask() {
        let task = TaskItem(title: "Nikita test")
        dataService.addTaskToCoreData(task: task)
        let tasks = dataService.getCoreDataTasks()
        XCTAssertNotNil(tasks, ToDoErrors.unableToAddTaskToStorage.rawValue)
        print("✅ Test for adding task passed successfully!")
    }
    
    func testGetTasks() {
        [
            "Nikita first",
            "Nikita second"
        ]
            .map { TaskItem(title: $0) }
            .forEach { dataService.addTaskToCoreData(task: $0) }
        let tasks = dataService.getCoreDataTasks()
        XCTAssertNotNil(tasks, ToDoErrors.unableToExtractTasks.rawValue)
        XCTAssertEqual(tasks?.count, 2, ToDoErrors.unableToExtractTasks.rawValue)
        print("✅ Test for getting tasks passed successfully!")
    }
    
    func testDeleteTask() {
        let task = TaskItem(title: "Nikita first")
        dataService.addTaskToCoreData(task: task)
        XCTAssertNotNil(dataService.getCoreDataTasks(), ToDoErrors.unableToExtractTasks.rawValue)
        dataService.removeTask(task: task)
        XCTAssertTrue(dataService.getCoreDataTasks()!.isEmpty, ToDoErrors.taskDidNotDeleted.rawValue)
        print("✅ Test for deleting task passed successfully!")
    }
    
    func testToggleCompletedTask() {
        let task = TaskItem(title: "Nikita test")
        dataService.addTaskToCoreData(task: task)
        XCTAssertEqual(task.status, .active, ToDoErrors.unableToCheckTaskStatus.rawValue)
        dataService.changeStatusOfStoragedTask(for: task, with: .completed)
        XCTAssertFalse(dataService.getCoreDataTasks()!.first!.isActive, ToDoErrors.taskDidnotSwitchedStatus.rawValue)
        print("✅ Test for toggle task as completed passed successfully!")
    }
    
    func testUpdateTask() {
        let task = TaskItem(title: "Nikita before changes")
        dataService.addTaskToCoreData(task: task)
        XCTAssertNotNil(dataService.getCoreDataTasks(), ToDoErrors.unableToExtractTasks.rawValue)
        dataService.editTitleSubtitleTask(task: task, newTitle: "Nikita after changes", newDescription: nil)
        XCTAssertNotEqual(
            task.actionTime,
            dataService.getCoreDataTasks()!.first!.actionTime,
            ToDoErrors.unableToUpdateTask.rawValue
        )
        print("✅ Test for updating task passed successfully!")
    }
    
    func testRearrangeTask() {
        [
            "Nikita first",
            "Nikita second"
        ]
            .map { TaskItem(title: $0) }
            .forEach { dataService.addTaskToCoreData(task: $0) }
        XCTAssertNotNil(dataService.getCoreDataTasks(), ToDoErrors.unableToAddTaskToStorage.rawValue)
        let tasksBefore = dataService.getCoreDataTasks()!
        let source = 0
        let target = 1
        dataService.rearrangeCoreDataTasks(source: source, target: target)
        let tasksAfter = dataService.getCoreDataTasks()!
        XCTAssertEqual(tasksBefore[source].title, tasksAfter[target].title, ToDoErrors.taskDidNotSwapped.rawValue)
        print("✅ Test for rearranging task passed successfully!")
    }
    
    func testRassigningDate() {
        dataService.addTaskToCoreData(task: TaskItem(title: "First test"))
        XCTAssertNotNil(dataService.getCoreDataTasks(), ToDoErrors.unableToExtractTasks.rawValue)
        let task = dataService.getCoreDataTasks()!.first!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.dataService.reassignTaskActionDate()
            let reassignedTask = self.dataService.getCoreDataTasks()!.first!
            XCTAssertNotEqual(task.actionTime, reassignedTask.actionTime, ToDoErrors.unableToReassigneDateToTask.rawValue)
            print("✅ Test for rearranging date passed successfully!")
        }
    }
    
    func testGetSections() {
        let tasks = [
            "Nikita first",
            "Nikita second"
        ]
            .map { TaskItem(title: $0) }
        tasks.forEach { dataService.addTaskToCoreData(task: $0) }
        XCTAssertNotNil(dataService.getCoreDataTasks(), ToDoErrors.unableToExtractTasks.rawValue)
        let sections = dataService.getSections(for: tasks)
        XCTAssertFalse(sections.contains(.completed), ToDoErrors.unableToProcessSectionsForTasks.rawValue)
        XCTAssertTrue(sections.contains(.active), ToDoErrors.unableToProcessSectionsForTasks.rawValue)
        print("✅ Test for extractind sections passed successfully!")
    }
}
