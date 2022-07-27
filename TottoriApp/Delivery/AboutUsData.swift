//
//  AboutUsData.swift
//  TottoriApp
//
//  Created by Егор Родионов on 27.07.22.
//

import UIKit

class AboutUsData: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setConstraints()
    }
    private lazy var title : UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Наши контакты"
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 2
        title.font = UIFont(name: "FoglihtenNo06", size: 30)
        return title
    }()
    private lazy var firstVStack : UIStackView = {
        var stack = generateVStack()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(generateLabel(title: "Адрес:"))
        stack.addArrangedSubview(generateLabel(title: "Каждый день:"))
        stack.addArrangedSubview(generateLabel(title: "Телефон:"))
        return stack
    }()
    private lazy var secondVStack : UIStackView = {
        var stack = generateVStack()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(generateLabel(title: "Москва,Новая площадь,14"))
        stack.addArrangedSubview(generateLabel(title: "с 11:00 до 22:00"))
        stack.addArrangedSubview(generateLabel(title: "+7 499 678 08 66"))
        return stack
        
    }()
    
    
    private func generateVStack() -> UIStackView{
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }
    private func generateLabel(title : String) -> UILabel{
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "Gilroy", size: 16)
        return label
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView(){
        addSubview(title)
        addSubview(firstVStack)
        addSubview(secondVStack)
        
    }
    private func setConstraints(){
        title.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstVStack.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 50).isActive = true
        firstVStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        secondVStack.leadingAnchor.constraint(equalTo: firstVStack.trailingAnchor,constant: 10).isActive = true
        secondVStack.centerYAnchor.constraint(equalTo: firstVStack.centerYAnchor).isActive = true
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
