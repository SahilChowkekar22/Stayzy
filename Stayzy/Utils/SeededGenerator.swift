//
//  SeededGenerator.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import Foundation

struct SeededGenerator: RandomNumberGenerator {
    init(seed: UInt64) {
        self.state = seed
    }

    private var state: UInt64

    mutating func next() -> UInt64 {
        // Xorshift64* algorithm
        state ^= state >> 12
        state ^= state << 25
        state ^= state >> 27
        return state &* 2685821657736338717
    }
}

