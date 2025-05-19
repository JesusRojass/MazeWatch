//
//  EpisodeRowView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 19/05/25.
//

import SwiftUI

struct EpisodeRowView: View {
    let episode: Episode
    @EnvironmentObject var env: AppEnvironment

    var body: some View {
        NavigationLink(destination:
            EpisodeDetailView(
                viewModel: EpisodeDetailViewModel(
                    episode: episode
                )
            )
        ) {
            HStack(alignment: .top, spacing: 12) {
                if let urlString = episode.image?.medium, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 70)
                            .clipped()
                            .cornerRadius(6)
                    } placeholder: {
                        Color.gray.opacity(0.2)
                            .frame(width: 100, height: 70)
                            .cornerRadius(6)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(episode.name)
                        .font(.headline)
                    if let summary = episode.summary?.strippedHTML, !summary.isEmpty {
                        Text(summary)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
}
