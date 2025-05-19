//
//  SeriesDetailView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// View displaying detailed information and episodes for a given series.
struct SeriesDetailView: View {
    @StateObject private var viewModel: SeriesDetailViewModel
    @State private var selectedSeason: Int = 1
    
    /// ViewModel must be injected to respect MVVM and allow testing/previews
    init(viewModel: SeriesDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                seriesHeaderView
                if !sortedSeasons.isEmpty {
                    seasonSelector
                    episodeList
                }
            }
            .padding()
        }
        .navigationTitle("Series Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let first = sortedSeasons.first {
                selectedSeason = first
            }
        }
    }
    
    @ViewBuilder
    private var seriesHeaderView: some View {
        if let series = viewModel.series {
            if let urlString = series.image?.original, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 200)
                }
            }
            
            Text(series.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text("Airs on \(series.schedule.days.joined(separator: ", ")) at \(series.schedule.time)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if !series.genres.isEmpty {
                Text(series.genres.joined(separator: ", "))
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            if let summary = series.summary?.strippedHTML {
                Text(summary)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    private var sortedSeasons: [Int] {
        Array(viewModel.episodesBySeason.keys).sorted()
    }
    
    private var seasonSelector: some View {
        let seasons = sortedSeasons

        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(seasons, id: \.self) { season in
                    let isSelected = season == selectedSeason

                    Text("Season \(season)")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(isSelected ? Color.accentColor : Color.gray.opacity(0.2))
                        )
                        .foregroundColor(isSelected ? .white : .primary)
                        .onTapGesture {
                            selectedSeason = season
                        }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var episodeList: some View {
        let episodes = viewModel.episodesBySeason[selectedSeason] ?? []
        
        return VStack(alignment: .leading, spacing: 12) {
            ForEach(episodes) { episode in
                EpisodeRowView(episode: episode)
            }
        }
    }
}

#if DEBUG
#Preview("Default") {
    SeriesDetailView(
        viewModel: SeriesDetailViewModel(seriesID: 1, apiClient: AppEnvironment().apiClient)
    )
}

#if TEST
#Preview("With mock data") {
    SeriesDetailView(
        viewModel: SeriesDetailViewModel(seriesID: 1, apiClient: MockAPIClient())
    )
}
#endif

#endif
