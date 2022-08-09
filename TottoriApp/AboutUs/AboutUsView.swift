//
//  AboutUsView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 9.08.22.
//

import UIKit
import DGCarouselFlowLayout

class AboutUsView: UIView {
    private weak var delegate : AboutUsDelegate?
    init(delegate : AboutUsDelegate? = nil) {
        super.init(frame: .zero)
        self.delegate = delegate
        addViews()
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
    private lazy var horCollectionView : UICollectionView = {
        var layout = DGCarouselFlowLayout()
        layout.scrollDirection = .horizontal
       
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        
        
        return collectionView
        
        
    }()
    private func addViews(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(horCollectionView)
    }
    private func setConstraints(){
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
//        horCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        
//        horCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        horCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
////        horCollectionView.heightAnchor.constraint(equalToConstant: 1400).isActive = true
//        horCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 40).isActive = true
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
