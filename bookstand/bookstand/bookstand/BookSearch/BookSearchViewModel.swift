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
    @Published var searchTarget: Int = 0

    private let searchProvider = BookSearchProvider()
    private var cancelables = Set<AnyCancellable>()

    func isLast(_ book: Book) -> Bool {
        books.last == book
    }

    init() {
        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .combineLatest($searchTarget)
            .flatMap { [unowned self] (query, searchTarget) -> AnyPublisher<[Book], Never> in
                if query.isEmpty {
                    return Result.Publisher([]).eraseToAnyPublisher()
                }
                return self.performQuery(query, searchTarget).map(\.documents).eraseToAnyPublisher()
            }
            .assign(to: \.books, on: self)
            .store(in: &cancelables)
    }

    func performQuery(_ query: String, _ searchTarget: Int = 0) -> AnyPublisher<Documents, Never> {
        let target = BookSearchProvider.Target.allCases[searchTarget]
        return searchProvider
            .request(endpoint: .search(target), params: ["query": query])
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
