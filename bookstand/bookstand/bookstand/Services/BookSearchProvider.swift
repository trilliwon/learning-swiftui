//
//  BookSearchAPI.swift
//  bookstand
//
//  Created by Won on 2019/09/26.
//  Copyright © 2019 Won. All rights reserved.
//

import Foundation
import Combine

struct BookSearchProvider {

	let baseURL = URL(string: "https://dapi.kakao.com/v3")!
	let apiKey = "KakaoAK 57ee879cb839006ba4c51db31d1b7d99"

	static let shared = BookSearchProvider()

	enum Target: String {
		case title
		case isbn
		case publisher
		case person
	}

	enum APIError: Error {
		case invalidInfo
		case noResponse
		case jsonDecodingError(error: Error)
		case networkError(error: Error)
	}

	enum Endpoint {
		case search(Target)

		var path: String {
			switch self {
			case .search(let target):
				return "search/book?target=\(target.rawValue)"
			}
		}

		var method: HTTPMethod {
			switch self {
			case .search:
				return .get
			}
		}
	}

	func request<Response>(endpoint: Endpoint, params: [String: String]? = nil) -> AnyPublisher<Response, APIError> where Response : Decodable {
		let queryURL = baseURL.appendingPathComponent(endpoint.path)
		var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
		components.queryItems = [
			URLQueryItem(name: "Authorization", value: apiKey),
		]

		for param in (params ?? [:]) {
			components.queryItems?.append(URLQueryItem(name: param.key, value: param.value))
		}
		guard let url = components.url else { fatalError() }

		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.rawValue
		let decorder = JSONDecoder()
		decorder.keyDecodingStrategy = .convertFromSnakeCase

		return URLSession.shared.dataTaskPublisher(for: request)
			.map { $0.0 }
			.decode(type: Response.self, decoder: decorder)
			.mapError(APIError.jsonDecodingError)
			.receive(on: RunLoop.main)
			.eraseToAnyPublisher()
	}
}
