//
//  BookSearchView.swift
//  bookstand
//
//  Created by won on 2020/08/03.
//  Copyright © 2020 Won. All rights reserved.
//

import SwiftUI

struct BookSearchView: View {

    @ObservedObject var viewModel = BookSearchViewModel()

    var body: some View {
        ZStack {

            if viewModel.query.isEmpty {
                Text("Search Any Books 📚")
            }

            VStack {
                SearchBar(text: $viewModel.query)
                    .padding()
                List {
                    ForEach(viewModel.books, id: \.title) { book in
                        BookRow(
                            book: book,
                            imageLoader: ImageLoaderCache.shared.loaderFor(path: book.thumbnail)
                        )
                    }
                }
                .resignKeyboardOnDragGesture()
                .navigationBarTitle(Text("Search"))
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView()
    }
}
