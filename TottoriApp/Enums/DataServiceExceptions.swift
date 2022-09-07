//
//  DataServiceExceptions.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import Foundation
enum GetDataException : String ,Error{
    case invalidUrl = "bad URL"
    case badResponse = "Something went wrong"
    case badData = "Couldnt get data"
    case serverError = "Request time out"
    case internet = "No internet"

}
extension GetDataException: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("invalid_url", comment: "My error")
        case .badResponse:
            return NSLocalizedString("smth_went_wrong", comment: "My error")
        case .badData:
            return NSLocalizedString("couldnt_get_data", comment: "My error")
        case .serverError:
            return NSLocalizedString("time_out", comment: "My error")
        case .internet:
            return NSLocalizedString("no_internet", comment: "My error")
        }
    
    }
}
