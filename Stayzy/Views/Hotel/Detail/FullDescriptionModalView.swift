//
//  FullDescriptionModalView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI

// A modal view that shows a scrollable detailed description of the hotel,
// along with any additional notes (e.g. linens, electricity fees, etc).
struct FullDescriptionModalView: View {
    let description: String?

    // Environment property to dismiss the modal view
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Section Title
                    Text("About this space")
                        .font(.title2)
                        .fontWeight(.bold)

                    // Main Description Content
                    if let description = description {
                        Text(description)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                    } else {
                        // Fallback if no description was passed in
                        Text("No description available.")
                            .italic()
                            .foregroundColor(.gray)
                    }

                    // Spacer between sections
                    Spacer(minLength: 10)

                    // Additional Notes Section
                    Text("Other things to note")
                        .font(.headline)
                        .fontWeight(.semibold)

                    Text("Linen and towels can be rented for 100kr per person. Electricity consumption is charged after departure at 5.00kr per kWh.")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                }
                .padding()
            }
            // Navigation Bar Setup
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
