//
//  CollectionReusableView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 3.08.22.
//

import UIKit
import DGCarouselFlowLayout
import CoreAudio


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
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 4, height: frame.height * 0.8)
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
            
            
  
//            label.text = String(0) + String(i + 1)
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
    public func confirmStack(stack : UIStackView,j : Int){
        var dictionary : [Int : Int] = [:]
        dictionary[0] = j - 2
        dictionary[1] = j - 1
        dictionary[2] = j
        for (key,value) in dictionary{
            (stack.subviews[key] as! UILabel).text = String(value + 1)
            
            
        }
       
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addView()
        setConsraints()
        
        

        
        setBackGround()
        setBackGroundForLabel()
        setChoseFirst()
        
        
        
    }
    public func setChoseFirst(){
        hStack.subviews[0].layer.borderColor = UIColor.red.cgColor
    }
    
    private func addView(){
        addSubview(textLabel)
        addSubview(favCollectionView)
        addSubview(hStack)
    }
    private func setConsraints(){
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 10),
            

            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        

        ])
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: favCollectionView.bottomAnchor,constant: 10),

            hStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
           

        ])
        
        NSLayoutConstraint.activate([
            favCollectionView.topAnchor.constraint(equalTo: topAnchor,constant: 5),

            favCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favCollectionView.heightAnchor.constraint(equalToConstant: frame.height * 0.8)
            

        ])
//        favCollectionView.backgroundColor = .gray
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
