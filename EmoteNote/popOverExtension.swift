//
//  popOverExtension.swift
//  EmoteNote
//
//  Created by William Leahy on 7/19/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindowLevelAlert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
    
    func hide() {
        dismiss(animated: true, completion: nil)
    }
}
