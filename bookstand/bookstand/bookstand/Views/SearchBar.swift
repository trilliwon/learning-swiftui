//
//  SearchBar.swift
//  bookstand
//
//  Created by won on 2020/08/03.
//  Copyright © 2020 Won. All rights reserved.
//

import SwiftUI

struct SearchBar: View {

	@Binding var text: String

    var body: some View {
		HStack {
			HStack {
				Image(systemName: "magnifyingglass")
					.renderingMode(.template)
					.foregroundColor(Color(.systemGray))

				TextField("Search ...", text: $text)
					.onTapGesture {
						self.isEditing = true
				}

				Button(action: {
					self.text = ""
				}) {
					Image(systemName: "xmark.circle.fill")
						.renderingMode(.template)
						.foregroundColor(Color(.systemGray2))
				}
			}
			.padding(7)
			.padding(.horizontal, 5)
			.background(Color(.systemGray5))
			.cornerRadius(8)
			.padding(.horizontal, 10)

			if isEditing {
				Button(action: {
					self.isEditing = false
					self.text = ""
				}) {
					Text("Cancel")
				}
				.padding(.trailing, 10)
				.transition(.move(edge: .trailing))
				.animation(.default)
			}
		}
	}

	@State private var isEditing = false
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
		SearchBar(text: .constant(""))
    }
}
