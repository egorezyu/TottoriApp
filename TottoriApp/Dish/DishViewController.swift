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
        print("hellow word")
    }
    
    func increaseAmount() {
        var currentCount : Int
        if let count = Int(dishView.controlAmountView.countLabel.text ?? "") {
            currentCount = count + 1
            dishView.controlAmountView.countLabel.text = String(currentCount)
            let price = Int(dishView.sectionList?.foodPrice ?? "") ?? 0
            let currentPrice = String(price * currentCount)
            
            dishView.price.text = currentPrice
            if let weight = Int(dishView.sectionList?.foodWeight ?? ""){
                dishView.weightLabel.text = String(weight * currentCount)
            }
            
            
            
        }
        
        
        
        
    }
    
    func decreaseAmount() {
        var currentCount : Int
        if let count = Int(dishView.controlAmountView.countLabel.text ?? "") {
            if count != 1{
                currentCount = count - 1
                dishView.controlAmountView.countLabel.text = String(currentCount)
                let price = Int(dishView.sectionList?.foodPrice ?? "") ?? 0
                let currentPrice = String(price * currentCount)
                
                dishView.price.text = currentPrice
                if let weight = Int(dishView.sectionList?.foodWeight ?? ""){
                    dishView.weightLabel.text = String(weight * currentCount)
                }
            }
           
            
            
        }
    }
    
    
}
