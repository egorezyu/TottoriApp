//
//  DataService.swift
//  TottoriApp
//
//  Created by Егор Родионов on 16.07.22.
//

import Foundation
import Foundation
import Kingfisher
enum GetDataException : String ,Error{
    case invalidUrl = "something went wrong with url"
    case badResponse = "bad response or failed cod"
    case badData = "couldnt return data"
    
}
import Foundation
import UIKit
class DataService{
    static var netWork = DataService()
    
    
    private init(){
        
    }
    //working with network with escaping completion and result
    func getData(url : String ,method : String = "POST", params : [String:Int] = [:], comletion : @escaping ((Result<Data,Error>) -> Void)){
        guard let url = URL(string: url) else{
            comletion(.failure(GetDataException.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if method == "POST"{
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                comletion(.failure(GetDataException.invalidUrl))
                return
                
            }
            request.httpBody = httpBody
        }
        
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                comletion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                comletion(.failure(GetDataException.badResponse))
                return
            }
            guard let data = data else {
                comletion(.failure(GetDataException.badData))
                return
            }
            comletion(.success(data))
            



        }
        task.resume()
        
        
    }
    func setImageFromUrl(url : String,imageView : UIImageView){
        
        guard let url = URL(string: "http://tottori.fixmaski.ru" + url) else{
            return
        }
        
                     
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            
            options: [
               
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.7)),
                .cacheOriginalImage
                
            ])
        
        
        
    }
   
}

