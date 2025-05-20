//
//  CastCredit.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 19/05/25.
//

struct CastCredit: Codable, Identifiable {
    let show: Series

    private enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }

    private enum EmbeddedKeys: String, CodingKey {
        case show
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let embedded = try container.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: .embedded)
        self.show = try embedded.decode(Series.self, forKey: .show)
    }

    var id: Int { show.id }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var embedded = container.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: .embedded)
        try embedded.encode(show, forKey: .show)
    }
}
