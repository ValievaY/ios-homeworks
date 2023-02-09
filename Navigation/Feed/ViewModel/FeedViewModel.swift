//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Apple Mac Air on 05.02.2023.
//

import UIKit

class FeedViewModel {
    
    var wordDidEntered: ((FeedViewModel) -> ())?
    
    var checkResult: UIColor? {
        didSet {
            self.wordDidEntered?(self)
        }
    }
    
    func check(_ word: String) {
        if word == FeedModel.word.secretWord {
            checkResult = .systemGreen
        } else {
            checkResult = .systemRed
        }
    }
}
