//
//  FeedModel.swift
//  Navigation
//
//  Created by Apple Mac Air on 18.01.2023.
//

import Foundation

struct FeedModel {
    var secretWord: String
}

extension FeedModel {
   static var word = FeedModel(secretWord: "Password")
}
