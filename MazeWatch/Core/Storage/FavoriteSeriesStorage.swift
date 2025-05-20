//
//  FavoriteSeriesStorage.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 19/05/25.
//

import Foundation
import CoreData

/// Manages storing and retrieving favorite series in Core Data.
final class FavoriteSeriesStorage: ObservableObject {
    static let shared = FavoriteSeriesStorage()
    private let context: NSManagedObjectContext
    @Published private(set) var favorites: [FavoriteSeries] = []

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        self.favorites = getAllFavoritesSorted()
    }

    func add(series: Series) {
        let favorite = FavoriteSeries(context: context)
        favorite.id = Int64(series.id)
        favorite.name = series.name
        favorite.genres = (series.genres ?? []).joined(separator: ",")
        favorite.network = series.network?.name
        favorite.premiered = series.premiered
        favorite.imageURL = series.image?.medium
        save()
    }

    func remove(seriesID: Int) {
        let fetch: NSFetchRequest<FavoriteSeries> = FavoriteSeries.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %d", seriesID)

        if let result = try? context.fetch(fetch).first {
            context.delete(result)
            save()
        }
    }

    func getAllFavoritesSorted() -> [FavoriteSeries] {
        let fetch: NSFetchRequest<FavoriteSeries> = FavoriteSeries.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor(keyPath: \FavoriteSeries.name, ascending: true)]
        return (try? context.fetch(fetch)) ?? []
    }

    func isFavorite(seriesID: Int) -> Bool {
        let fetch: NSFetchRequest<FavoriteSeries> = FavoriteSeries.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %d", seriesID)
        return (try? context.count(for: fetch)) ?? 0 > 0
    }

    private func save() {
        if context.hasChanges {
            try? context.save()
            favorites = getAllFavoritesSorted()
        }
    }

    func toggleFavorite(for series: Series) {
        if isFavorite(seriesID: series.id) {
            remove(seriesID: series.id)
        } else {
            add(series: series)
        }
    }
}
