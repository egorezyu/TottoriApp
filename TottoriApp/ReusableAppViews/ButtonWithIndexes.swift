//
//  PlusButton.swift
//  TottoriApp
//
//  Created by Егор Родионов on 4.09.22.
//

import UIKit

class ButtonWithIndexes : UIButton,TwoDimenIndex {
    public var section : Int!
    public var index : Int!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

}
