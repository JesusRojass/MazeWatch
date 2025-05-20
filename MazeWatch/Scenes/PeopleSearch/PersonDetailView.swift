//
//  PersonDetailView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// View displaying details of a person and the shows they've appeared in.
struct PersonDetailView: View {
    let person: Person
    @StateObject private var viewModel: PersonDetailViewModel
    @ObservedObject private var favoriteStorage = FavoriteSeriesStorage.shared

    init(person: Person) {
        self.person = person
        _viewModel = StateObject(wrappedValue: PersonDetailViewModel(personID: person.id))
    }

    var body: some View {
        content
    }

    private var content: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let imageURL = URL(string: person.image?.original ?? "") {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: .infinity)
                             .cornerRadius(12)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 200)
                    }
                }

                Text(person.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

                Text("Series")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)

                if viewModel.isLoading {
                    ProgressView("Loading appearances...")
                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.credits) { credit in
                            NavigationLink(
                                destination: SeriesDetailView(
                                    viewModel: SeriesDetailViewModel(
                                        seriesID: credit.show.id,
                                        apiClient: AppEnvironment().apiClient
                                    )
                                )
                            ) {
                                SeriesCardView(series: credit.show)
                                .padding(.vertical, 4)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadCredits()
        }
    }
}
