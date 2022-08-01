//
//  BasketViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class BasketViewController: UIViewController{
    private var currentBusketCount = 0
    private lazy var myTabBarController = (tabBarController as! TabBarViewController)
    private lazy var backetView = BasketView(delegate: self)
    public var arrayOfPurchases : [SectionList] = []
    override func loadView() {
        super.loadView()
        view = backetView
    }
    func addToArray(sectionList : SectionList){
        let index = arrayOfPurchases.firstIndex { sectionListIt in
            sectionList.foodID == sectionListIt.foodID
        }
        
        if let index = index{
            var finalSectionList = SectionList(foodID: arrayOfPurchases[index].foodID, foodName: arrayOfPurchases[index].foodName, foodPrice: arrayOfPurchases[index].foodPrice, foodImage0: arrayOfPurchases[index].foodImage0, foodContent: arrayOfPurchases[index].foodContent, foodWeight: arrayOfPurchases[index].foodWeight, foodImage1: arrayOfPurchases[index].foodImage1, foodImage2: arrayOfPurchases[index].foodImage2, foodImage3: arrayOfPurchases[index].foodImage3)
            finalSectionList.count = 0
            if arrayOfPurchases[index].count <= 10{
                if arrayOfPurchases[index].count + sectionList.count <= 10{
                    finalSectionList.addAmountToCount(count: arrayOfPurchases[index].count + sectionList.count)
                }
                else{
                    finalSectionList.addAmountToCount(count: 10)
                }


            }
//            arrayOfPurchases[index].addAmountToCount(count: arrayOfPurchases[index].count + sectionList.count)
           
            
           
            arrayOfPurchases.append(finalSectionList)
            arrayOfPurchases.remove(at: index)
            
        }
        else{
            arrayOfPurchases.append(sectionList)
            
            currentBusketCount = currentBusketCount + 1
            myTabBarController.tabBar.items?[2].badgeValue = String(currentBusketCount)
            
            
            
        }
        backetView.toDeliveryScreenButton.isEnabled = true
        backetView.basketCollectionView.reloadData()
      
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGround()
        setDataSourceAndDelegate()
       
        
   
        
        

        // Do any additional setup after loading the view.
    }
    private func setBackGround(){
        if let image = UIImage(named: "back"){
            view.backgroundColor = UIColor(patternImage: image)
        }
        
    }
    private func setDataSourceAndDelegate(){
        backetView.basketCollectionView.dataSource = self
        backetView.basketCollectionView.delegate = self
    }
    @objc func deleteCell(sender : UIButton){
        let index = arrayOfPurchases.firstIndex { sectionList in
            sectionList.foodID == String(sender.tag)
        }
        if let index = index {
            arrayOfPurchases.remove(at: index)
            backetView.basketCollectionView.reloadData()
            currentBusketCount = currentBusketCount - 1
            myTabBarController.tabBar.items?[2].badgeValue = String(currentBusketCount)
            if (currentBusketCount == 0){
                myTabBarController.tabBar.items?[2].badgeValue = nil
                backetView.toDeliveryScreenButton.isEnabled = false
            }
            
            
            
        }
        
        
        
        
    
    
        
        
    }
    @objc func increase(sender : UIButton){
        let elementIndex = arrayOfPurchases.firstIndex { sect in
            sect.foodID == String(sender.tag)
        }
        if let elementIndex = elementIndex{
            
           
            arrayOfPurchases[elementIndex].plusCount()
            backetView.basketCollectionView.reloadData()
            
        }
        
        
    }
    @objc func decrease(sender : UIButton){
        let elementIndex = arrayOfPurchases.firstIndex { sect in
            sect.foodID == String(sender.tag)
        }
        if let elementIndex = elementIndex{
            
           
            arrayOfPurchases[elementIndex].minusFunc()
            backetView.basketCollectionView.reloadData()
            
        }

    }
//    func increaseAmount() {
//        dishView.sectionList?.plusCount()
//        setAllFieldsForControlCountView()
//
//
//
//
//
//
//    }
//
//    func decreaseAmount() {
//        dishView.sectionList?.minusFunc()
//        setAllFieldsForControlCountView()
//
//
//
//    }
//    private func setAllFieldsForControlCountView(){
//        dishView.controlAmountView.countLabel.text = String(dishView.sectionList?.count ?? -1)
//        dishView.price.text = dishView.sectionList?.currentPrice
//        dishView.weightLabel.text = dishView.sectionList?.currentWeight
//
//    }
    
    


}
extension BasketViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfPurchases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as! OrderCollectionViewCell
        cell.deleteFoodButton.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
        cell.controlAmountView.decreaseAmountButton.addTarget(self, action: #selector(decrease(sender:)), for: .touchUpInside)
        cell.controlAmountView.increaseAmountButton.addTarget(self, action: #selector(increase(sender:)), for: .touchUpInside)
//        print(indexPath.row)
        cell.setValues(sectionList: arrayOfPurchases[indexPath.row])
     
        return cell
    }
    
    
}
extension BasketViewController : BasketDelegate{
    func toDeliveryScreen() {
        let controller = DeliveryViewController()
        controller.backetViewBackDataDelegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func deleteFood() {
        print("food has been deleted")
    }
    
    
}
extension BasketViewController : BasketViewBackDataDelegate{
    func clearAllBasket() {
        arrayOfPurchases = []
        backetView.basketCollectionView.reloadData()
        backetView.toDeliveryScreenButton.isEnabled = false
        currentBusketCount = 0
        myTabBarController.tabBar.items?[2].badgeValue = nil
        
    }
    
    
}
