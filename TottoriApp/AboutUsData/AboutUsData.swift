//
//  AboutUsData.swift
//  TottoriApp
//
//  Created by Егор Родионов on 27.07.22.
//

import UIKit
import MapKit

class AboutUsData: UIView {
    private weak var delegate : AboutUsDataDelegate?
    
    
    init(delegate : AboutUsDataDelegate? = nil) {
        self.delegate = delegate
        super.init(frame: .zero)
        addView()
        setConstraints()
    }
    public lazy var map : MKMapView = {
        let mapkit = MKMapView()
        mapkit.translatesAutoresizingMaskIntoConstraints = false
        mapkit.layer.borderColor = UIColor.gray.cgColor
        mapkit.layer.borderWidth = 1.22
        return mapkit
        
    }()
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
        var imageView = UIImageView(image: UIImage(named: "sushi")?.withTintColor(UIColor(red: 0.553, green: 0.545, blue: 0.549, alpha: 1)))
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
    private lazy var deliverZone : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.titleLabel?.font = UIFont(name: "Gilroy", size: 14)
        
        button.setTitle("Зона доставки", for: .normal)
        button.setTitleColor(UIColor.myLightGrey, for: .normal)
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    private lazy var adressImage : UIImageView = {
        var image = UIImageView(image: UIImage(named: "adress"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var timeImage : UIImageView = {
        var image = UIImageView(image: UIImage(named: "time"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        addSubview(map)
        addSubview(adressImage)
        addSubview(timeImage)
        sushiImage.addSubview(sushiLabel)
        
    }
    private func setConstraints(){
        
        adressImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        adressImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        adressImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.1).isActive = true
        adressImage.heightAnchor.constraint(equalToConstant: UIView.getHeightOfAboutUsDataView() * 0.2).isActive = true
        
        timeImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        timeImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        timeImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.1).isActive = true
        timeImage.heightAnchor.constraint(equalToConstant: UIView.getHeightOfAboutUsDataView() * 0.2).isActive = true
        
        
        map.topAnchor.constraint(equalTo: adressImage.bottomAnchor,constant: 50).isActive = true
        map.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        map.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        map.heightAnchor.constraint(equalToConstant: UIView.getHeightOfAboutUsDataView() * 0.4).isActive = true
        sushiImage.topAnchor.constraint(equalTo: map.bottomAnchor,constant: 80).isActive = true
        sushiImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sushiImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        sushiImage.heightAnchor.constraint(equalToConstant: UIView.getHeightOfAboutUsDataView() * 0.125).isActive = true
        
        sushiLabel.centerXAnchor.constraint(equalTo: sushiImage.centerXAnchor).isActive = true
        sushiLabel.centerYAnchor.constraint(equalTo: sushiImage.centerYAnchor).isActive = true
        
        sushiLabel.widthAnchor.constraint(equalTo: sushiImage.widthAnchor).isActive = true
        sushiLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        title.centerYAnchor.constraint(equalTo: sushiImage.centerYAnchor).isActive = true
        title.topAnchor.constraint(equalTo: map.bottomAnchor,constant: 80).isActive = true
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
