//
//  PayView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 24.07.22.
//

import UIKit

class TogleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var rectangleButtonView : UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        return view
        
    }()
    private lazy var cicleView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.5
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.isHidden = true
        return view
        
    }()
    lazy var text : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        label.textColor = .myLightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func addView(){
        addSubview(rectangleButtonView)
        addSubview(text)
        rectangleButtonView.addSubview(cicleView)
        
       
        
    }
    private func setConstraints(){
        rectangleButtonView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        rectangleButtonView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      
        rectangleButtonView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 9.75).isActive = true
        rectangleButtonView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 9.75).isActive = true
        
        text.leadingAnchor.constraint(equalTo: rectangleButtonView.trailingAnchor,constant: 10).isActive = true
        text.centerYAnchor.constraint(equalTo: rectangleButtonView.centerYAnchor).isActive = true
        
        cicleView.centerXAnchor.constraint(equalTo: rectangleButtonView.centerXAnchor).isActive = true
        cicleView.centerYAnchor.constraint(equalTo: rectangleButtonView.centerYAnchor).isActive = true
        cicleView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        cicleView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        
    }
    public func setText(currentText : String){
        text.text = currentText
    }
    public func drawCircle(){
        cicleView.isHidden = false
    }
    public func clearCircle(){
        cicleView.isHidden = true
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
