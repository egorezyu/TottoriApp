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
        label.text = NSLocalizedString("basket", comment: "")
        label.font = UIFont(name: "FoglihtenNo06", size: FontSizes.font30)
        label.textColor = .myLightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private lazy var aboutDeliveryTimeLabel : UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("deliv_hour", comment: "")
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
    private lazy var sum : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.969, green: 0.169, blue: 0.071, alpha: 1)
        label.genetrateLabel(text: "0" + " ₽" , color: .red, font: UIFont(name: "FoglihtenNo06", size: CGFloat(22)),secondFont: UIFont(name: "FoglihtenNo06", size: 14))
        return label
        
    }()
    private lazy var itogo : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = NSLocalizedString("summary", comment: "") + ":"
        view.textColor = UIColor(red: 0.275, green: 0.286, blue: 0.31, alpha: 1)
        
        view.font = UIFont(name: "Gilroy-Medium", size: 20)
        return view
    }()
    public lazy var toDeliveryScreenButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.22
        button.setTitle(NSLocalizedString("make_deliv", comment: ""), for: .normal)
        button.setTitle(NSLocalizedString("add_to_basket", comment: ""), for: .disabled)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(goToDeliveryScreen(sender:)), for: .touchUpInside)
        return button
        
    }()
    public func setSum(text : String){
        self.sum.genetrateLabel(text: text , color: .red, font: UIFont(name: "FoglihtenNo06", size: CGFloat(22)),secondFont: UIFont(name: "FoglihtenNo06", size: 14))
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addViews(){
        addSubview(basketLabel)
        addSubview(aboutDeliveryTimeLabel)
        addSubview(basketCollectionView)
        addSubview(toDeliveryScreenButton)
        addSubview(sum)
        addSubview(itogo)
        
        
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
        sum.topAnchor.constraint(equalTo: basketCollectionView.bottomAnchor,constant: 5).isActive = true
        sum.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15).isActive = true
        itogo.topAnchor.constraint(equalTo: basketCollectionView.bottomAnchor,constant: 5).isActive = true
        itogo.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
        toDeliveryScreenButton.topAnchor.constraint(equalTo: sum.bottomAnchor,constant: 10).isActive = true
        toDeliveryScreenButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        toDeliveryScreenButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        toDeliveryScreenButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05).isActive = true
        
        
    }
    @objc func goToDeliveryScreen(sender : UIButton){
        
        delegate?.toDeliveryScreen()
        
    }
    
}
