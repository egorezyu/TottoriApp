//
//  TextWithIndexes.swift
//  TottoriApp
//
//  Created by Егор Родионов on 4.09.22.
//

import UIKit

class TextWithIndexes: UILabel,TwoDimenIndex {
    public var section : Int!
    public var index : Int!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
