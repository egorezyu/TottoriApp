//
//  DishView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import UIKit


final class DishView: UIView {
    weak var delegate : DishDelegate?
    var sectionList : SectionList?
    init(subscriber : DishDelegate? = nil){
        super.init(frame: .zero)
        self.delegate = subscriber
        addSubview()
        setLayout()
        
    }

    private lazy var label : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Egorinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implemented"
        label.font = UIFont(name: "FoglihtenNo06", size: 40)
 
        return label
        
    }()
  
    private lazy var scrollView : UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.setContentHuggingPriority(.defaultLow, for: .vertical)
        scroll.bounces = true
      
        
        return scroll
        
    }()
    private lazy var contentView : UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubview(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(label)
        
    }
    private func setLayout(){
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

//        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
//        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
//        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        


}
}
