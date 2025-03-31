// SearchBar.swift
import SwiftUI

// A reusable search bar component with rounded corners and SF Symbol
struct SearchBar: View {
    // Two-way binding for search text input
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var placeholder: String = "Where are you going?"

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            // Search input field
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .foregroundColor(.primary)
                .disableAutocorrection(true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(30)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#Preview {
    SearchBarPreview()
}

// A container to preview the SearchBar with testable state
struct SearchBarPreview: View {
    @State private var searchText = ""

    var body: some View {
        SearchBar(text: $searchText)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
