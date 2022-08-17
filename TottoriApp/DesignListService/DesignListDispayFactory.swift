//
//  DesignListDispayFactory.swift
//  TottoriApp
//
//  Created by Егор Родионов on 17.08.22.
//

import Foundation
struct DesignListDisplayFactory {

    

    static func makeDesignList(information: DesignListRequest.Desing) -> ([ElemBlock]) {
        var elemBlocks : [ElemBlock] = []
        if let blocks = information.blocks{
            for block in blocks {
                if let itemsInBlock = block.elemBlocks{
                    for element in itemsInBlock {
                        let ourElement = ElemBlock(blockID: element.blockID ?? "", bigPicture: element.bigPicture ?? "", smallPicture: element.smallPicture ?? "", textContent1: element.textContent1 ?? "", textContent2: element.textContent2 ?? "")
                        elemBlocks.append(ourElement)
                    }
                }
            }
            
         
            
            
              

                    
                    
           
           
        }
        return elemBlocks
        

        



    }

}
