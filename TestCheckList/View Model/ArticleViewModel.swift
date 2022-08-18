//
//  ArticleViewModel.swift
//  TestCheckList
//
//  Created by João Victor  on 17/08/22.
//

import Foundation


class ArticlesViewModel: ObservableObject {
       
    @Published var articles: Articles?
    private let service = APIService()
    
    private func loadArticles(completion: @escaping(Articles?, Error?) -> Void){
        service.fetchArticles{ result in
            switch result{
            case .success(let articles):
                completion(articles, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    func loadData(){
        self.loadArticles { articles, error in
            DispatchQueue.main.async {
                self.articles = articles ?? nil
            }
        }
    }
}
