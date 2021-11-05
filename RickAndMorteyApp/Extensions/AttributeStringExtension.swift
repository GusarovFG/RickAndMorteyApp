//
//  AtributeStringExtantion.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 26.10.2021.
//

import Foundation

extension NSAttributedString {

    static func makeHyperlink(for path: String, in string: String, as substring: String) -> NSAttributedString {

        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributetString = NSMutableAttributedString(string: string)
        attributetString.addAttribute(.link, value: path, range: substringRange)

        return attributetString
    }
}
