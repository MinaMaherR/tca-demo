//
//  APIClient.swift
//  TCAMovieApp
//
//  Created by Mina Maher on 16/02/2023.
//

import Foundation

enum APIError: Error {
    case invalidUrl
}

enum RequestMethod: String {
    case get = "GET"
}

func apiRequest(method: RequestMethod = .get, path: String, queryItems: [URLQueryItem]? = nil) async throws -> Data {
    guard
        var url = URL(string: Constants.baseUrl)
    else {throw APIError.invalidUrl}
    
    url.append(path: path)
    url.append(queryItems: queryItems ?? [])
    var request: URLRequest = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    let headers: [String: String] = [
        Constants.tokenkey: Constants.tokenValue
    ]
    headers.forEach({
        request.setValue($1, forHTTPHeaderField: $0)
    })
    
    let (data, _) = try await URLSession.shared.data(for: request)
    
    logData(url: url, data: data)
    
    return data
}

func pageQueryItem(page: Int) -> URLQueryItem {
    URLQueryItem(name: "page", value: "\(page)")
}

func mapdRequest<DTO: Decodable>(decoder: JSONDecoder = JSONDecoder(), data: Data) async throws -> DTO {
    let decoder = decoder
    return try decoder.decode(DTO.self, from: data)
}

func logData(url: URL, data: Data) {
    #if DEBUG
    print("========= URL=========\n\(url.absoluteString)")
    print("========= response =========\n\(String(describing: String(data: data, encoding: .utf8)))")
    #endif
}
