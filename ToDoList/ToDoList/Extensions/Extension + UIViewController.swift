//
//  Extension + UIViewController.swift
//  ToDoList
//
//  Created by Никита Данилович on 11.05.2023.
//

import UIKit

extension UIViewController {
    
    enum AlertAction {
        case leave
        case delete
    }
    
    func alertMessage(
        title: String,
        message: String?,
        completion: @escaping (AlertAction) -> Void
    ) -> UIAlertController {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButtonOK = UIAlertAction(title: "YES", style: .destructive) { _ in
            completion(.delete)
        }
        let alertButtonClose = UIAlertAction(title: "NO", style: .cancel) { _ in
            completion(.leave)
        }
        alertViewController.addAction(alertButtonOK)
        alertViewController.addAction(alertButtonClose)
        return alertViewController
    }
}
