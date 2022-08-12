//
//  RequestProtocol.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import Foundation
protocol Request {

    

    associatedtype Response = [String: Any]

    

    var path: URL { get }

    

    func decode(with data: Data, decoder: JSONDecoder) throws -> Response

    

}
