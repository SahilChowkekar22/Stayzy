//
//  TripsView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI

struct TripsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                headerSection
                Divider()
                supportSection
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Trips")
                .font(.largeTitle)
                .fontWeight(.bold)

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                Text("No trips booked...yet!")
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("Time to dust off your bags and start planning your next adventure.")
                    .font(.body)
                    .foregroundColor(.gray)

                Button(action: {
                    // TODO: Implement navigation to Explore tab or search
                }) {
                    Text("Start searching")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .foregroundColor(.black)
            }
        }
    }

    // MARK: - Support Section
    private var supportSection: some View {
        Group {
            Text("Can’t find your reservation here? ")
                .font(.footnote)
                .foregroundColor(.gray)
            +
            Text("Visit the Help Center")
                .font(.footnote)
                .fontWeight(.semibold)
                .underline()
        }
    }
}

#Preview {
    TripsView()
}
