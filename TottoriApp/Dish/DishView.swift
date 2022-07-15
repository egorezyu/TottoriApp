//
//  DishView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import UIKit


class DishView: UIView {
    weak var delegate : DishDelegate?
    init(subscriber : DishDelegate? = nil){
        super.init(frame: .zero)
        self.delegate = subscriber
        addSubview()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubview(){
        
    }
    private func setLayout(){
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
