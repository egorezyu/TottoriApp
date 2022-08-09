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
    private lazy var aboutIntLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "наш интерьер"
        label.font = UIFont(name: "Gilroy", size: 14)
        return label
        
    }()
    private lazy var aboutBeatyLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        var paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.15
        label.numberOfLines = 0

        label.lineBreakMode = .byWordWrapping


       


        label.attributedText = NSMutableAttributedString(string: "             красота \nв деталях", attributes: [NSAttributedString.Key.kern: 3.6, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.font = UIFont(name: "FoglihtenNo06", size: 30)
        
        return label
        
    }()
    private lazy var chinaSymbol : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)


   


        view.textAlignment = .center

        view.attributedText = NSMutableAttributedString(string: "レストランインテリア", attributes: [NSAttributedString.Key.kern: 2.8])
        return view
        
    }()
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
        contentView.addSubview(aboutIntLabel)
        contentView.addSubview(horCollectionView)
        contentView.addSubview(aboutBeatyLabel)
        contentView.addSubview(chinaSymbol)
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
        
        aboutIntLabel.centerYAnchor.constraint(equalTo: aboutBeatyLabel.centerYAnchor,constant: -20).isActive = true
        aboutIntLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        
        aboutBeatyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        aboutBeatyLabel.topAnchor.constraint(equalTo: aboutIntLabel.topAnchor).isActive = true
        
        chinaSymbol.centerYAnchor.constraint(equalTo: aboutBeatyLabel.centerYAnchor,constant: 25).isActive = true
        chinaSymbol.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true

        
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
