//
//  FavoritesView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @State private var sortAscending: Bool = true

    var body: some View {
        NavigationView {
            mainContent
                .navigationTitle("Favorites")
                .onAppear {
                    viewModel.loadFavorites()
                }
        }
    }

    private var mainContent: some View {
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
                seriesList
            }
        }
    }

    private func toSeries(from favorite: FavoriteSeries) -> Series {
        Series(
            id: Int(favorite.id),
            name: favorite.name ?? "Untitled",
            image: .init(medium: favorite.imageURL, original: nil),
            genres: favorite.genres?.components(separatedBy: ","),
            premiered: favorite.premiered,
            network: .init(name: favorite.network ?? "")
        )
    }

    @ViewBuilder
    private var seriesList: some View {
        let seriesList = viewModel.favorites
            .map(toSeries)
            .sorted {
                sortAscending
                    ? $0.name.lowercased() < $1.name.lowercased()
                    : $0.name.lowercased() > $1.name.lowercased()
            }

        VStack {
            Picker("Sort Order", selection: $sortAscending) {
                Text("A–Z").tag(true)
                Text("Z–A").tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(seriesList, id: \.id) { series in
                        NavigationLink(
                            destination: SeriesDetailView(
                                viewModel: SeriesDetailViewModel(
                                    seriesID: series.id,
                                    apiClient: AppEnvironment().apiClient
                                )
                            )
                        ) {
                            SeriesCardView(series: series, onFavoriteToggled: {
                                viewModel.loadFavorites()
                            })
                            .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

private struct FavoriteRow: View {
    let series: Series

    var body: some View {
        SeriesCardView(series: series)
    }
}
