//
//  FavoritesViewModel.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation
import Combine
import CoreData

final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoriteSeries] = []
    private let storage: FavoriteSeriesStorage

    init(storage: FavoriteSeriesStorage = FavoriteSeriesStorage()) {
        self.storage = storage
        loadFavorites()
    }

    func loadFavorites() {
        favorites = storage.getAllFavoritesSorted()
    }

    func removeFavorite(id: Int) {
        storage.remove(seriesID: id)
        loadFavorites()
    }
}
