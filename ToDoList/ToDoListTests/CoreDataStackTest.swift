//
//  CoreData.swift
//  ToDoListTests
//
//  Created by Никита Данилович on 18.05.2023.
//
import CoreData
import ToDoList

class CoreDataStackTest {
    
    static let shared = CoreDataStackTest()
    
    let persistentContainer: NSPersistentContainer!
    let persistentDescription: NSPersistentStoreDescription!
    let mainContext: NSManagedObjectContext!
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoList")
        persistentDescription = persistentContainer.persistentStoreDescriptions.first
        persistentDescription.type = NSInMemoryStoreType
        
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        print(persistentContainer.persistentStoreCoordinator.persistentStores)
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
    }
    
    func deleteAll() {
        do {
            let tasks = try persistentContainer.viewContext.fetch(TaskListItem.fetchRequest())
            for task in tasks {
                persistentContainer.viewContext.delete(task)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
