//
//  TabBarViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        let catalogVC = CatalogViewController()
        let catalogVCTabBar = UITabBarItem(title: "",image: UIImage(systemName: "rectangle.grid.2x2"), tag: 1)
        catalogVC.tabBarItem = catalogVCTabBar
        
        let aboutUsVC =  AboutUsViewController()
        let aboutUsTabBar = UITabBarItem(title: "",image: UIImage(systemName: "exclamationmark.circle"), tag: 1)
        aboutUsVC.tabBarItem = aboutUsTabBar
        
        let basketVC = BasketViewController()
        let basketVCTabBar = UITabBarItem(title: "", image: UIImage(systemName: "bag"), tag: 3)
        basketVC.tabBarItem = basketVCTabBar
        
        setViewControllers([catalogVC,aboutUsVC,basketVC], animated: true)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
