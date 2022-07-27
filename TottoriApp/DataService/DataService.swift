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
    case serverError = "bad server response"

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
        
        let proc = DownsamplingImageProcessor(size: CGSize(width: 500, height: 500))

        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,

            options: [
                .processor(proc),

                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.7)),
                .cacheOriginalImage

            ]) { result in
                switch result{
                    
                case .success(_):
                    print("")
                case .failure(_):
                    imageView.image = UIImage(named: "tottori")
                }
            }



    }

}




final class NetworkManager {

    

    static let shared = NetworkManager()

    private init() {}

    

    

    private lazy var session: URLSession = {

        

        let configuration = URLSessionConfiguration.default

        configuration.timeoutIntervalForRequest = 30

        configuration.timeoutIntervalForResource = 60

        let session = URLSession(configuration: configuration)

        return session

    }()

    

    private lazy var decoder: JSONDecoder = {

        

        let decoder = JSONDecoder()

        return decoder

    }()

    

    private lazy var encoder: JSONEncoder = {

        

        let encoder = JSONEncoder()

        return encoder

    }()
    

    

    private func request<T: Request>(request: T, data: Data? = nil, completion: @escaping (Result<T.Response, Error>) -> Void){
        if self.session.configuration.timeoutIntervalForRequest > 30 || self.session.configuration.timeoutIntervalForResource > 60 {
            completion(.failure(GetDataException.serverError))
            return

        }

        

        var urlRequest = URLRequest(url: request.path)

        urlRequest.httpMethod = data == nil ? "GET" : "POST"

        urlRequest.httpBody = data

        let task = self.session.dataTask(with: urlRequest) { data, response, error in


        if error != nil {
            completion(.failure(GetDataException.badResponse))
            }

            

        

        

        guard let data = data else {
            completion(.failure(GetDataException.badData))
            return

        }

        do {

                let resultData = try request.decode(with: data, decoder: self.decoder)

                completion(.success(resultData))

            }
        catch {
            
                completion(.failure(GetDataException.badData))
            }

        }
        task.resume()
    
    
    
        
    }
    func makeMenuListRequest(completion: @escaping (Result<MenuListRequest.Response, Error>) -> Void) {

        

        let request = MenuListRequest()

        self.request(request: request) { result in
            completion(result) }

    }
    

    
    
    
        
    

}

    

  
    

    

    











