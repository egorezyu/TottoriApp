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
        viewModel.getMenuList { items in
            DispatchQueue.main.async {
                self.catalog = Catalog(status: true, menuList: items)
                self.catalogView.collectionView.reloadData()
                self.catalogView.secondCollectionView.reloadData()
                
            }
        }
        
    }

    @objc func doSequeToNextScreen(button : UIButton){
        let sectionList = catalog?.menuList[selectedIndex].sectionList?[button.tag]
        let dVC = DishViewController()
        dVC.sectionList = sectionList

        navigationController?.pushViewController(dVC, animated: true)

    }
    



}
extension CatalogViewController : CatalogViewDelegate{
    
}
extension CatalogViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == catalogView.collectionView{
            return catalog?.menuList.count ?? 0
        }
        return catalog?.menuList[selectedIndex].sectionList?.count ?? 0
        
        
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath) as! DishCollectionViewCell
        cell.setCellFields(sectionList: catalog?.menuList[selectedIndex].sectionList?[indexPath.row])
        cell.purchaseButton.tag = indexPath.row
        cell.purchaseButton.addTarget(self, action: #selector(doSequeToNextScreen(button:)), for: .touchUpInside)
        return cell
     
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == catalogView.collectionView{
            selectedIndex = indexPath.row
            
            catalogView.collectionView.reloadData()
            catalogView.secondCollectionView.reloadData()
        }
        
        
        
       
      
        
        
        
        
       

       
        
    }
    
    
    
    
}
