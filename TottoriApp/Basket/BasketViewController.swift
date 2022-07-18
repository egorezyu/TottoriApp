//
//  BasketViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class BasketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGround()
        
   
        
        

        // Do any additional setup after loading the view.
    }
    private func setBackGround(){
        if let image = UIImage(named: "back"){
            view.backgroundColor = UIColor(patternImage: image)
        }
        
    }
    
    


}

