//
//  Formatter.swift
//  TottoriApp
//
//  Created by Егор Родионов on 21.07.22.
//

import Foundation
extension Formatter {

    

    static let separator: NumberFormatter = {

        

        let formatter = NumberFormatter()

        formatter.numberStyle = .decimal

        formatter.groupingSeparator = " "

        return formatter

    }()

}




extension Numeric {

    

    var formatWithSeparator: String { Formatter.separator.string(for: self)! }

}
