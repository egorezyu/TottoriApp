//
//  Design.swift
//  TottoriApp
//
//  Created by Егор Родионов on 17.08.22.
//

import Foundation
struct Desing : Codable {
    let status: Bool
    let blocks: [Block]
}

// MARK: - Block
struct Block : Codable{
    let elemBlocks: [ElemBlock]
}

// MARK: - ElemBlock
struct ElemBlock : Codable {
    let blockID, bigPicture, smallPicture, textContent1: String
    let textContent2: String
}
