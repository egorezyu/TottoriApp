//
//  TabBarViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class TabBarViewController: UITabBarController {
//    lazy var countView : BadgeView = {
//        var countView  = BadgeView()
//        countView.translatesAutoresizingMaskIntoConstraints = false
//
//
//
//
//        return countView
//
//
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.addSubview(countView)
//        countView.bottomAnchor.constraint(equalTo: tabBar.topAnchor,constant: 39).isActive = true
//        countView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor,constant: (UIScreen.main.bounds.width / 3) + 14).isActive = true
//        countView.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        countView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        tabBar.itemSpacing = UIScreen.main.bounds.width / 3
        tabBar.tintColor = .red
        
        var image1 = UIImage(named: "union")?.withTintColor(.black,renderingMode: .alwaysOriginal)
        if let unImage1 = image1{
            image1 = UIImage.resizeImage(image: unImage1, targetSize: CGSize(width: 27, height: 27))
        }
        var image2 = UIImage(named: "mark")
        if let unImage2 = image2{
            image2 = UIImage.resizeImage(image: unImage2, targetSize: CGSize(width: 28, height: 28))
        }
        var image3 = UIImage(named: "Bag")
        if let unImage3 = image3{
            image3 = UIImage.resizeImage(image: unImage3, targetSize: CGSize(width: 34, height: 34))
        }
        

        
    
        let catalogVC = UINavigationController(rootViewController: CatalogViewController())
        let catalogVCTabBar = UITabBarItem(title: "",image: image1, tag: 1)
        catalogVC.tabBarItem = catalogVCTabBar
        
        
        let aboutUsVC =  AboutUsViewController()
        let aboutUsTabBar = UITabBarItem(title: "",image: image2, tag: 2)
        aboutUsVC.tabBarItem = aboutUsTabBar
        
        
        let basketVC = UINavigationController(rootViewController: BasketViewController())
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
