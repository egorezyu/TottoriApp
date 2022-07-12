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
    private var menyTypes : [String] = []
    override func loadView() {
        super.loadView()
        view = catalogView
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let image = UIImage(named: "back"){
            view.backgroundColor = UIColor(patternImage: image)
        }
        
        
        
        setUpCollectionView()
        getMockData()
        

        
       
        

        
        
        
        
        

        
    }
    private func setUpCollectionView(){
        catalogView.collectionView.dataSource = self
        catalogView.collectionView.delegate = self
    }
    private func getMockData(){
        NetworkManager.netWork.getDataFromApi { result in
            switch result{
                
            case .success(let typeArray):
                DispatchQueue.main.async {[weak self] in
                    self?.menyTypes = typeArray
                    self?.catalogView.collectionView.reloadData()
                }
            case .failure(_):
                print("")
            }
        }
        
    }
    



}
extension CatalogViewController : CatalogViewDelegate{
    
}
extension CatalogViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menyTypes.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        cell.setLabel(menuType: menyTypes[indexPath.row])
        if selectedIndex != indexPath.row{
            cell.contentView.backgroundColor = .clear
        }
        else{
            cell.contentView.backgroundColor = .white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
       
        selectedIndex = indexPath.row
        collectionView.reloadData()
        
        
        
        
       

       
        
    }
    
    
    
    
}
