//
//  MoviePosterCourselView.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 21/06/2022.
//

import SwiftUI

struct MoviePosterCourselView: View {
    let movie: [Movie]
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movie) { movie in
                        NavigationLink(destination: MovieDetailsView(movieID: movie.id)){
                            MoviePosterView(movie: movie)
                              
                        }
                    }
                }
            }
        }
    }
}

struct MoviePosterCourselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCourselView(movie: Movie.stubbedMovies, title: "Now Playing")
    }
}
