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
        
        
        
        
        tabBar.tintColor = .red
        tabBar.backgroundImage = UIImage(named: "back")
//        tabBar.backgroundColor = .clear
//        let appearance = UITabBarAppearance()
//
//        tabBar.scrollEdgeAppearance = appearance
        
        

        
        let image1 = UIImage(named: "union")?.withTintColor(UIColor(red: 0.553, green: 0.545, blue: 0.549, alpha: 1),renderingMode:.automatic)

        let image2 = UIImage(named: "mark")?.withTintColor(UIColor(red: 0.553, green: 0.545, blue: 0.549, alpha: 1),renderingMode:.automatic)

        let image3 = UIImage(named: "purchase")?.withTintColor(UIColor(red: 0.553, green: 0.545, blue: 0.549, alpha: 1),renderingMode:.automatic)
        
        let back = UIImage(named: "back")
        

        
        let catalogVC = UINavigationController(rootViewController: CatalogViewController())
        catalogVC.navigationBar.setBackgroundImage(back, for: .default)
        

        
        let catalogVCTabBar = UITabBarItem(title: "",image: image1, tag: 1)
        catalogVC.tabBarItem = catalogVCTabBar
        
        let aboutUsVC =  UINavigationController(rootViewController : AboutUsViewController())
        
        
        
        let aboutUsTabBar = UITabBarItem(title: "",image: image2, tag: 2)
        aboutUsVC.tabBarItem = aboutUsTabBar
        
        let basketVC = UINavigationController(rootViewController: BasketViewController())
        
        basketVC.navigationBar.setBackgroundImage(back, for: .default)
        let basketVCTabBar = UITabBarItem(title: "", image: image3, tag: 3)
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
