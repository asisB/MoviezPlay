//
//  MainView.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 21/06/2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var nowPlayingState = MovieViewModel()
    @ObservedObject private var upcomingState = MovieViewModel()
    @ObservedObject private var topRatedState = MovieViewModel()
    @ObservedObject private var popularState = MovieViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true){
                VStack(alignment: .leading, spacing: 16){
                    if upcomingState.movie != nil {
                        MoviesLatestCard(movies: upcomingState.movie!)
                        
                    }else {
                        LoadingView(isLoading: self.upcomingState.isLoading, error: self.upcomingState.error) {
                            self.upcomingState.loadMovie(with: .upcoming)
                        }
                    }
                    
                    if nowPlayingState.movie != nil {
                        MoviePosterCourselView(movie: nowPlayingState.movie!, title: "Now Playing")
                        
                    }else {
                        LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                            self.nowPlayingState.loadMovie(with: .nowPlaying)
                        }
                    }
                    
                    if topRatedState.movie != nil {
                        MoviePosterCourselView(movie: topRatedState.movie!, title: "Top Rated")
                    }else {
                        LoadingView(isLoading: self.topRatedState.isLoading, error: self.topRatedState.error) {
                            self.topRatedState.loadMovie(with: .topRated)
                        }
                    }
                    
                    if popularState.movie != nil {
                        MoviePosterCourselView(movie: popularState.movie!, title: "Popular")
                    }else {
                        LoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                            self.popularState.loadMovie(with: .popular)
                        }
                    }
                }
                
            }.navigationTitle("MoviezPlay")
                .navigationBarItems(trailing:
                                        VStack{
                    NavigationLink(destination: MovieSearchView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    ){
                        Image(systemName: "magnifyingglass")
                    }
                }
                )
            
        }
        .onAppear {
            self.nowPlayingState.loadMovie(with: .nowPlaying)
            self.upcomingState.loadMovie(with: .upcoming)
            self.topRatedState.loadMovie(with: .topRated)
            self.popularState.loadMovie(with: .popular)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
