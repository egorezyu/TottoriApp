//
//  DesignListRequest.swift
//  TottoriApp
//
//  Created by Егор Родионов on 17.08.22.
//

import Foundation
struct DesignListRequest : Request{
    typealias Response = Desing
    var path: URL = URL(string: "http://tottori.fixmaski.ru/api/blockBeatiful.php")!
    struct Desing : Codable {
        let status: Bool
        let blocks: [Block]?
    }

    // MARK: - Block
    struct Block : Codable{
        let elemBlocks: [ElemBlock]?
    }

    // MARK: - ElemBlock
    struct ElemBlock : Codable {
        let blockID, bigPicture, smallPicture, textContent1: String?
        let textContent2: String?
    }

    
    
    
}
