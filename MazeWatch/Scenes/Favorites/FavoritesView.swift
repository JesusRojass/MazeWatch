//
//  FavoritesView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.favorites.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "star")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)
                        Text("Browse and add favorites")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.favorites, id: \.id) { favorite in
                            NavigationLink(
                                destination: SeriesDetailView(
                                    viewModel: SeriesDetailViewModel(seriesID: Int(favorite.id), apiClient: AppEnvironment().apiClient)
                                )
                            ) {
                                SeriesCardView(series: Series(
                                    id: Int(favorite.id),
                                    name: favorite.name ?? "Untitled",
                                    image: .init(medium: favorite.imageURL, original: nil),
                                    genres: favorite.genres?.components(separatedBy: ","),
                                    premiered: favorite.premiered,
                                    network: .init(name: favorite.network ?? "")
                                ))
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let id = Int(viewModel.favorites[index].id)
                                viewModel.removeFavorite(id: id)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.loadFavorites()
            }
        }
    }
}
