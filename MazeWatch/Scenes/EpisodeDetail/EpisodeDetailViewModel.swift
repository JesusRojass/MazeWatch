//
//  EpisodeDetailViewModel.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

/// ViewModel providing data for a single episode's detail screen.
final class EpisodeDetailViewModel: ObservableObject {
    let episode: Episode

    init(episode: Episode) {
        self.episode = episode
    }
}
