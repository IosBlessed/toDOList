//
//  Localized.swift
//  ToDoList
//
//  Created by Никита Данилович on 16.05.2023.
//

import Foundation

struct TaskDisplayLocalization {
    static let navigationTitle = "task_display.navigation_bar.title.text".localized()
    static let navigationEditSectionTitle = "task_display.navigation_bar.edit_section.text".localized()
    static let tableViewActiveSectionTitle = "task_display.table_view.header_section.active.text".localized()
    static let tableViewCompletedSectionTitle = "task_display.table_view.header_section.completed.text".localized()
    static let tableViewActionRowAlertTitle = "task_display.delete_task_action.alert_title.text".localized()
    static let tableViewActionRowAlertMessage = "task_display.delete_task_action.alert_message.text".localized()
    static let tableViewActionRowAlertActionYes = "task_display.delete_task_action.alert_action_yes.text".localized()
    static let tableViewActionRowAlertActionNo = "task_display.delete_task_action.alert_action_no.text".localized()
}

struct TaskManagerLocalization {
    static let navigationAddTaskTitle = "task_manager.navigation_bar.add_task.text".localized()
    static let navigationEditTaskTitle = "task_manager.navigation_bar.edit_task.text".localized()
    static let navigationBackButtonTitle = "task_manager.navigation_bar.back_button.text".localized()
    static let titleTextFieldPlaceholder = "task_manager.text_field_title.placeholder.text".localized()
    static let descriptionTextFieldPlaceholder = "task_manager.text_field_description.placeholder.text".localized()
    static let addTaskButtonTitle = "task_manager.bottom_action_button.add_task.text".localized()
    static let editTaskButtonTitle = "task_manager.bottom_action_button.edit_task.text".localized()
}

