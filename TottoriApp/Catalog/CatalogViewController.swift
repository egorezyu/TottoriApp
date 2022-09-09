//
//  ViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit
import SwiftUI





class CatalogViewController: UIViewController , ViewControllerWithViewWithStack{
   
    
    
    
    private lazy var catalogView = CatalogView(subscriber: self)
    internal lazy var viewWithStack: ViewWithStack? = nil
    private lazy var viewModel = MenuListViewModel()
    private var header : HeaderForFavDishes!
    private var fullArrayOfDishes : [SectionList] = []
    
    private var currentVstackCellCount = 0
    private var selectedFirstCollCellIndex = 0
    
    private var rowCount : Int = 0
    
    
    



    private var catalog : Catalog?
    override func loadView() {
        super.loadView()
        view = catalogView
    }
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        
        setBackGround()
        setUpCollectionView()
        setBackButtonForNavBar()
        getData()
       
        

        
       
        

        
        
        
        
        

        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
  
    

        
    
    private func setUpCollectionView(){
        catalogView.collectionView.dataSource = self
        catalogView.collectionView.delegate = self
        catalogView.secondCollectionView.dataSource = self
        catalogView.secondCollectionView.delegate = self
        catalogView.secondCollectionView.register(HeaderForTitle.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderForTitle.headerReuseIdentifier)
        catalogView.secondCollectionView.register(HeaderForFavDishes.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderForFavDishes.headerReuseIdentifier)
        

        
    }
    private func getData(){
        catalogView.activityIndicator.startAnimating()
        viewModel.getMenuList { result in
            DispatchQueue.main.async {
                switch result{
                    
                case .success(let items):
                    self.fullArrayOfDishes = items.2
                    
                    self.catalog = Catalog(status: true, menuList: items.0, menuDishes: items.1)
                    
                    if let catalog = self.catalog {
                        if catalog.menuDishes.count < 3{
                            for i in 0...2{
                                let currentDish = catalog.menuList[0].sectionList?[i]
                                if let currentDish = currentDish{
                                    self.catalog?.menuDishes.append(MenuDish(foodID: currentDish.foodID, foodName: currentDish.foodName, foodPrice: currentDish.foodPrice, foodImage0: currentDish.foodImage0, foodContent: currentDish.foodContent))
                                }
                                
                            }
                        }
                    }
                   
                    self.catalogView.collectionView.reloadData()
                    self.catalogView.secondCollectionView.reloadData()
                case .failure(let error):
                    self.present(UIAlertController.createAllert(text: error.localizedDescription), animated: true)
                }
                self.catalogView.activityIndicator.stopAnimating()
                
                
            }
        }
        
    }
    

    @objc func doSequeToDishScreen(gesture : NSObject){
        
       
        let casted : TwoDimenIndex
        if gesture is UITapGestureRecognizer{
            let gestureCasted = gesture as! UITapGestureRecognizer
            casted = gestureCasted.view as! TwoDimenIndex
            
        }
        else{
            let buttonCasted = gesture as! ButtonWithIndexes
            casted = buttonCasted as TwoDimenIndex
        }

        var sectionList : SectionList?
        
        var sec = catalog?.menuList[casted.section].sectionList?[casted.index]
        sec?.count = 1
        sectionList = sec
        createAndInitDishViewController(sectionList: sectionList)

    }
    @objc func doSequeForNextScreenForButton(button : UIButton){
        var sectionList : SectionList?
        var arrayOfArrays : [[SectionList]] = []
        for item in catalog!.menuList{
            arrayOfArrays.append(item.sectionList ?? [])
            
        }
        sectionList = arrayOfArrays.joined().first(where: { element in
            element.foodID == String(button.tag)
        })
        createAndInitDishViewController(sectionList: sectionList)
        


    }
    @objc func increaseAmount(button : ButtonWithIndexes){

        catalog?.menuList[button.section].sectionList?[button.index].plusCount()
        let cell = catalogView.secondCollectionView.cellForItem(at: IndexPath(row: button.index, section: button.section)) as! DishCollectionViewCell
        cell.foodCountView.countLabel.text = String(catalog?.menuList[button.section].sectionList?[button.index].count ?? -1)

        
        
        
        
        
    }
    @objc func decreaseAmount(button : ButtonWithIndexes){
        
        catalog?.menuList[button.section].sectionList?[button.index].minusFunc()
        if catalog?.menuList[button.section].sectionList?[button.index].count == 0{
            catalog?.menuList[button.section].sectionList?[button.index].count = 1
        }
        let cell = catalogView.secondCollectionView.cellForItem(at: IndexPath(row: button.index, section: button.section)) as! DishCollectionViewCell
        cell.foodCountView.countLabel.text = String(catalog?.menuList[button.section].sectionList?[button.index].count ?? -1)

        
    }
    @objc func addToBasket(button : ButtonWithIndexes){
        let sectionList = catalog?.menuList[button.section].sectionList?[button.index]
        if let sectionList = sectionList{
            if let thirdScreen = (tabBarController?.viewControllers?[2] as? UINavigationController)?.viewControllers[0]{
                let screen = thirdScreen as! BasketViewController
               
                
               
                
             
                
                
                screen.addToArray(sectionList: sectionList)
//                catalog?.menuList[button.section].sectionList?[button.index].count = 1
//                let cell = catalogView.secondCollectionView.cellForItem(at: IndexPath(row: button.index, section: button.section)) as! DishCollectionViewCell
//                cell.foodCountView.countLabel.text = String(1)
                
            }
            showBasketAllert()
        }
   
        
        
    }
    private func createAndInitDishViewController(sectionList : SectionList?){
        let dVC = DishViewController()
        dVC.sectionList = sectionList
        if let sectionList = sectionList {
            if sectionList.isSecondWeight{
                let dishView =  dVC.view as! DishView
                dishView.addChevronToView()
            
                
            }
            
        }

        navigationController?.pushViewController(dVC, animated: true)
        
    }
    



}
extension CatalogViewController : CatalogViewDelegate{
    
}
extension CatalogViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == catalogView.collectionView{
            return catalog?.menuList.count ?? 0
        }
        else if collectionView == catalogView.secondCollectionView{
            return catalog?.menuList[section].sectionList?.count ?? 0
        }
        else {
            return catalog?.menuDishes.count ?? 0
        }
        
        
        
        
        
    }
    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == catalogView.collectionView{
            return 1
        }
        else if collectionView == catalogView.secondCollectionView{
            return (catalog?.menuList.count ?? 1)
        }
        else{
            return 1
        }
        
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == catalogView.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
            cell.setLabel(menuType: catalog?.menuList[indexPath.row].sectionName ?? "")
            if selectedFirstCollCellIndex != indexPath.row{
                cell.contentView.backgroundColor = .clear
            }
            else{
                cell.contentView.backgroundColor = .myLightGrey
            }
            return cell
        }
        //core of the app
        else if collectionView == catalogView.secondCollectionView{
            

            //configure upper scrollview accoarding user scrolling
            if collectionView.isDragging{
                
                
                
                selectedFirstCollCellIndex = indexPath.section
//                catalogView.collectionView.scrollToItem(at: IndexPath(row: indexPath.section, section: 0), at: .centeredHorizontally, animated: true)
                
                self.catalogView.collectionView.reloadData()

            }
            
           
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath) as! DishCollectionViewCell
            cell.setCellFields(sectionList: catalog?.menuList[indexPath.section].sectionList?[indexPath.row])
            //configure cell according to weight count
            if let sectionLis = catalog?.menuList[indexPath.section].sectionList?[indexPath.row]{
                if sectionLis.isSecondWeight{
                    
                    cell.addSecondWeightAndSetConstraints(sectionList: sectionLis)
                    
                    cell.removeDetailsView()
                }
                else{
                    cell.addDetailsView()
                    cell.detailsView.detailsButton.index = indexPath.row
                    cell.detailsView.detailsButton.section = indexPath.section
                    cell.detailsView.detailsButton.addTarget(self, action: #selector(doSequeToDishScreen(gesture:)), for: .touchUpInside)
                    cell.removeSecondWeight()
                }
            }
            //set start constraint
            if let boolValue = catalog?.menuList[indexPath.section].sectionList?[indexPath.row].isOnFirstWeight{
                if boolValue{
                    cell.constraint.constant = 20
                }
                else{
                    cell.constraint.constant = 60
                }
            }


            
            
            
            //set 2-d indexes for future navigation
            cell.detailsView.detailsLabel.index = indexPath.row
            cell.detailsView.detailsLabel.section = indexPath.section
            cell.foodType.index = indexPath.row
            cell.imageView.index = indexPath.row
            cell.foodType.section = indexPath.section
            cell.imageView.section = indexPath.section
            cell.firstWeight.index = indexPath.row
            cell.firstWeight.section = indexPath.section
            cell.secondWeight.index = indexPath.row
            cell.secondWeight.section = indexPath.section
            cell.purchaseButton.index = indexPath.row
            cell.purchaseButton.section = indexPath.section
            cell.foodCountView.increaseAmountButton.index = indexPath.row
            cell.foodCountView.increaseAmountButton.section = indexPath.section
            cell.foodCountView.decreaseAmountButton.index = indexPath.row
            cell.foodCountView.decreaseAmountButton.section = indexPath.section
            //all cell gestures
            let sequeGestureTextChevron = UITapGestureRecognizer(target: self, action: #selector(doSequeToDishScreen(gesture:)))
            let sequeGestureImage = UITapGestureRecognizer(target: self, action: #selector(doSequeToDishScreen(gesture:)))
            let sequeGestureText = UITapGestureRecognizer(target: self, action: #selector(doSequeToDishScreen(gesture:)))
            cell.foodType.addGestureRecognizer(sequeGestureText)
            cell.imageView.addGestureRecognizer(sequeGestureImage)
            cell.detailsView.detailsLabel.addGestureRecognizer(sequeGestureTextChevron)
            let firstTapGesture = UITapGestureRecognizer(target: self, action: #selector(firstWeightWasTapped(gesture:)))
            cell.firstWeight.addGestureRecognizer(firstTapGesture)
            let secondTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondWeightWasTapped(gesture:)))
            cell.secondWeight.addGestureRecognizer(secondTapGesture)
            cell.foodCountView.decreaseAmountButton.addTarget(self, action: #selector(decreaseAmount(button:)), for: .touchUpInside)
            cell.foodCountView.increaseAmountButton.addTarget(self, action: #selector(increaseAmount(button:)), for: .touchUpInside)
            cell.purchaseButton.addTarget(self, action: #selector(addToBasket(button:)), for: .touchUpInside)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomFavouriteCell.id, for: indexPath) as! CustomFavouriteCell
            cell.configureCell(sectionList: catalog?.menuDishes[indexPath.row])
            
           
            cell.purchaseButton.tag = Int(catalog?.menuDishes[indexPath.row].foodID ?? "") ?? -1

            cell.purchaseButton.addTarget(self, action: #selector(doSequeForNextScreenForButton(button:)), for: .touchUpInside)
            
          
            
            
            
            
            
            return cell
        }

     
        
        
    }
    @objc func firstWeightWasTapped(gesture : UITapGestureRecognizer){
        let casted = gesture.view as! TwoDimenIndex
        let currentCell = catalogView.secondCollectionView.cellForItem(at: IndexPath(item: casted.index, section: casted.section)) as! DishCollectionViewCell
        catalog?.menuList[casted.section].sectionList?[casted.index].isOnFirstWeight = true
        
        UIView.animate(withDuration: 0.2) {
            currentCell.constraint.constant = 20
            currentCell.secondWeight.price.textColor = .black
            currentCell.firstWeight.price.textColor = .red
            currentCell.layoutIfNeeded()
            
        }
        
       
        
        
    }
    @objc func secondWeightWasTapped(gesture : UITapGestureRecognizer){
        let casted = gesture.view as! TwoDimenIndex
        
        
       
        catalog?.menuList[casted.section].sectionList?[casted.index].isOnFirstWeight = false
      
        let currentCell = catalogView.secondCollectionView.cellForItem(at: IndexPath(item: casted.index, section: casted.section)) as! DishCollectionViewCell
        UIView.animate(withDuration: 0.2) {
            currentCell.constraint.constant = 60
            currentCell.secondWeight.price.textColor = .red
            currentCell.firstWeight.price.textColor = .black
            currentCell.layoutIfNeeded()
            
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == catalogView.collectionView{
            selectedFirstCollCellIndex = indexPath.row
            
            catalogView.collectionView.reloadData()
//            header.duplicateCollectionView.reloadData()
            var indexP : IndexPath
            if selectedFirstCollCellIndex == 0{
                indexP = IndexPath(row: 0, section: 0)
                catalogView.secondCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            }
            else{
                indexP = IndexPath(row: 0, section: selectedFirstCollCellIndex)
                catalogView.secondCollectionView.scrollToItem(at: indexP, at: .centeredVertically, animated: true)
            }
            
            
            

        }

        
        
        
        
       
      
        
        
        
        
       

       
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        if scrollView == catalogView.secondCollectionView{
            
            
            
            if catalogView.secondCollectionView.contentOffset.y == 0{

                selectedFirstCollCellIndex = 0
                catalogView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
                catalogView.collectionView.reloadData()

            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == catalogView.secondCollectionView{
            switch kind {

            case UICollectionView.elementKindSectionHeader:
                
                if indexPath.section == 0{
                   
                    let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderForFavDishes.headerReuseIdentifier, for: indexPath) as! HeaderForFavDishes
                    

                    
                    
                    headerCell.favCollectionView.dataSource = self
                    headerCell.favCollectionView.delegate = self

                    
//                    headerCell.duplicateCollectionView.dataSource = self
//                    headerCell.duplicateCollectionView.delegate = self
                    
                    headerCell.favCollectionView.decelerationRate = .fast


                   
                   
                    
                    self.header = headerCell
                    self.viewWithStack = header
                    
                    
                    
                    
                   
                    
                    return headerCell
                }
                let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderForTitle.headerReuseIdentifier, for: indexPath) as! HeaderForTitle
                
               
                headerCell.textLabel.text = catalog?.menuList[indexPath.section].sectionName
                return headerCell
                
                
                

                
                
                
               
                            
               

            
            default:
                assert(false, "Unexpected element kind")
            }
        }
        else{
            return UICollectionReusableView()
        }
        

        
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

     
        let indexPath = IndexPath(row: 0, section: section)
        _ = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        if section == 0{
            // Use this view to calculate the optimal size based on the collection view's width
            return CGSize(width: 0, height: UIScreen.main.bounds.height * 0.6)
        }
        else{
            return CGSize(width: 0, height: UIScreen.main.bounds.height / 12)
        }

     
    }
    

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize{
        if collectionView == catalogView.collectionView{
            return CGSize(width: ((UIScreen.main.bounds.width)) / 3, height: 48)
        }
        else if collectionView == catalogView.secondCollectionView{
            return CGSize(width: (UIScreen.main.bounds.width - 36) / 2, height: 350)
            
        }
        else if collectionView == header.favCollectionView{
            return CGSize(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height * 0.5)
        }
        else{
            return CGSize(width: (catalog?.menuList[indexPath.row].sectionName.count ?? 0) * 10 + 20, height: 50)
        }
        

        

    }
    
    


    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ){
       
        

        
        if scrollView == header.favCollectionView{
            

            if let array = catalog?.menuDishes{
                setPage(targetContentOffset: targetContentOffset, array: array)
            }
            
        }
        else if scrollView == catalogView.secondCollectionView{
            let arrayOfLay = catalogView.secondCollectionView.collectionViewLayout.layoutAttributesForElements(in: CGRect(x: 0, y: targetContentOffset.pointee.y, width: scrollView.frame.width, height: scrollView.frame.height))
            let path = arrayOfLay?[(arrayOfLay?.count ?? -1) - 1].indexPath
            


            catalogView.collectionView.scrollToItem(at: IndexPath(row: path?.section ?? -1, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        

            

       

      
    }


        

    
    
    
    
}
