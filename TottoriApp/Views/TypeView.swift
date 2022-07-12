//
//  TypeView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import UIKit

class TypeView: UIControl {
    var viewIsActive = false
    lazy var typeLabel : UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = .labelColor
        typeLabel.font = UIFont.systemFont(ofSize: 15)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        return typeLabel

    }()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        layer.borderColor = UIColor.borderColor?.cgColor
        layer.borderWidth = 1
        addSubview(typeLabel)
        
        
       
        
        addTarget(self, action: #selector(onTapJesture(sender:)), for: .touchUpInside)
        
        setConstraints()
    }
    func setType(type : String){
        
        
        
        typeLabel.text = type
        
        
    }
    private func setConstraints(){
        
        typeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        typeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    @objc func onTapJesture(sender : TypeView){
        sender.viewIsActive.toggle()
        
//        if viewIsActive{
//            backgroundColor = UIColor.black
//        }
//        else{
//            backgroundColor = .backGroundColor
//        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
