//
//  Card.swift
//  BlackJack
//
//  Created by HsiaoHsien Huang on 2018/8/11.
//  Copyright © 2018年 HsiaoHsien Huang. All rights reserved.
//
import UIKit
import Foundation

var random: [String] = []

struct Card {
    static var CardIndex: Int! = 0
    static var BankHasA: Bool! = false
    static var PlayerHasA: Bool! = false
}

let CardDB: [String] = ["sA", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "sX", "sJ", "sQ", "sK", "hA", "h2", "h3", "h4", "h5", "h6", "h7", "h8", "h9", "hX", "hJ", "hQ", "hK", "dA", "d2", "d3", "d4", "d5", "d6", "d7", "d8", "d9", "dX", "dJ", "dQ", "dK", "cA", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "cX", "cJ", "cQ", "cK"]

func RandomCard() {
    random = CardDB
    random = random.shuffled()
}

func CardImage(Index: Int) -> UIImage {
    let Image = String(random[Index])
    let IndexImage = UIImage(named: "\(Image)")
    return IndexImage!
}
