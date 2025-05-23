//
//  SeriesCardView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI
import CoreData

/// A single card representing a TV series with image, title, genres, year, and network name.
struct SeriesCardView: View {
    let series: Series
    var onFavoriteToggled: (() -> Void)? = nil
    @EnvironmentObject var env: AppEnvironment

    @ObservedObject private var favoriteStorage = FavoriteSeriesStorage.shared

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: series.image?.medium ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 150)
                        .background(Color.gray.opacity(0.2))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 100, height: 150)
                        .background(Color.gray.opacity(0.2))
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(series.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                if let genres = series.genres, !genres.isEmpty {
                    Text(genres.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                HStack(spacing: 4) {
                    if let year = series.premiered?.prefix(4) {
                        Text(String(year))
                    }
                    if let network = series.network?.name {
                        Text("· \(network)")
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }

            Spacer()

            Button(action: {
                favoriteStorage.toggleFavorite(for: series)
                onFavoriteToggled?()
            }) {
                Image(systemName: favoriteStorage.isFavorite(seriesID: series.id) ? "heart.fill" : "heart")
                    .foregroundColor(favoriteStorage.isFavorite(seriesID: series.id) ? .red : .gray)
                    .imageScale(.large)
            }
        }
        .padding(12)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// MARK: - Previews
#if DEBUG
#Preview("Default") {
    NavigationView {
        SeriesCardView(
            series: Series(
                id: 1,
                name: "Test Series",
                image: .init(medium: nil, original: nil),
                genres: ["Action", "Drama"],
                premiered: "2020-01-01",
                network: .init(name: "PreviewNet")
            )
        )
        .environmentObject(AppEnvironment())
        .padding()
    }
}

#if TEST
#Preview("With MockAPIClient") {
    NavigationView {
        SeriesCardView(
            series: MockAPIClient().mockSeries.first!
        )
        .environmentObject(AppEnvironment(apiClient: MockAPIClient()))
        .padding()
    }
}
#endif
#endif
