//
//  BasketViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit


class BasketViewController: UIViewController{
    
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
                
                
                
            }
            
            
            
            
            arrayOfPurchases.append(finalSectionList)
            arrayOfPurchases.remove(at: index)
            
        }
        else{
            arrayOfPurchases.append(sectionList)
            
            currentBusketCount = currentBusketCount + 1
            
            
            
            
            
        }
        myTabBarController.tabBar.items?[2].badgeValue = String(getSum()) + " ₽"
        setSum()
        backetView.toDeliveryScreenButton.isEnabled = true
        backetView.basketCollectionView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isBeingPresented || self.isMovingToParent {
            animateCollectionView()
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGround()
        setDataSourceAndDelegate()
        setBackButtonForNavBar()
        navigationController?.delegate = self
        //        animateCollectionView()
        
        
        
        
        
        
        // Do any additional setup after loading the view.
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
            deleteCellProc(index: index)
            
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    @objc func increase(sender : ButtonWithIndexes){
        let elementIndex = arrayOfPurchases.firstIndex { sect in
            sect.foodID == String(sender.tag) && sect.isOnFirstWeight == Bool(truncating: sender.section as NSNumber)
        }
        if let elementIndex = elementIndex{
            
            arrayOfPurchases[elementIndex].plusCount()
            
            
            backetView.basketCollectionView.reloadData()
            setSum()
            myTabBarController.tabBar.items?[2].badgeValue = String(getSum()) + " ₽"
            
            
        }
        
        
    }
    private func deleteCellProc(index : Int){
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.backetView.basketCollectionView.cellForItem(at: IndexPath(row: index, section: 0))?.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        } completion: { _ in
            self.arrayOfPurchases.remove(at: index)
            self.backetView.basketCollectionView.cellForItem(at: IndexPath(row: index, section: 0))?.transform = .identity
            self.backetView.basketCollectionView.reloadData()
            self.currentBusketCount = self.currentBusketCount - 1
            if (self.currentBusketCount == 0){
                self.myTabBarController.tabBar.items?[2].badgeValue = nil
                self.backetView.toDeliveryScreenButton.isEnabled = false
            }
            self.setSum()
        }
        
        
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
            else{
                backetView.basketCollectionView.reloadData()
            }
            
            setSum()
            
            
            
            
            
            
            
        }
        
        
    }
    private func animateCollectionView(){
    
        let cells = backetView.basketCollectionView.visibleCells
        
        let tableViewHeight = backetView.basketCollectionView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 0.9, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
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
        backetView.setSum(text: "0 ₽")
        
    }
    
    
}
extension BasketViewController : UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push{
            return BookTransitionManager(duration: 0.8)
        }
        return nil
    }
    
    
    
    
    
}
