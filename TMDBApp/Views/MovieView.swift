//
//  MovieView.swift
//  TMDBApp
//
//  Created by Pro on 02.04.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieView: View {
    var movie: Movie
    var body: some View {
        
        HStack(spacing: 15) {
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height:180)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(movie.overview ?? "")
                    .lineLimit(4)
                    .foregroundColor(.gray)
                
                RatingView(rating: movie.vote_average)
                Spacer()
            }
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: .init(id: 508943, title: "Luca", overview: "Luka is", poster_path: "/jTswp6KyDYKtvC52GbHagrZbGvD.jpg", vote_average: 7.8, genres: nil))
    }
}
