//
//  ViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit




class CatalogViewController: UIViewController {
    
    private var selectedIndex = 0
    private lazy var catalogView = CatalogView(subscriber: self)
    private lazy var viewModel = MenuListViewModel()
    private var header : MySecondHeaderClass!
    private var currentDish = 0
    private var currentVstackCellCount = 0
    
    



    private var catalog : Catalog?
    override func loadView() {
        super.loadView()
        view = catalogView
    }
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
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
            
//            if let font = UIFont(name: "Avenir-Book", size: 30) {
//                UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: font]
//            }
            let backButton = UIBarButtonItem()
            backButton.title = "Назад"
            
            backButton.tintColor = .myLightGrey
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
        
        
        
        
        
        
        
    }
   
    private func setBackGround(){
        if let image = UIImage(named: "back"){
            view.backgroundColor = UIColor(patternImage: image)
        }
        
    }
    private func setNavigationBar(){
//        let backImage = UIImage(named: "purchase")
//        self.navigationController?.navigationBar.backIndicatorImage?.withTintColor(.red,renderingMode: .alwaysOriginal)
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage?.withTintColor(.red,renderingMode: .alwaysOriginal)
        
//        self.navigationController?.navigationBar.backItem?.title = "Назад"
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Заказ добавлен в корзину"
//        label.isHidden = true
//        label.textColor = .red
//        if let navigationBar = navigationController?.navigationBar{
//            navigationBar.addSubview(label)
//            label.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
//            label.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
//        }
        
    }
    private func setUpCollectionView(){
        catalogView.collectionView.dataSource = self
        catalogView.collectionView.delegate = self
        catalogView.secondCollectionView.dataSource = self
        catalogView.secondCollectionView.delegate = self
        catalogView.secondCollectionView.register(MyHeaderClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyHeaderClass.headerReuseIdentifier)
        catalogView.secondCollectionView.register(MySecondHeaderClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MySecondHeaderClass.headerReuseIdentifier)
        

        
    }
    private func getData(){
//        DataService.netWork.getData(url: "http://tottori.fixmaski.ru/api/getSubMenuDelivery.php", method: "GET", comletion: { result in
//            switch result{
//
//            case .success(let catalog):
//                DispatchQueue.main.async {
//                    do{
//                        let decodedCatalog = try JSONDecoder().decode(Catalog.self, from: catalog)
//                        self.catalog = decodedCatalog
//                        self.catalogView.collectionView.reloadData()
//                        self.catalogView.secondCollectionView.reloadData()
//                    }
//                    catch{
//                        print(error)
//                    }
//
//
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
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
                    self.catalogView.collectionView.reloadData()
                    self.catalogView.secondCollectionView.reloadData()
                case .failure(let error):
                    self.present(UIAlertController.createAllert(text: error.localizedDescription), animated: true)
                }
                
                
            }
        }
        
    }

    @objc func doSequeToNextScreen(button : UIButton){
//        print(selectedIndex - 1)
//        print(button.tag)
        print(button.tag)
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
        return catalog?.menuDishes.count ?? 0
        
        
        
        
    }
    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == catalogView.collectionView{
            return 1
        }
        else if collectionView == catalogView.secondCollectionView{
            return (catalog?.menuList.count ?? 1) - 1
        }
        else{
            return 1
        }
        
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == catalogView.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
            cell.setLabel(menuType: catalog?.menuList[indexPath.row].sectionName ?? "")
            if selectedIndex != indexPath.row{
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
    //        print(indexPath.row)
            cell.purchaseButton.addTarget(self, action: #selector(doSequeToNextScreen(button:)), for: .touchUpInside)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomFavouriteCell.id, for: indexPath) as! CustomFavouriteCell
            cell.configureCell(sectionList: catalog?.menuDishes[indexPath.row])
            
           
            cell.purchaseButton.tag = Int(catalog?.menuDishes[indexPath.row].foodID ?? "") ?? -1
    //        print(indexPath.row)
            cell.purchaseButton.addTarget(self, action: #selector(doSequeToNextScreen(button:)), for: .touchUpInside)
            
            
            
            
            
            return cell
        }
     
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == catalogView.collectionView{
            selectedIndex = indexPath.row
            
            catalogView.collectionView.reloadData()
            var indexP : IndexPath
            if selectedIndex == 0{
                indexP = IndexPath(row: 0, section: 0)
                catalogView.secondCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            }
            else{
                indexP = IndexPath(row: 0, section: selectedIndex - 1)
                catalogView.secondCollectionView.scrollToItem(at: indexP, at: .centeredVertically, animated: true)
            }
            
            
            
//            catalogView.secondCollectionView.scrollRectToVisible(CGRect(x: 5, y: 5, width: 100, height: 100), animated: true)
//            catalogView.secondCollectionView.reloadData()
        }
        
        
        
        
       
      
        
        
        
        
       

       
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == catalogView.secondCollectionView{
            switch kind {

            case UICollectionView.elementKindSectionHeader:
                
                if indexPath.section == 0{
                   
                    let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MySecondHeaderClass.headerReuseIdentifier, for: indexPath) as! MySecondHeaderClass
                    headerCell.favCollectionView.dataSource = self
                    headerCell.favCollectionView.delegate = self
//                    headerCell.favCollectionView.decelerationRate = .fast
                    headerCell.favCollectionView.decelerationRate = .init(rawValue: 0.9)

                   
                    headerCell.firstDishTitle.text = catalog?.menuList[1].sectionName
                    
                    self.header = headerCell
                    
                    
                    
                    
                   
                    
                    return headerCell
                }
                let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyHeaderClass.headerReuseIdentifier, for: indexPath) as! MyHeaderClass
                
               
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
    
    // Width doesn't matter because scroll is vertical. Only height used.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == catalogView.secondCollectionView{
            if section == 0{
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
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
        
        print(targetContentOffset.pointee.x)
        print(UIScreen.main.bounds.width - 20)
        
        print(Int(targetContentOffset.pointee.x / (UIScreen.main.bounds.width - 20)))
        
        

            

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

//
        
//        
    }


        

    
    
    
    
}
