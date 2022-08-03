//
//  CollectionReusableView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 3.08.22.
//

import UIKit
import DGCarouselFlowLayout


class MySecondHeaderClass: UICollectionReusableView {
    static let headerReuseIdentifier = "headerSecondReuseIdentifier"
    
    
    public lazy var textLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 17.7272727273)
        return label
        
    }()
    public lazy var favCollectionView : UICollectionView = {
        let layout = DGCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 4, height: UIScreen.main.bounds.height / 1.5 - 50)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.register(CustomFavouriteCell.self, forCellWithReuseIdentifier: CustomFavouriteCell.id)
        view.backgroundColor = .clear
        return view
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addView()
        setConsraints()
        
        

        
        setBackGround()
        setBackGroundForLabel()
        
        
        
    }
    private func addView(){
        addSubview(textLabel)
        addSubview(favCollectionView)
    }
    private func setConsraints(){
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor,constant: UIScreen.main.bounds.height / 1.5 - 50),

            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
        NSLayoutConstraint.activate([
            favCollectionView.topAnchor.constraint(equalTo: topAnchor),

            favCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),

        ])
        
        
    }
    
    
    private func setBackGround(){
        if let image = UIImage(named: "forest"){
            backgroundColor = UIColor(patternImage: image)
        }
        
    }
    private func setBackGroundForLabel(){
        if let image = UIImage(named: "back"){
            textLabel.backgroundColor = UIColor(patternImage: image)
        }
        
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





//Little title header class
class MyHeaderClass: UICollectionReusableView {
    static let headerReuseIdentifier = "headerReuseIdentifier"
    
    
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor,constant: UIScreen.main.bounds.height / 10),
           
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            
        ])
        textLabel = label
        textLabel.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 17.7272727273)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
