//
//  UIImageView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 18.07.22.
//

import Foundation
import UIKit
extension UIImage {

    

    func resizeImage(_ maxWidthHeight: CGFloat) -> CGSize {

        

        let size = self.size

        let targetSize = CGSize(width: maxWidthHeight, height: maxWidthHeight)

        let widthRatio  = targetSize.width  / size.width

        let heightRatio = targetSize.height / size.height

        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)

        let rect = CGSize(width: newSize.width, height: newSize.height)

        return rect

    }

}
