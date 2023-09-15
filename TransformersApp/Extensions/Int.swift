//
//  Int.swift
//  TransformersApp
//
//  Created by capregsoft on 15/09/2023.
//

import Foundation

extension Int {
    
    init(_ range: Range<Int> ) {
        let delta = range.startIndex < 0 ? abs(range.startIndex) : 0
        let min = UInt32(range.startIndex + delta)
        let max = UInt32(range.endIndex   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}
