//
//  FullDescriptionModalView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI

struct FullDescriptionModalView: View {
    let description: String?

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("About this space")
                        .font(.title2)
                        .fontWeight(.bold)

                    if let description = description {
                        Text(description)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                    } else {
                        Text("No description available.")
                            .italic()
                            .foregroundColor(.gray)
                    }

                    // Spacer between sections
                    Spacer(minLength: 10)

                    Text("Other things to note")
                        .font(.headline)
                        .fontWeight(.semibold)

                    Text("Linen and towels can be rented for 100kr per person. Electricity consumption is charged after departure at 5.00kr per kWh.")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FullDescriptionModalView(description: """
    Architect-designed summerhouse for the discerning and design-proof guest. Beautiful view of the landscape. Close to the beach.

    Linen and towels can be rented for 100kr per person. Electricity consumption is charged after departure at 5.00kr per kWh.
    """)
}
