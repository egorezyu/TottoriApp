//
//  AboutUsViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class AboutUsViewController: UIViewController {
    private lazy var aboutUsView = AboutUsView(delegate: self)
    
    override func loadView() {
        super.loadView()
        self.view = aboutUsView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackkGround()

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
extension AboutUsViewController : AboutUsDelegate{
    
}
