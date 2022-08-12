//
//  CustomAllertView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 8.08.22.
//

import UIKit

class CustomAllertView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackGroundColor()
        setBackGround()
        addViews()
        setConstraints()
        
    }
    private lazy var image : UIImageView = {
        let image = UIImageView(image: UIImage(named: "exit"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    private lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FoglihtenNo06", size: FontSizes.font30)
        label.text = "СПАСИБО \n ЗА ЗАКАЗ!"
        label.numberOfLines = 2
        label.textColor = .myLightGrey
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addViews(){
        addSubview(image)
        addSubview(label)
        
    }
    private func setConstraints(){
        image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor,constant: 20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 37).isActive = true
        image.widthAnchor.constraint(equalToConstant: 37).isActive = true
        
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    private func setBackGround(){
        let image = UIImageView(image: UIImage(named: "backForCell"))
        image.frame = bounds
        image.contentMode = .scaleToFill
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        
        
    }
    private func setBackGroundColor(){
        if let image = UIImage(named: "back"){
            backgroundColor = UIColor(patternImage: image)
        }
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
