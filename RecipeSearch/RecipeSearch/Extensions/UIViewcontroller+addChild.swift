//
//  UIViewcontroller+addChild.swift
//  RecipeSearch
//
//  Created by Atef on 1/14/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
extension UIViewController {
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    
    
    
    func showAlert(message:String) {

        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            //run your function here
        }))

        self.present(alertController, animated: true, completion: nil)
    }
}


