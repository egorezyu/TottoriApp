//
//  BasketViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class BasketViewController: UIViewController{
    private lazy var backetView = BasketView(delegate: self)
    override func loadView() {
        super.loadView()
        view = backetView
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
    
    


}
extension BasketViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath)
     
        return cell
    }
    
    
}
extension BasketViewController : BasketDelegate{
    
}
