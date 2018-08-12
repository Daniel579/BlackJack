//
//  Score.swift
//  BlackJack
//
//  Created by HsiaoHsien Huang on 2018/8/11.
//  Copyright © 2018年 HsiaoHsien Huang. All rights reserved.
//

import Foundation

func Score(Name: String, Index: Int) -> Int {
//    var cardName = random[Index].endIndex
    var cardName = random[Index].removeLast()

    var tempscore: Int = 0
    switch cardName {
    case "2":
        tempscore = 2
        return tempscore
    case "3":
        tempscore = 3
        return tempscore
    case "4":
        tempscore = 4
        return tempscore
    case "5":
        tempscore = 5
        return tempscore
    case "6":
        tempscore = 6
        return tempscore
    case "7":
        tempscore = 7
        return tempscore
    case "8":
        tempscore = 8
        return tempscore
    case "9":
        tempscore = 9
        return tempscore
    case "X":
        tempscore = 10
        return tempscore
    case "J":
        tempscore = 10
        return tempscore
    case "Q":
        tempscore = 10
        return tempscore
    case "K":
        tempscore = 10
        return tempscore
    case "A":
        tempscore = 11
        if Name == "Player" {
            Card.PlayerHasA = true
        } else {
            Card.BankHasA = true
        }        
        return tempscore
    default:
        tempscore = 1100
        return 1100
    }
}

