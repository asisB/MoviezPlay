//
//  MoviesLatestCard.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 19/06/2022.
//

import SwiftUI

struct MoviesLatestCard: View {
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailsView(movieID: movie.id)){
                            MovieBackdropCard(movie: movie)
                                .frame(width: 360, height: 340)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                        
                    }
                }
            }
        }
        
    }
}

struct MoviesLatestCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviesLatestCard(movies: Movie.stubbedMovies)
    }
}
