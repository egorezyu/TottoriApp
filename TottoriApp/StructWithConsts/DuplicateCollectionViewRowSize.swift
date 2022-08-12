//
//  DuplicateCollectionViewRowSize.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import Foundation
import UIKit
struct ReusavleViewDist{
    static let collectionViewCellheigt = 48
    static let sliderHeigt = UIScreen.main.bounds.height * 0.5
    static let hStackHeigt = 48
    static let bottomTitleHeight = 70
    static let rowSpacing = 10
    static func getSumWitoutCell() -> CGFloat{
        return CGFloat(sliderHeigt) + CGFloat(hStackHeigt) + CGFloat(bottomTitleHeight)
    }
}
