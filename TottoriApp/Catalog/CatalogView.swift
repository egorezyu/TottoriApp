//
//  CatalogView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import UIKit

final class CatalogView: UIView {
    weak var delegate : CatalogViewDelegate?
    init(subscriber : CatalogViewDelegate? = nil){
        super.init(frame: .zero)
        self.delegate = subscriber
        addSubview()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 114, height: 48)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
     
        
        
        
        return collectionView
        
        
    }()
    lazy var secondCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 411)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: DishCollectionViewCell.identifier)
     
        
        
        
        return collectionView
        
        
    }()
    private func addSubview(){
        addSubview(collectionView)
        addSubview(secondCollectionView)
    }
    private func setLayout(){
        
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
            
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
        collectionView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        
        secondCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30).isActive = true
       
        secondCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
       
        secondCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        secondCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -20).isActive = true
       
        
        
        
    }
    
    

   

}
