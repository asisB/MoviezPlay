//
//  MoviePosterView.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 21/06/2022.
//

import SwiftUI

struct MoviePosterView: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack{
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(.horizontal, 8)
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 216, height: 306)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterView(movie: Movie.stubbedMovie)
    }
}
