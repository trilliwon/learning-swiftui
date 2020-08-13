//
//  BookSearchViewModel.swift
//  bookstand
//
//  Created by won on 2020/08/13.
//  Copyright © 2020 Won. All rights reserved.
//

import Foundation
import Combine

class BookSearchViewModel: ObservableObject {

    @Published var books = [Book]()
    @Published var query: String = "우주"

    private let searchProvider = BookSearchProvider()
    private var cancelables = Set<AnyCancellable>()

    init() {
        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .flatMap { [unowned self] query -> AnyPublisher<[Book], Never> in
                if query.isEmpty {
                    return Result.Publisher([]).eraseToAnyPublisher()
                }
                return self.performQuery(query).map(\.documents).eraseToAnyPublisher()
            }
            .assign(to: \.books, on: self)
            .store(in: &cancelables)
    }

    func performQuery(_ query: String) -> AnyPublisher<Documents, Never> {
        searchProvider
            .request(endpoint: .search(.title), params: ["query": query])
            .catch { error -> Empty<Documents, Never> in
                fatalError("\(error)")
            }
            .eraseToAnyPublisher()
    }
}

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}
