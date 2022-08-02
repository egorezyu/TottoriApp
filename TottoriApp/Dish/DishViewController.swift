//
//  DishViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import UIKit

class DishViewController: UIViewController {
    private lazy var dishView = DishView(subscriber: self)
    private lazy var currentChose = 0
//    private var prevChose : Int?
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
    func imageButtonTapped(sender: UIButton) {
        if sender.tag != currentChose{
            sender.layer.borderColor = UIColor.red.cgColor
            dishView.arrayOfNumbers[currentChose].layer.borderColor = UIColor.clear.cgColor
        }
        else{
            sender.layer.borderColor = UIColor.red.cgColor
        }
        currentChose = sender.tag
        setImageFunction()
        
        
    }
    
    func backButtonAction() {
        currentChose = currentChose - 1

        if (currentChose == -1){
            dishView.arrayOfNumbers[0].layer.borderColor = UIColor.clear.cgColor
            dishView.arrayOfNumbers[dishView.arrayOfNumbers.count - 1].layer.borderColor = UIColor.red.cgColor
            currentChose = dishView.arrayOfNumbers.count - 1
        }
        else{
            dishView.arrayOfNumbers[currentChose].layer.borderColor = UIColor.red.cgColor
            dishView.arrayOfNumbers[currentChose + 1].layer.borderColor = UIColor.clear.cgColor
        }
        setImageFunction()
    }
    
    func forwardButtonAction() {
        currentChose = currentChose + 1
        if (currentChose == dishView.arrayOfNumbers.count){
            dishView.arrayOfNumbers[dishView.arrayOfNumbers.count - 1].layer.borderColor = UIColor.clear.cgColor
            dishView.arrayOfNumbers[0].layer.borderColor = UIColor.red.cgColor
            currentChose = 0
        }
        else{
            dishView.arrayOfNumbers[currentChose].layer.borderColor = UIColor.red.cgColor
            dishView.arrayOfNumbers[currentChose - 1].layer.borderColor = UIColor.clear.cgColor
        }
        setImageFunction()
    }
    
    private func setImageFunction() {
        if let sectionList = sectionList {
            switch currentChose {
            case 0 :
                DataService.netWork.setImageFromUrl(url: sectionList.foodImage1, imageView: dishView.foodImage)
                
            case 1 :
                if let image = sectionList.foodImage2{
                    DataService.netWork.setImageFromUrl(url: image, imageView: dishView.foodImage)
                }
                else{
                    dishView.foodImage.image = UIImage(named: "tottori")
                }
                
            case 2 :
                if let image = sectionList.foodImage3{
                    DataService.netWork.setImageFromUrl(url: image, imageView: dishView.foodImage)
                }
                else{
                    dishView.foodImage.image = UIImage(named: "tottori")
                }
                
            default:
                return
                
            }
        }
    }
    
    
    func addToBasket() {
        if let sectionList = sectionList{
            let basketViewController = (tabBarController?.viewControllers?[2] as? UINavigationController)?.viewControllers[0]
            (basketViewController as? BasketViewController)?.addToArray(sectionList: sectionList)
//            dishView.sectionList = SectionList(foodID: sectionList.foodID, foodName: sectionList.foodName, foodPrice: sectionList.foodPrice, foodImage0: sectionList.foodImage0, foodContent: sectionList.foodContent, foodWeight: sectionList.foodWeight, foodImage1: sectionList.foodImage1, foodImage2: sectionList.foodImage2, foodImage3: sectionList.foodImage3)
//            setAllFieldsForControlCountView()
            navigationController?.popViewController(animated: true)
//            (navigationController?.navigationBar.subviews[2] as? UILabel)?.isHidden = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                (self.navigationController?.navigationBar.subviews[2] as? UILabel)?.isHidden = true
//            }
            
            
            
        }
        
    }
    
    func increaseAmount() {
        sectionList?.plusCount()
        setAllFieldsForControlCountView()
        
        
        
        
        
        
    }
    
    func decreaseAmount() {
        sectionList?.minusFunc()
        setAllFieldsForControlCountView()
       
        
        
    }
    private func setAllFieldsForControlCountView(){
        dishView.controlAmountView.countLabel.text = String(sectionList?.count ?? -1)
        dishView.priceView.genetrateLabel(text: sectionList?.formattedPrice ?? "", color: .red, font: UIFont(name: "FoglihtenNo06", size: CGFloat(UIScreen.main.bounds.width / 10.833)))
        dishView.weightView.genetrateLabel(text: sectionList?.formattedWeight ?? "", color: .black, font: UIFont(name: "FoglihtenNo06", size: CGFloat(UIScreen.main.bounds.width / 10.833)))
        
    }
    
}
