import SwiftUI

/// Displays detailed information about a single episode.
struct EpisodeDetailView: View {
    @StateObject private var viewModel: EpisodeDetailViewModel

    init(viewModel: EpisodeDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let urlString = viewModel.episode.image?.original, let url = URL(string: urlString) {
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

                Text(viewModel.episode.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Season \(viewModel.episode.season) · Episode \(viewModel.episode.number)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if let summary = viewModel.episode.summary?.strippedHTML {
                    Text(summary)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
        }
        .navigationTitle("Episode")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Previews
#if DEBUG
#Preview("Default") {
    NavigationView {
        EpisodeDetailView(
            viewModel: EpisodeDetailViewModel(
                episode: Episode(
                    id: 1,
                    name: "Mock Episode",
                    season: 2,
                    number: 5,
                    summary: "<p>This is a <b>mock</b> episode summary.</p>",
                    image: .init(medium: nil, original: nil)
                )
            )
        )
    }
}

#if TEST
#Preview("With Mock Data") {
    NavigationView {
        EpisodeDetailView(
            viewModel: EpisodeDetailViewModel(
                episode: MockAPIClient().mockEpisodes.first!
            )
        )
        .environmentObject(AppEnvironment(apiClient: MockAPIClient()))
    }
}
#endif
#endif
