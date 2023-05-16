//
//  Extension+String.swift
//  ToDoList
//
//  Created by Никита Данилович on 16.05.2023.
//

import Foundation

extension String {
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "***Unknown***", comment: "")
    }
}
