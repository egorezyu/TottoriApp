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
        title.text = "Наши \nконтакты"
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 2
        title.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 13)
        title.textColor = .myLightGrey
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
    private lazy var sushiImage : UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "sushi"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        label.textColor = .myLightGrey
        
        label.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 26)
        return label
        
    }
    private lazy var sushiLabel : UIImageView = {
        var image = UIImageView(image: UIImage(named: "china"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
        

    }()
    private var deliverZone : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.titleLabel?.font = UIFont(name: "Gilroy", size: 14)
        
        button.setTitle("Зона доставки", for: .normal)
        button.setTitleColor(UIColor.myLightGrey, for: .normal)
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView(){
        addSubview(title)
        addSubview(firstVStack)
        addSubview(secondVStack)
        addSubview(sushiImage)
        addSubview(deliverZone)
        sushiImage.addSubview(sushiLabel)
        
    }
    private func setConstraints(){
        sushiImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sushiImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sushiImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        sushiImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.6).isActive = true
        
        sushiLabel.centerXAnchor.constraint(equalTo: sushiImage.centerXAnchor).isActive = true
        sushiLabel.centerYAnchor.constraint(equalTo: sushiImage.centerYAnchor).isActive = true
        
        sushiLabel.widthAnchor.constraint(equalTo: sushiImage.widthAnchor).isActive = true
        sushiLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        title.centerXAnchor.constraint(equalTo: sushiImage.centerXAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstVStack.topAnchor.constraint(equalTo: sushiImage.bottomAnchor,constant: 20).isActive = true
        firstVStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        secondVStack.leadingAnchor.constraint(equalTo: firstVStack.trailingAnchor,constant: 10).isActive = true
        secondVStack.centerYAnchor.constraint(equalTo: firstVStack.centerYAnchor).isActive = true
        
        deliverZone.topAnchor.constraint(equalTo: secondVStack.bottomAnchor,constant: 20).isActive = true
        deliverZone.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        deliverZone.heightAnchor.constraint(equalToConstant: 50).isActive = true
        deliverZone.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 30).isActive = true
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
