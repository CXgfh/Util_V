//
//  PresentDemoViewController.swift
//  Util_Example
//
//  Created by V on 2023/3/14.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import Util_V

class PresentDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        preferredContentSize = .init(width: 200, height: 300)
    }

}
