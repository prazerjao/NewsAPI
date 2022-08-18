//
//  ContentView.swift
//  TestCheckList
//
//  Created by João Victor  on 17/08/22.
//

import SwiftUI

struct ArticleView: View {
    @ObservedObject var viewModel = ArticlesViewModel()
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.articles?.articles ?? []){ article in
                    Section{
                        VStack(alignment: .leading){
                            Text(article.title ?? "no title")
                                .font(.headline)
                            Text("author: \(article.author ?? "no author")")
                                .font(.subheadline)
                            Text(article.description ?? "no description")
                                .font(.body)
                        }
                    }
                }
            }
            .navigationTitle("Articles")
            .listStyle(.insetGrouped)
        }
        .onAppear(){
            viewModel.loadData()
        }
        .navigationViewStyle(.stack)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
    }
}
