//
//  ContentView.swift
//  TMDBApp
//
//  Created by Pro on 26.03.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.movies.count > 0 {
                    MoviesListView(movies: viewModel.movies, viewModel: viewModel)
                } else {
                    loadingView
                }
            }
            .navigationTitle("Top Movies 🔥")
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct RatingView: View {
    var rating: Float
    var body: some View {
        
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.red)
            
            Text(String(format: "%.1f", rating))
                .fontWeight(.medium)
        }
    }
}

struct MoviesListView: View {
    var movies: [Movie]
    
    @StateObject var viewModel: MovieViewModel
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(
                    destination: DetailsView(movie: movie, viewModel: viewModel),
                    label: {
                        MovieView(movie: movie)
                            .padding(.vertical)
                            .onAppear {
                                viewModel.fetchDataIfNeeded(movie: movie)
                            }
                    })
            }
        }
        
        .listStyle(.inset)
    }
}

var loadingView: some View {
    Text("Fetching data...")
        .foregroundColor(.gray)
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
