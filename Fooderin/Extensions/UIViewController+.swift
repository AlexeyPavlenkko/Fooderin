//
//  UIViewController+.swift
//  Fooderin
//
//  Created by Алексей Павленко on 22.09.2022.
//

import UIKit

extension UIViewController {
    func showErrorAlert(with errorMessage: String, completionAction: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "Something went wrong!", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: completionAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func showSuccessAlert(with message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true)
        }
    }
}
