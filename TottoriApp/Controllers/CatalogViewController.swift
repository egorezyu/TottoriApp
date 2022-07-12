//
//  ViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class CatalogViewController: UIViewController {
    private lazy var type = TypeCollectionView(frame: CGRect(x: 10, y: 0, width: view.frame.width - 20, height: view.frame.height / 4))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .backGroundColor
        view.addSubview(type)
       
        

        
        
        
        

        
    }



}

