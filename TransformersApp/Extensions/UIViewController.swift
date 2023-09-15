//
//  UIViewController.swift
//  TransformersApp
//
//  Created by capregsoft on 15/09/2023.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlertWithOkButton(message:String = "Something went wrong.Please try later."){
        let alert = UIAlertController(title: "Transformers", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
}
