//
//  ViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class CatalogViewController: UIViewController {
    
    private var selectedIndex = 1
    private lazy var catalogView = CatalogView(subscriber: self)
    private var menyTypes : [String] = []
    private var dishes : [Dish] = []
    override func loadView() {
        super.loadView()
        view = catalogView
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        setBackGround()
        setUpCollectionView()
        setNavigationBar()
        getMockData()
       
        

        
       
        

        
        
        
        
        

        
    }
    private func setBackGround(){
        if let image = UIImage(named: "back"){
            view.backgroundColor = UIColor(patternImage: image)
        }
        
    }
    private func setNavigationBar(){
//        let backImage = UIImage(named: "purchase")
        self.navigationController?.navigationBar.backIndicatorImage?.withTintColor(.red,renderingMode: .alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage?.withTintColor(.red,renderingMode: .alwaysOriginal)
//        self.navigationController?.navigationBar.backItem?.title = "Назад"
    }
    private func setUpCollectionView(){
        catalogView.collectionView.dataSource = self
        catalogView.collectionView.delegate = self
        catalogView.secondCollectionView.dataSource = self
        catalogView.secondCollectionView.delegate = self
    }
    private func getMockData(){
        NetworkManager.netWork.getDataFromApi { result in
            switch result{
                
            case .success(let typeArray):
                DispatchQueue.main.async {
                    self.menyTypes = typeArray
                    self.getDishesByMenu(menuType: self.menyTypes[1])
                    self.catalogView.collectionView.reloadData()
                }
            case .failure(_):
                print("")
            }
        }
        
    }
    private func getDishesByMenu(menuType : String){
        NetworkManager.netWork.getDataFromMenuType(menuType: menuType) { result in
            switch result{
                
            case .success(let dishes):
                DispatchQueue.main.async {[weak self] in
                    self?.dishes = dishes
                    self?.catalogView.secondCollectionView.reloadData()
                }
            case .failure(_):
                print("")
            }
        }
    }
    @objc func doSequeToNextScreen(button : UIButton){
        let dish = dishes[button.tag]
        let dVC = DishViewController()
        dVC.dish = dish
        
        navigationController?.pushViewController(dVC, animated: true)
        
    }
    



}
extension CatalogViewController : CatalogViewDelegate{
    
}
extension CatalogViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == catalogView.collectionView{
           return menyTypes.count
        }
        return dishes.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == catalogView.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
            cell.setLabel(menuType: menyTypes[indexPath.row])
            if selectedIndex != indexPath.row{
                cell.contentView.backgroundColor = .clear
            }
            else{
                cell.contentView.backgroundColor = UIColor(red: 0.275, green: 0.29, blue: 0.31, alpha: 1)
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath) as! DishCollectionViewCell
        cell.setCellFields(dish: dishes[indexPath.row])
        cell.purchaseButton.tag = indexPath.row
        cell.purchaseButton.addTarget(self, action: #selector(doSequeToNextScreen(button:)), for: .touchUpInside)
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == catalogView.collectionView{
            selectedIndex = indexPath.row
            dishes = []
            getDishesByMenu(menuType: menyTypes[selectedIndex])
            collectionView.reloadData()
            catalogView.secondCollectionView.reloadData()
        }
        
        
        
       
      
        
        
        
        
       

       
        
    }
    
    
    
    
}
