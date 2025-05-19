//
//  AppEnvironment.swift
//  MazeWatch
//
//  Created by Jesus Rojas on 18/05/25.
//

import Foundation

final class AppEnvironment: ObservableObject {
    let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient(baseURL: Endpoints.baseURL)) {
        self.apiClient = apiClient
    }
}
