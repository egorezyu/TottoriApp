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
        collectionView.backgroundColor = .backGroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
     
        
        
        
        return collectionView
        
        
    }()
    private func addSubview(){
        addSubview(collectionView)
    }
    private func setLayout(){
        
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
            
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            
        collectionView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        
        
    }
    
    

   

}
