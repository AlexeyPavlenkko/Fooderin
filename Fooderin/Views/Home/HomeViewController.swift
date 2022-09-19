//
//  HomeViewController.swift
//  Fooderin
//
//  Created by Алексей Павленко on 19.09.2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }
    

}

extension HomeViewController: Storyboarded {
    static var storyboardName: String {
        "Main"
    }
    
    static var identifier: String {
        "HomeViewController"
    }
}
