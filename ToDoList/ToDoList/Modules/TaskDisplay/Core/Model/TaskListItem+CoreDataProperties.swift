//
//  TaskListItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Никита Данилович on 16.05.2023.
//
//

import Foundation
import CoreData

extension TaskListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskListItem> {
        return NSFetchRequest<TaskListItem>(entityName: "TaskListItem")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var title: String
    @NSManaged public var subtitle: String?
    @NSManaged public var actionTime: Date
    @NSManaged public var indexOfPosition: Int16

}

extension TaskListItem: Identifiable {

}
