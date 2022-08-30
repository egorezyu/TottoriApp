//
//  DataService.swift
//  TottoriApp
//
//  Created by Егор Родионов on 16.07.22.
//

import Foundation
import Foundation
import Kingfisher
import UIKit

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
    func makeDesignRequest(comletion : @escaping((Result<DesignListRequest.Response,Error>) -> Void)){
        let request = DesignListRequest()
        self.request(request: request) { result in
            comletion(result)
        }
    }
    func delivPostRequest(data : Data,completion : @escaping((Result<DeliveryPostRequest.Response,Error>) -> Void )){
        let request = DeliveryPostRequest()
        
        self.request(request: request,data: data) { result in
            completion(result)
        }
    }
    func setImageFromUrl(url : String,imageView : UIImageView,width : CGFloat,aspectRatio : CGFloat){

        guard let url = URL(string: "http://tottori.fixmaski.ru" + url) else{
            return
        }
        
        let proc = DownsamplingImageProcessor(size: CGSize(width: width, height: width / aspectRatio))

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

    

  
    

    

    











