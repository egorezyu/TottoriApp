//
//  DataServiceExceptions.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import Foundation
enum GetDataException : String ,Error{
    case invalidUrl = "Неверный url,обратитесь в поддержку"
    case badResponse = "Что - то пошло не так"
    case badData = "Не удалось получить данные"
    case serverError = "Время запроса вышло,попробуйте позже"

}
extension GetDataException: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Неверный url,обратитесь в поддержку", comment: "My error")
        case .badResponse:
            return NSLocalizedString("Что - то пошло не так", comment: "My error")
        case .badData:
            return NSLocalizedString("Не удалось получить данные", comment: "My error")
        case .serverError:
            return NSLocalizedString("Время запроса вышло,попробуйте позже", comment: "My error")
        }
    }
}
