//
//  SearchView.swift
//  bookstand
//
//  Created by won on 2020/08/03.
//  Copyright © 2020 Won. All rights reserved.
//

import SwiftUI

struct SearchView: View {

	var samples = ["Benz", "BMW", "Poche"]

	@State var searchText: String = ""

	var body: some View {
		VStack {
			SearchBar(text: $searchText)
			List {
				ForEach(self.samples, id: \.self) { car in
					Text(car)
				}
			}
			.navigationBarTitle(Text("Search"))
			.resignKeyboardOnDragGesture()
		}
	}
}

struct SearchView_Previews: PreviewProvider {
	static var previews: some View {
		SearchView()
	}
}
