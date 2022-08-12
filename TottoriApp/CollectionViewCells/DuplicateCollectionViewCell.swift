//
//  DuplicateCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import UIKit

class DuplicateCollectionViewCell: UICollectionViewCell {
    static let id = "DuplicateCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
