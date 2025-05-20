//
//  PeopleSearchView.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import SwiftUI

/// View for listing people fetched from the API.
struct PeopleSearchView: View {
    @StateObject private var viewModel = PeopleSearchViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people) { person in
                    NavigationLink(destination: PersonDetailView(person: person)) {
                        HStack(spacing: 12) {
                            AsyncImage(url: URL(string: person.image?.medium ?? "")) { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 60, height: 60)
                                     .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            }

                            Text(person.name)
                                .font(.headline)
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView("Loading more...")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .listStyle(.plain)
            .navigationTitle("People")
            .onAppear {
                viewModel.loadNextPage()
            }
        }
    }
}
