//
//  BasketViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class BasketViewController: UIViewController{
//    private var currentSum = 0
    private var currentBusketCount = 0
    private var maxCount = 10
    private lazy var myTabBarController = (tabBarController as! TabBarViewController)
    private lazy var backetView = BasketView(delegate: self)
    public var arrayOfPurchases : [SectionList] = []
    override func loadView() {
        super.loadView()
        view = backetView
    }
    func addToArray(sectionList : SectionList){
        let index = arrayOfPurchases.firstIndex { sectionListIt in
            print(sectionList == sectionListIt)
            return sectionList == sectionListIt
            
        }
        
        if let index = index{
            
            var finalSectionList = SectionList(foodWeight2: arrayOfPurchases[index].foodWeight2, foodPrice2: arrayOfPurchases[index].foodPrice2, foodID: arrayOfPurchases[index].foodID, foodName: arrayOfPurchases[index].foodName, foodPrice: arrayOfPurchases[index].foodPrice, foodImage0: arrayOfPurchases[index].foodImage0, foodContent: arrayOfPurchases[index].foodContent, foodWeight: arrayOfPurchases[index].foodWeight, foodImage1: arrayOfPurchases[index].foodImage1, foodImage2: arrayOfPurchases[index].foodImage2, foodImage3: arrayOfPurchases[index].foodImage3,isOnFirstWeight: arrayOfPurchases[index].isOnFirstWeight)
            finalSectionList.count = 0
            if arrayOfPurchases[index].count <= maxCount{
                if arrayOfPurchases[index].count + sectionList.count <= maxCount{
                    finalSectionList.addAmountToCount(count: arrayOfPurchases[index].count + sectionList.count)
                }
                else{
                    finalSectionList.addAmountToCount(count: maxCount)
                }
//                currentSum = currentSum + (finalSectionList.count * (Int(finalSectionList.foodPrice) ?? -1))


            }

           
            
           
            arrayOfPurchases.append(finalSectionList)
            arrayOfPurchases.remove(at: index)
            
        }
        else{
            arrayOfPurchases.append(sectionList)
            
            currentBusketCount = currentBusketCount + 1
//            myTabBarController.tabBar.items?[2].badgeValue = String(currentBusketCount)
//            currentSum = currentSum + (sectionList.count * (Int(sectionList.foodPrice) ?? -1))
            
            
            
            
        }
        myTabBarController.tabBar.items?[2].badgeValue = String(getSum()) + " ₽"
//        backetView.setSum(text: String(currentSum) + " ₽")
        setSum()
        backetView.toDeliveryScreenButton.isEnabled = true
        backetView.basketCollectionView.reloadData()
      
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGround()
        setDataSourceAndDelegate()
        setBackButtonForNavBar()
       
        
   
        
        

        // Do any additional setup after loading the view.
    }
    private func setBackButtonForNavBar(){
        let image = UIImage(named: "redBack")?.withTintColor(.red,renderingMode: .alwaysOriginal)
        if let image = image{
            let resizedImage = UIImage.resizeImage(image: image, targetSize: CGSize(width: 44, height: 20))?.withTintColor(.red,renderingMode: .alwaysOriginal)
            self.navigationController?.navigationBar.backIndicatorImage = resizedImage
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = resizedImage
            

            let backButton = UIBarButtonItem()
            backButton.title = NSLocalizedString("back", comment: "")
            backButton.tintColor = .myLightGrey
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
        
    }
    
    private func setDataSourceAndDelegate(){
        backetView.basketCollectionView.dataSource = self
        backetView.basketCollectionView.delegate = self
    }
    @objc func deleteCell(sender : ButtonWithIndexes){
        let index = arrayOfPurchases.firstIndex { sectionList in
            sectionList.foodID == String(sender.tag) && sectionList.isOnFirstWeight == Bool(truncating: sender.section as NSNumber)
        }
        if let index = index {
//            currentSum = currentSum - arrayOfPurchases[index].count * (Int(arrayOfPurchases[index].foodPrice) ?? -1)
//            backetView.setSum(text: String(currentSum) + " ₽")
            deleteCellProc(index: index)
            
            
            
            
        }
        
        
        
        
    
    
        
        
    }
    @objc func increase(sender : ButtonWithIndexes){
        let elementIndex = arrayOfPurchases.firstIndex { sect in
            sect.foodID == String(sender.tag) && sect.isOnFirstWeight == Bool(truncating: sender.section as NSNumber)
        }
        if let elementIndex = elementIndex{
            
            
           
           
//            if arrayOfPurchases[elementIndex].count < 10{
////                currentSum = currentSum + (Int(arrayOfPurchases[elementIndex].foodPrice) ?? -1)
////                backetView.setSum(text:String(currentSum) + " ₽")
//            }
            arrayOfPurchases[elementIndex].plusCount()
            
         
            backetView.basketCollectionView.reloadData()
            setSum()
            myTabBarController.tabBar.items?[2].badgeValue = String(getSum()) + " ₽"
            
            
        }
        
        
    }
    private func deleteCellProc(index : Int){
        arrayOfPurchases.remove(at: index)
        backetView.basketCollectionView.reloadData()
        currentBusketCount = currentBusketCount - 1
//        myTabBarController.tabBar.items?[2].badgeValue = String(getSum()) + " ₽"
        if (currentBusketCount == 0){
            myTabBarController.tabBar.items?[2].badgeValue = nil
            backetView.toDeliveryScreenButton.isEnabled = false
        }
        setSum()
    }
    private func setSum(){
        
        backetView.setSum(text: String(getSum()) + " ₽")
    }
    private func getSum() -> Int{
        var sum : Int = 0
        for item in arrayOfPurchases{
            sum = sum + item.sum
            
        }
        return sum
        
    }
    @objc func decrease(sender : ButtonWithIndexes){
        let elementIndex = arrayOfPurchases.firstIndex { sect in
            sect.foodID == String(sender.tag) && sect.isOnFirstWeight == Bool(truncating: sender.section as NSNumber)
        }
        if let elementIndex = elementIndex{
            arrayOfPurchases[elementIndex].minusFunc()
            

            myTabBarController.tabBar.items?[2].badgeValue = String(getSum()) + " ₽"
            if arrayOfPurchases[elementIndex].count == 0{
                deleteCellProc(index: elementIndex)
                
            }
            
            setSum()
            backetView.basketCollectionView.reloadData()
           
            
            
           
            
            
        }
        

    }
    

    
    


}
extension BasketViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfPurchases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as! OrderCollectionViewCell
        cell.deleteFoodButton.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
        cell.deleteFoodButton.section = arrayOfPurchases[indexPath.row].isOnFirstWeight ? 1 : 0
       
        
        
        cell.controlAmountView.decreaseAmountButton.addTarget(self, action: #selector(decrease(sender:)), for: .touchUpInside)
        cell.controlAmountView.decreaseAmountButton.section = arrayOfPurchases[indexPath.row].isOnFirstWeight ? 1 : 0
        cell.controlAmountView.increaseAmountButton.addTarget(self, action: #selector(increase(sender:)), for: .touchUpInside)
        cell.controlAmountView.increaseAmountButton.section = arrayOfPurchases[indexPath.row].isOnFirstWeight ? 1 : 0

        cell.setValues(sectionList: arrayOfPurchases[indexPath.row])
     
        return cell
    }
    
    
}
extension BasketViewController : BasketDelegate{
    func toDeliveryScreen() {
        let controller = DeliveryViewController()
        controller.backetViewBackDataDelegate = self
        controller.deliveryArray = arrayOfPurchases
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
//        currentSum = 0
        backetView.setSum(text: "0 ₽")
        
    }
    
    
}
