//
//  ProtocolRequestExtension.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import Foundation

extension Request {

    

    func encode(encoder: JSONEncoder) -> Data? {

        return nil

    }

}
extension Request where Response == [String: Any] {

    

    func decode(with data: Data, decoder: JSONDecoder) throws -> Response {

        

        guard !data.isEmpty else { return [:] }

        guard let response = try JSONSerialization.jsonObject(with: data, options: []) as? Response else {

            throw GetDataException.badData

        }

        return response

    }

}




extension Request where Response: Decodable {

    

    func decode(with data: Data, decoder: JSONDecoder) throws -> Response {

        

        do {

            return try decoder.decode(Response.self, from: data)

        } catch {

            throw error

        }

    }

}
