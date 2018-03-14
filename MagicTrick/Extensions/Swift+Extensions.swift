//
//  Swift+Extensions.swift
//  MagicTrick
//
//  Created by Roman Roibu on 14.03.18.
//  Copyright © 2018 Roman Roibu. All rights reserved.
//

extension Bool {

    mutating func toggle() {
        self = !self
    }
}

extension OptionSet where RawValue: FixedWidthInteger {

    static var all: Self { return Self.init(rawValue: RawValue.max) }
}
