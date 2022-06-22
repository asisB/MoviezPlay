//
//  MovieSearchView.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 22/06/2022.
//

import SwiftUI

struct MovieSearchView: View {
    @ObservedObject var movieSearchView = SearchViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16){
                
                HStack{
                    Text("Search")
                        .font(.title)
                        .fontWeight(.bold)
                        
                    Spacer()
                    
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .onTapGesture {
                            self.mode.wrappedValue.dismiss()
                        }
                    
                }.padding(.all)
                
                List{
                    SearchBarView(placeholder: "Search movies", text: self.$movieSearchView.query)
                        .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    LoadingView(isLoading: self.movieSearchView.isLoading, error: self.movieSearchView.error) {
                        self.movieSearchView.search(query: self.movieSearchView.query)
                    }
                    
                    if self.movieSearchView.movie != nil {
                        ForEach(self.movieSearchView.movie!) { movie in
                            NavigationLink(destination: MovieDetailsView(movieID: movie.id)) {
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                    Text(movie.yearText)
                                }
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
                .onAppear {
                    self.movieSearchView.startObserve()
                }
            }
            
            
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
