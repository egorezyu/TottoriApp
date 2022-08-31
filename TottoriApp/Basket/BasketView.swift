//
//  BasketView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 17.07.22.
//

import UIKit

class BasketView: UIView {
    weak var delegate : BasketDelegate?
    init(delegate : BasketDelegate? = nil) {
        super.init(frame: .zero)
        self.delegate = delegate
        addViews()
        setConstraints()
    }
    private lazy var basketLabel : UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.font = UIFont(name: "FoglihtenNo06", size: FontSizes.font30)
        label.textColor = .myLightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private lazy var aboutDeliveryTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "Доставим за час"
        label.font = UIFont(name: "Gilroy-Medium", size: FontSizes.font14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
        
    }()
    lazy var basketCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 26), height: UIScreen.main.bounds.height * 0.2)
        
        
        
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
     
        
        
        
        return collectionView
        
        
    }()
    public lazy var toDeliveryScreenButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.22
        button.setTitle("ОФОРМИТЬ ЗАКАЗ", for: .normal)
        button.setTitle("ДОБАВЬТЕ ТОВАРЫ В КОРЗИНУ", for: .disabled)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(goToDeliveryScreen(sender:)), for: .touchUpInside)
        return button
        
    }()
    
    

   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addViews(){
        addSubview(basketLabel)
        addSubview(aboutDeliveryTimeLabel)
        addSubview(basketCollectionView)
        addSubview(toDeliveryScreenButton)
        
        
    }
    private func setConstraints(){
        basketLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 5).isActive = true
        basketLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        aboutDeliveryTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        aboutDeliveryTimeLabel.centerYAnchor.constraint(equalTo: basketLabel.centerYAnchor).isActive = true
        basketCollectionView.topAnchor.constraint(equalTo: basketLabel.bottomAnchor,constant: 10).isActive = true
        basketCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        basketCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        basketCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.55).isActive = true
        toDeliveryScreenButton.topAnchor.constraint(equalTo: basketCollectionView.bottomAnchor,constant: 10).isActive = true
        toDeliveryScreenButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        toDeliveryScreenButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        toDeliveryScreenButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05).isActive = true
        
    }
    @objc func goToDeliveryScreen(sender : UIButton){
        
        delegate?.toDeliveryScreen()
        
    }

}
