//
//  TabBarController.swift
//  UIActivityController
//
//  Created by Mikhail Chuparnov on 12.01.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  .systemGray6
        self.tabBar.tintColor = .systemTeal
        let vcArray = [
        setupTabBar(viewController: ActivityViewController(), title: "share", image: "square.and.arrow.up"),
        setupTabBar(viewController: PickerViewController(), title: "picker", image: "lock"),
        setupTabBar(viewController: TextFieldViewController(), title: "text", image: "character.cursor.ibeam")
        ]
        self.viewControllers = vcArray
    }

    
    private func setupTabBar(viewController: UIViewController, title: String, image: String) -> UIViewController {
        
        let vc = UINavigationController(rootViewController: viewController)
//        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(systemName: image)
        return vc
        
    }
}
