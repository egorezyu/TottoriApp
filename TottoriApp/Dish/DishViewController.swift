//
//  DishViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import UIKit

class DishViewController: UIViewController {
    private lazy var dishView = DishView(subscriber: self)
    private lazy var currentPhotoChoose = 0
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
    
    private func setValuesForView(){
        if let sectionList = sectionList {
            dishView.setValues(sectionList : sectionList)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
        if sender.tag != currentPhotoChoose{
            sender.layer.borderColor = UIColor.red.cgColor
            dishView.arrayOfNumbers[currentPhotoChoose].layer.borderColor = UIColor.clear.cgColor
        }
        else{
            sender.layer.borderColor = UIColor.red.cgColor
        }
        currentPhotoChoose = sender.tag
        setImageFunction()
        
        
    }
    
    func backButtonAction() {
        currentPhotoChoose = currentPhotoChoose - 1

        if (currentPhotoChoose == -1){
            dishView.arrayOfNumbers[0].layer.borderColor = UIColor.clear.cgColor
            dishView.arrayOfNumbers[dishView.arrayOfNumbers.count - 1].layer.borderColor = UIColor.red.cgColor
            currentPhotoChoose = dishView.arrayOfNumbers.count - 1
        }
        else{
            dishView.arrayOfNumbers[currentPhotoChoose].layer.borderColor = UIColor.red.cgColor
            dishView.arrayOfNumbers[currentPhotoChoose + 1].layer.borderColor = UIColor.clear.cgColor
        }
        setImageFunction()
    }
    
    func forwardButtonAction() {
        currentPhotoChoose = currentPhotoChoose + 1
        if (currentPhotoChoose == dishView.arrayOfNumbers.count){
            dishView.arrayOfNumbers[dishView.arrayOfNumbers.count - 1].layer.borderColor = UIColor.clear.cgColor
            dishView.arrayOfNumbers[0].layer.borderColor = UIColor.red.cgColor
            currentPhotoChoose = 0
        }
        else{
            dishView.arrayOfNumbers[currentPhotoChoose].layer.borderColor = UIColor.red.cgColor
            dishView.arrayOfNumbers[currentPhotoChoose - 1].layer.borderColor = UIColor.clear.cgColor
        }
        setImageFunction()
    }
    
    private func setImageFunction() {
        if let sectionList = sectionList {
            switch currentPhotoChoose {
            case 0 :
                NetworkManager.shared.setImageFromUrl(url: sectionList.foodImage1, imageView: dishView.foodImage,width: 200,aspectRatio: 1.5)
                
            case 1 :
                if let image = sectionList.foodImage2{
                    NetworkManager.shared.setImageFromUrl(url: image, imageView: dishView.foodImage,width: 200,aspectRatio: 1.5)
                }
                else{
                    dishView.foodImage.image = UIImage(named: "logo")
                }
                
            case 2 :
                if let image = sectionList.foodImage3{
                    NetworkManager.shared.setImageFromUrl(url: image, imageView: dishView.foodImage,width: 200,aspectRatio: 1.5)
                }
                else{
                    dishView.foodImage.image = UIImage(named: "logo")
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
            navigationController?.popViewController(animated: true)

            
            
            
        }
        
    }
    
    func increaseAmount() {
        sectionList?.plusCount()
        setAllFieldsForControlCountView()
        
        
        
        
        
        
    }
    
    func decreaseAmount() {
        sectionList?.minusFunc()
        if sectionList?.count == 0{
            sectionList?.count = 1
        }
        setAllFieldsForControlCountView()
       
        
        
    }
    private func setAllFieldsForControlCountView(){
        if let sectionList = sectionList{
            dishView.setPriceWeightNumber(sectionList: sectionList)
        }
        
    }
    
}
