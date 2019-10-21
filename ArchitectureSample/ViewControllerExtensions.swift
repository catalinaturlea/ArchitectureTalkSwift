//
//  ViewControllerExtensions.swift
//  ArchitectureSample
//
//  Created by Catalina Turlea on 16.10.19.
//  Copyright © 2019 Catalina Turlea. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(_ title: String, message: String? = nil, actionText: String? = "Ok", handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: actionText, style: .cancel, handler: handler)
        alertController.addAction(close)
        present(alertController, animated: true, completion: nil)
    }
}
