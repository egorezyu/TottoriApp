//
//  CollectionReusableView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 3.08.22.
//

import UIKit
import DGCarouselFlowLayout
import CoreAudio


class HeaderForFavDishes: UICollectionReusableView {
    static let headerReuseIdentifier = "headerSecondReuseIdentifier"
    private var rowCount : Int = 0
    
    
    
    private lazy var holdTextView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        
        return view
        
    }()
    public lazy var firstDishTitle : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 17.7272727273)
        
        return label
    }()
    public lazy var favCollectionView : UICollectionView = {
        let layout = FlowLay()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 60, height: ReusavleViewDist.sliderHeigt)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.register(CustomFavouriteCell.self, forCellWithReuseIdentifier: CustomFavouriteCell.id)
        view.backgroundColor = .clear
        return view
        
    }()
    public lazy var duplicateCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: Int(UIScreen.main.bounds.width) / 3 - 30, height: ReusavleViewDist.collectionViewCellheigt)
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
        layout.minimumInteritemSpacing = CGFloat(ReusavleViewDist.rowSpacing)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.register(DuplicateCollectionViewCell.self, forCellWithReuseIdentifier: DuplicateCollectionViewCell.id)
        view.isScrollEnabled = false
        view.backgroundColor = .red
      
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
    convenience init(frame : CGRect,rowCount : Int) {
        self.init(frame: frame)
        self.rowCount = rowCount
        
    }
    func setRowCount(rowCount : Int){
        self.rowCount = rowCount
        duplicateCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(rowCount * ReusavleViewDist.collectionViewCellheigt) +
                                                        CGFloat((rowCount) * ReusavleViewDist.rowSpacing)).isActive = true
        self.setNeedsLayout()
    }
    public func setChoseFirst(){
        hStack.subviews[0].layer.borderColor = UIColor.red.cgColor
    }
    
    private func addView(){
        addSubview(holdTextView)
        addSubview(favCollectionView)
        addSubview(hStack)
        addSubview(duplicateCollectionView)
        
        holdTextView.addSubview(firstDishTitle)
        
        
    }
    private func setConsraints(){
       
        
        NSLayoutConstraint.activate([
            
            holdTextView.topAnchor.constraint(equalTo: duplicateCollectionView.bottomAnchor),
            

            holdTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            holdTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            holdTextView.heightAnchor.constraint(equalToConstant: CGFloat(ReusavleViewDist.bottomTitleHeight))
        

        ])
        NSLayoutConstraint.activate([
            
            duplicateCollectionView.topAnchor.constraint(equalTo: hStack.bottomAnchor),
            

            duplicateCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            duplicateCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        

        ])
        NSLayoutConstraint.activate([
            firstDishTitle.leadingAnchor.constraint(equalTo: holdTextView.leadingAnchor),
            firstDishTitle.centerYAnchor.constraint(equalTo: holdTextView.centerYAnchor),
            
        

        ])
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: favCollectionView.bottomAnchor),

            hStack.leadingAnchor.constraint(equalTo: favCollectionView.leadingAnchor,constant: 20),
           

        ])
        
        
        NSLayoutConstraint.activate([
            favCollectionView.topAnchor.constraint(equalTo: topAnchor),

            favCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(ReusavleViewDist.sliderHeigt))
            

        ])

        for view in hStack.subviews{
            view.widthAnchor.constraint(equalToConstant: 48).isActive = true
            view.heightAnchor.constraint(equalToConstant: CGFloat(ReusavleViewDist.hStackHeigt)).isActive = true
        }
        
        
    }
    
    
    private func setBackGround(){
   
        if let image = UIImage(named: "forest"){
            backgroundColor = UIColor(patternImage: image)
        }
        
    }
    private func setBackGroundForLabel(){
        if let image = UIImage(named: "back"){
            holdTextView.backgroundColor = UIColor(patternImage: image)
        }
        
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







