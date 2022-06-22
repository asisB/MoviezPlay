//
//  MovieDetailImage.swift
//  MoviezPlay
//
//  Created by Ashish Basnet on 22/06/2022.
//

import SwiftUI

struct MovieDetailImage: View {
    @ObservedObject var imageLoader: ImageLoader
    let imageUrl: URL
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear{
            self.imageLoader.loadImage(with: self.imageUrl)
        }
    }
}
