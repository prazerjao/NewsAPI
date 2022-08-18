//
//  ArticleModel.swift
//  TestCheckList
//
//  Created by João Victor  on 17/08/22.
//

import Foundation

struct Source: Decodable{
    let id: String?
    let name: String?
}

struct Articles: Decodable {
    let articles: [Article]
}

struct Article: Identifiable, Decodable{
    let source: Source?
    var id: String? {source?.id}
    let author: String?
    let title: String?
    let description: String?
}

enum APIError: LocalizedError{
    case invalidUrl, requestError, decodingError, statusNotOk
    
    var errorDescription: String?{
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .requestError:
            return "Error in the request of the API"
        case .decodingError:
            return "Error trying to decode"
        case .statusNotOk:
            return "Error HTTP"
        }
    }
}

class APIService{
    var session: URLSession
    let url: String
    
    init(session:URLSession){
        self.session = session
        self.url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=125b3ac2581a44edbf67e166029901df"
    }
    convenience init(){
        self.init(session: URLSession.shared)
    }
    func fetchArticles(completion: @escaping(Result <Articles?, Error>) -> Void){
        
        guard let api = URL(string: url) else{
            completion(.failure(APIError.invalidUrl))
            print("api")
            return
        }
        
        let task = session.dataTask(with: api){ ( data, response, error) in
            guard let jsonData = data else{
                completion(.failure(APIError.decodingError))
                print("json data")
                return
            }
            do{
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(Articles.self, from: jsonData)
                completion(.success(decoded))
            }catch let error{
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
}
    

