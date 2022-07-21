//
//  DishViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import UIKit

class DishViewController: UIViewController {
    private lazy var dishView = DishView(subscriber: self)
    var sectionList : SectionList?
    
    override func loadView() {
        super.loadView()
        setValuesForView()
        view = dishView
    }

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
    private func setValuesForView(){
        if let sectionList = sectionList {
            dishView.setValues(sectionList : sectionList)
        }
        
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
extension DishViewController : DishDelegate{
    func addToBasket() {
        if let sectionList = dishView.sectionList{
            (tabBarController?.viewControllers?[2] as? BasketViewController)?.addToArray(sectionList: sectionList)
        }
        
    }
    
    func increaseAmount() {
        dishView.sectionList?.plusCount()
        setAllFieldsForControlCountView()
        
        
        
        
        
        
    }
    
    func decreaseAmount() {
        dishView.sectionList?.minusFunc()
        setAllFieldsForControlCountView()
       
        
        
    }
    private func setAllFieldsForControlCountView(){
        dishView.controlAmountView.countLabel.text = String(dishView.sectionList?.count ?? -1)
        dishView.priceView.price.text = dishView.sectionList?.currentPrice
        dishView.weightView.weightLabel.text = dishView.sectionList?.currentWeight
        
    }
    
}
