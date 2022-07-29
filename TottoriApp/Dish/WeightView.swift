//
//  WeightView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 21.07.22.
//

import UIKit

class WeightView: UIView {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addView()
        setConstraints()
    }

    
        
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public lazy var weightLabel : UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Gilroy", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
        
    }()
    lazy var gramLabel : UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Cormorant", size: 20)
        label.text = "г"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func addView(){
        addSubview(weightLabel)
        addSubview(gramLabel)
        
        
        
        
        
    }
    private func setConstraints(){
        weightLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weightLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        gramLabel.leadingAnchor.constraint(equalTo: weightLabel.trailingAnchor,constant: 5).isActive = true
        gramLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 3).isActive = true

        
        
        
        
        
    }
    func setWeight(weight : String?){
        if let weight = weight {
            if weight != ""{
                weightLabel.text = weight
            }
            else{
                gramLabel.text = ""
            }
        }
        
    }

}
