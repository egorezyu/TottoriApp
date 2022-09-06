//
//  WeightAndPriceView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 4.09.22.
//

import UIKit

class WeightAndPriceView: UIView,TwoDimenIndex {
    var index: Int!
    
    var section: Int!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setConstraints()

    }
    let weight : UILabel = {
        var view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.textColor = UIColor(red: 0.276, green: 0.288, blue: 0.308, alpha: 1)

        view.font = UIFont(name: "Gilroy", size: FontSizes.font14)

//        var paragraphStyle = NSMutableParagraphStyle()
//
//        paragraphStyle.lineHeightMultiple = 1.07
        view.text = "650 гр."
//


      


//        view.attributedText = NSMutableAttributedString(string: "650 гр.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
        
    }()
    var price : UILabel = {
        var view = UILabel()

      


        view.textColor = UIColor(red: 0.969, green: 0.169, blue: 0.071, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false

        


   


        view.genetrateLabel(text: "700  ₽", color: .red, font: UIFont(name: "FoglihtenNo06", size: FontSizes.fonFont23))
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        addSubview(weight)
        addSubview(price)
        
    }
    private func setConstraints(){
        weight.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
        weight.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        price.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15).isActive = true
        price.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
