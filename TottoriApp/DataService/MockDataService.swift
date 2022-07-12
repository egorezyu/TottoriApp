//
//  MockDAta.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import Foundation
import Foundation
import UIKit
class NetworkManager{
    static var netWork = NetworkManager()
    
    
    private init(){
        
    }
    //working with network with escaping completion and result
    func getDataFromApi(comletion : @escaping ((Result<[String],Error>) -> Void)){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            comletion(.success(["Все","Рамен","Меню","Десерты","Горячие блюда","Закуски и Салаты","Бар","Напитки"]))
        }
        
        
    }
}
