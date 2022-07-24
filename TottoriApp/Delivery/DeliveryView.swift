//
//  DeliveryView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 24.07.22.
//

import UIKit

class DeliveryView: UIView {
    private weak var delegate : DeliveryDelegate?
    private var navigationBar : UINavigationBar?

    init(delegate : DeliveryDelegate? = nil,navigationBar : UINavigationBar?) {
        super.init(frame: .zero)
        self.navigationBar = navigationBar
        self.delegate = delegate
        addView()
        setConstraints()
        
    }
    private lazy var scrollView : UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.setContentHuggingPriority(.defaultLow, for: .vertical)
        scroll.delaysContentTouches = false
        scroll.bounces = true
      
        
        return scroll
        
    }()
    private lazy var contentView : UIView = {
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    lazy var aboutDeliveryTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "Доставим за час"
        label.font = UIFont(name: "Gilroy-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
        
    }()
    private lazy var makeAnOrderLabel : UILabel = {
        var label = UILabel()
        label.text = "ОФОРМИТЬ ЗАКАЗ"
        label.font = UIFont(name: "FoglihtenNo06", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func addView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(makeAnOrderLabel)
        navigationBar?.addSubview(aboutDeliveryTimeLabel)
        
    }
    private func generateLabel(name : String) -> UILabel{
        let label = UILabel()
        label.text = name
        label.font = UIFont(name: "Gilroy", size: 14)
        return label
        
    }
    private func setConstraints(){
        if let navigationBar = navigationBar{
            aboutDeliveryTimeLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor,constant: 10).isActive = true
            aboutDeliveryTimeLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor,constant: -10).isActive = true
        }
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        makeAnOrderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        
        makeAnOrderLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

