//
//  SeriesCardView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// A single card representing a TV series with image, title, genres, year, and network name.
struct SeriesCardView: View {
    let series: Series

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
        }
        .padding(12)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
