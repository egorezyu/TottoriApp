//
//  CollectionReusableView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 3.08.22.
//

import UIKit
import DGCarouselFlowLayout
import CoreAudio
// not implemented at this moment

class HeaderForFavDishes: UICollectionReusableView,ViewWithStack{
    static let headerReuseIdentifier = "headerSecondReuseIdentifier"
    
    
    
    
    
    
    public lazy var favCollectionView : UICollectionView = {
        let layout = FlowLay()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height * 0.5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.register(CustomFavouriteCell.self, forCellWithReuseIdentifier: CustomFavouriteCell.id)
        view.backgroundColor = .clear
        return view
        
    }()
    
    public lazy var hStack : UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 22
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        for i in 0...2{
            var label = UILabel()
            
            label.textColor = .myLightGrey
            
            label.font = UIFont(name: "FoglihtenNo06", size: 27.95)
            
            
            
            
            label.textAlignment = .center
            
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 24
            label.layer.borderColor = UIColor.clear.cgColor
            label.translatesAutoresizingMaskIntoConstraints = false
            
            
            
            
            stack.addArrangedSubview(label)
        }
        confirmStack(stack: stack, j: 2)
        return stack
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addView()
        setConsraints()
        
        
        
        
        setBackGround()
        
        setChoseFirst()
        
        
        
    }
    
    
    public func setChoseFirst(){
        hStack.subviews[0].layer.borderColor = UIColor.red.cgColor
    }
    
    private func addView(){
        addSubview(favCollectionView)
        addSubview(hStack)
        
        
        
    }
    private func setConsraints(){
        NSLayoutConstraint.activate([
            favCollectionView.topAnchor.constraint(equalTo: topAnchor),
            
            favCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favCollectionView.heightAnchor.constraint(equalToConstant: frame.height * 0.8)
            
            
        ])
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: favCollectionView.bottomAnchor),
            
            hStack.leadingAnchor.constraint(equalTo: favCollectionView.leadingAnchor,constant: 20),
            hStack.heightAnchor.constraint(equalToConstant: 48),
            
            
            
        ])
        
        
        
        
        
        
        
        for view in hStack.subviews{
            view.widthAnchor.constraint(equalToConstant: 48).isActive = true
            view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        
        
    }
    
    
    private func setBackGround(){
        
        if let image = UIImage(named: "forest"){
            backgroundColor = UIColor(patternImage: image)
        }
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







