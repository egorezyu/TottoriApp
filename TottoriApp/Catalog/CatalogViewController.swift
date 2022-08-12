//
//  ViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit




class CatalogViewController: UIViewController {
    
    
    private lazy var catalogView = CatalogView(subscriber: self)
    private lazy var viewModel = MenuListViewModel()
    private var header : HeaderForFavDishes!
    
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
    private func setBackButtonForNavBar(){
        let image = UIImage(named: "redBack")?.withTintColor(.red,renderingMode: .alwaysOriginal)
        if let image = image{
            let resizedImage = UIImage.resizeImage(image: image, targetSize: CGSize(width: 44, height: 20))?.withTintColor(.red,renderingMode: .alwaysOriginal)
            self.navigationController?.navigationBar.backIndicatorImage = resizedImage
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = resizedImage
            let backButton = UIBarButtonItem()
            backButton.title = "Назад"
            
            backButton.tintColor = .myLightGrey
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
        
        
        
        
        
        
        
    }
    private func setRowCount(){
        if let countMenu = catalog?.menuList.count,countMenu % 3 == 0{
            rowCount = countMenu / 3
            
        }
        else{
            rowCount = (catalog?.menuList.count ?? 0) / 3 + 1

           
        }
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
        viewModel.getMenuList { result in
            DispatchQueue.main.async {
                switch result{
                    
                case .success(let items):
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
                    self.setRowCount()
                    self.catalogView.collectionView.reloadData()
                    self.catalogView.secondCollectionView.reloadData()
                case .failure(let error):
                    self.present(UIAlertController.createAllert(text: error.localizedDescription), animated: true)
                }
                
                
            }
        }
        
    }

    @objc func doSequeToDishScreen(button : UIButton){

        
        var sectionList : SectionList?
        sectionList = catalog?.menuList[0].sectionList?.first(where: { sectionList in
            sectionList.foodID == String(button.tag)
        })
        
       
        
        let dVC = DishViewController()
        dVC.sectionList = sectionList

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
            return catalog?.menuList[section + 1].sectionList?.count ?? 0
        }
        else if collectionView == header.duplicateCollectionView{
            return catalog?.menuList.count ?? 0
        }
        return catalog?.menuDishes.count ?? 0
        
        
        
        
    }
    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == catalogView.collectionView{
            return 1
        }
        else if collectionView == catalogView.secondCollectionView{
            return (catalog?.menuList.count ?? 1) - 1
        }
        else if collectionView == header.duplicateCollectionView{
            return 1
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
                cell.contentView.backgroundColor = UIColor(red: 0.275, green: 0.29, blue: 0.31, alpha: 1)
            }
            return cell
        }
        else if collectionView == catalogView.secondCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath) as! DishCollectionViewCell
            cell.setCellFields(sectionList: catalog?.menuList[indexPath.section + 1].sectionList?[indexPath.row])
            cell.purchaseButton.tag = Int(catalog?.menuList[indexPath.section + 1].sectionList?[indexPath.row].foodID ?? "") ?? -1

            cell.purchaseButton.addTarget(self, action: #selector(doSequeToDishScreen(button:)), for: .touchUpInside)
            return cell
        }
        else if collectionView == header.favCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomFavouriteCell.id, for: indexPath) as! CustomFavouriteCell
            cell.configureCell(sectionList: catalog?.menuDishes[indexPath.row])
            
           
            cell.purchaseButton.tag = Int(catalog?.menuDishes[indexPath.row].foodID ?? "") ?? -1

            cell.purchaseButton.addTarget(self, action: #selector(doSequeToDishScreen(button:)), for: .touchUpInside)
            
            
            
            
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DuplicateCollectionViewCell.id, for: indexPath) as! DuplicateCollectionViewCell
            cell.setLabel(menuType: catalog?.menuList[indexPath.row].sectionName ?? "")
            if selectedFirstCollCellIndex != indexPath.row{
                cell.cleanEverything()
            }
            else{
                cell.contentView.layer.borderColor = UIColor.red.cgColor
            }
            
            return cell
        }
     
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == catalogView.collectionView{
            selectedFirstCollCellIndex = indexPath.row
            
            catalogView.collectionView.reloadData()
            header.duplicateCollectionView.reloadData()
            var indexP : IndexPath
            if selectedFirstCollCellIndex == 0{
                indexP = IndexPath(row: 0, section: 0)
                catalogView.secondCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            }
            else{
                indexP = IndexPath(row: 0, section: selectedFirstCollCellIndex - 1)
                catalogView.secondCollectionView.scrollToItem(at: indexP, at: .centeredVertically, animated: true)
            }
            
            
            

        }
        else if collectionView == header.duplicateCollectionView{
            selectedFirstCollCellIndex = indexPath.row
            
            catalogView.collectionView.reloadData()
            header.duplicateCollectionView.reloadData()
            
            var indexP : IndexPath
            if selectedFirstCollCellIndex == 0{
                indexP = IndexPath(row: 0, section: 0)
                catalogView.secondCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            }
            else{
                indexP = IndexPath(row: 0, section: selectedFirstCollCellIndex - 1)
                catalogView.secondCollectionView.scrollToItem(at: indexP, at: .centeredVertically, animated: true)
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
                    
                    headerCell.setRowCount(rowCount: rowCount)
                    
                    
                    headerCell.favCollectionView.dataSource = self
                    headerCell.favCollectionView.delegate = self
                    
                    headerCell.duplicateCollectionView.dataSource = self
                    headerCell.duplicateCollectionView.delegate = self
                    
                    headerCell.favCollectionView.decelerationRate = .fast


                   
                    headerCell.firstDishTitle.text = catalog?.menuList[1].sectionName
                    
                    self.header = headerCell
                    
                    
                    
                    
                   
                    
                    return headerCell
                }
                let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderForTitle.headerReuseIdentifier, for: indexPath) as! HeaderForTitle
                
               
                headerCell.textLabel.text = catalog?.menuList[indexPath.section + 1].sectionName
                return headerCell
                
                
                

                
                
                
               
                            
               

            
            default:
                assert(false, "Unexpected element kind")
            }
        }
        else{
            return UICollectionReusableView()
        }
        

        
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == catalogView.secondCollectionView{
            if section == 0{
                print(ReusavleViewDist.getSumWitoutCell() + CGFloat(ReusavleViewDist.collectionViewCellheigt * (catalog?.menuList.count ?? 0)))
                return CGSize(width: UIScreen.main.bounds.width, height: ReusavleViewDist.getSumWitoutCell() + CGFloat(ReusavleViewDist.collectionViewCellheigt * (rowCount)) + CGFloat(ReusavleViewDist.rowSpacing * rowCount) + 20)
            }
            
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 7)
        }
        else{
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    


    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ){
        

        
        if scrollView == header.favCollectionView{
            let currentIndex = (targetContentOffset.pointee.x / (UIScreen.main.bounds.width - 20)).rounded(.toNearestOrAwayFromZero)
            
            
            
            if currentIndex == 0{
                header.confirmStack(stack: header.hStack, j: 2)
                header.hStack.subviews[0].layer.borderColor = UIColor.red.cgColor
                header.hStack.subviews[1].layer.borderColor = UIColor.clear.cgColor
                header.hStack.subviews[2].layer.borderColor = UIColor.clear.cgColor
            }
            else if currentIndex == CGFloat((catalog?.menuDishes.count ?? -1) - 1){
                header.hStack.subviews[0].layer.borderColor = UIColor.clear.cgColor
                header.hStack.subviews[1].layer.borderColor = UIColor.clear.cgColor
                header.hStack.subviews[2].layer.borderColor = UIColor.red.cgColor
                
                header.confirmStack(stack: header.hStack, j: (catalog?.menuDishes.count ?? -1) - 1)
                
            }
            else {
                header.confirmStack(stack: header.hStack, j: Int(currentIndex) + 1)
                header.hStack.subviews[0].layer.borderColor = UIColor.clear.cgColor
                header.hStack.subviews[1].layer.borderColor = UIColor.red.cgColor
                header.hStack.subviews[2].layer.borderColor = UIColor.clear.cgColor
                
                
            }
        }
        
        

            

       

      
    }


        

    
    
    
    
}
