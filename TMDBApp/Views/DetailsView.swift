//
//  DetailsView.swift
//  TMDBApp
//
//  Created by Pro on 27.03.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    var movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    @Environment(\.presentationMode) var presentation
    @State var yOffset: CGFloat = 30
    @State var opacity: Double = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ZStack(alignment: .top) {
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    HStack {
                        Button(action: {
                            presentation.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                                .foregroundColor(Color.primary)
                        })
                        
                        Spacer()
                    }
                    .padding()
                    .padding(.top)
                }
                
                Spacer()
            }
            
            VStack(spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    Text(movie.title)
                        .font(.largeTitle)
                    
                    RatingView(rating: movie.vote_average)
                    
                    Spacer()
                }
                
                HStack(spacing: 8) {
                    ForEach(viewModel.movie?.genres ?? Array.init(repeating: Genre(id: 0,name: "Loading..."), count: 3)) { genre in
                        Text(genre.name)
                            .redacted(reason: viewModel.movie != nil ? .init() : .placeholder)
                        
                        if viewModel.movie?.genres?.last != genre {
                            Circle()
                                .frame(width: 6, height: 6)
                        }
                    }
                    
                    Spacer()
                }
                Text(movie.overview ?? "")
            }
            .padding()
            .background(Color.black)
            .frame(width: 400, height: 400)
            .offset(y: yOffset)
            .opacity(opacity)
            .onAppear {
                    withAnimation {
                        yOffset = 0
                        opacity = 1
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            viewModel.fetchMovie(movie: movie)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(movie: Movie(id: 508943, title: "Luca", overview: "Luca and his best friend Alberto experience an unforgettable summer on the Italian Riviera. But all the fun is threatened by a deeply-held secret: they are sea monsters from another world just below the waters surface.", poster_path: "/jTswp6KyDYKtvC52GbHagrZbGvD.jpg", vote_average: 0.3, genres: nil), viewModel: MovieViewModel())
    }
}
