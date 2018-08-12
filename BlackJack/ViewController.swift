//
//  ViewController.swift
//  BlackJack
//
//  Created by HsiaoHsien Huang on 2018/8/11.
//  Copyright © 2018年 HsiaoHsien Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var BankScore: Int = 0
    var BankImage: [String] = []
    var PlayerScore: Int = 0
    var PlayerImage: [String] = []
    var BankCurrentIndex: Int = 0
    var PlayerCurrentIndex: Int = 0
    var BankCard: String?
    var PlayerCard: String?
    var PlayerCardHidden: Bool = true
    var PlayerMoney: Int = 5000
    var Bet:Int = 0


    @IBOutlet var PlayerCardColletion: [UIImageView]!
    @IBOutlet var BankCardCollection: [UIImageView]!
    @IBOutlet weak var DealButton: UIButton!
    @IBOutlet weak var HitButton: UIButton!
    @IBOutlet weak var OpenCardButton: UIButton!
    @IBOutlet weak var NewGameButton: UIButton!
    @IBOutlet weak var BankScoreTextField: UITextField!
    @IBOutlet weak var PlayerScoreTextField: UITextField!
    
    @IBOutlet weak var MoneySlider: UISlider!
    @IBOutlet weak var MoneyLabel: UILabel!
    @IBOutlet weak var PlayerMoneyTextField: UITextField!
    
    @IBAction func BetAdjustment(_ sender: UISlider) {
        MoneySlider.maximumValue = Float(PlayerMoney)
        MoneyLabel.text = String(format:"%.f", MoneySlider.value)
        Bet = Int(MoneyLabel.text!)!
    }
    @IBAction func Deal(_ sender: UIButton) {
        DealAll()
        DealButton.isEnabled = false
        HitButton.isEnabled = true
        OpenCardButton.isEnabled = true
        NewGameButton.isEnabled = false
        MoneySlider.isEnabled = false
        
        BankScoreTextField.text = "??"
        PlayerScoreTextField.text = String(PlayerScore)
        
    }
    
    @IBAction func Hit(_ sender: UIButton) {
        PlayerDeal()
        if PlayerScore > 21 {
            if Card.PlayerHasA {
                PlayerScore = PlayerScore - 10
                Card.PlayerHasA = false
            } else {
                HitButton.isEnabled = false
            }
        }
        PlayerScoreTextField.text = String(PlayerScore)
    }
    
    @IBAction func OpenCard(_ sender: UIButton) {
        DealButton.isEnabled = false
        HitButton.isEnabled = false
        OpenCardButton.isEnabled = false
        NewGameButton.isEnabled = true
        PlayerCardColletion[0].image = UIImage(named: "\(PlayerCard!)")
        BankCardCollection[0].image = UIImage(named: "\(BankCard!)")
        BankScoreTextField.text = String(BankScore)
        
        if PlayerScore > 21 {
            PlayerMoney = PlayerMoney - Bet
            PlayerMoneyTextField.text = "\(String(PlayerMoney))"
        }else{
            show()
        }
    }
    
    @IBAction func NewGame(_ sender: UIButton) {
        RandomCard()
        AllHidden()
        PlayerScore = 0
        BankScore = 0
        DealButton.isEnabled = true
        HitButton.isEnabled = false
        OpenCardButton.isEnabled = false
        NewGameButton.isEnabled = false
        MoneySlider.isEnabled = true
        PlayerMoneyTextField.text = "\(String(PlayerMoney))"
    }
    
    @IBAction func LookCard(_ sender: UIButton) {
        if PlayerCardHidden {
            PlayerCardColletion[0].image = UIImage(named: "\(PlayerCard!)")
            PlayerCardHidden = false
        }else{
            PlayerCardColletion[0].image = UIImage(named: "PokerBack")
            PlayerCardHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlayerMoneyTextField.text = "\(String(PlayerMoney))"
        MoneyLabel.text = "\(String(PlayerMoney))"
        RandomCard()
        AllHidden()

        DealButton.isEnabled = true
        HitButton.isEnabled = false
        OpenCardButton.isEnabled = false
        NewGameButton.isEnabled = false
    }
    
    func AllHidden() {
        PlayerCardColletion[0].isHidden = true
        PlayerCardColletion[1].isHidden = true
        PlayerCardColletion[2].isHidden = true
        PlayerCardColletion[3].isHidden = true
        PlayerCardColletion[4].isHidden = true
        PlayerCardColletion[5].isHidden = true
        BankCardCollection[0].isHidden = true
        BankCardCollection[1].isHidden = true
        BankCardCollection[2].isHidden = true
        BankCardCollection[3].isHidden = true
        BankCardCollection[4].isHidden = true
        BankCardCollection[5].isHidden = true
    }
    
    func PlayerDeal() {
        PlayerCardColletion[PlayerCurrentIndex].isHidden = false
        if PlayerCurrentIndex == 0 {
            PlayerCard = random[Card.CardIndex]
            PlayerCardColletion[PlayerCurrentIndex].image = UIImage(named: "PokerBack")
        } else {
            PlayerCardColletion[PlayerCurrentIndex].image = CardImage(Index: Card.CardIndex)
        }
        PlayerScore = (PlayerScore) + Score(Name: "Player", Index: Card.CardIndex)
        PlayerCurrentIndex += 1
        Card.CardIndex += 1
    }
    
    func BankDeal() {
        BankCardCollection[BankCurrentIndex].isHidden = false
        if BankCurrentIndex == 0 {
            BankCard = random[Card.CardIndex]
            BankCardCollection[BankCurrentIndex].image = UIImage(named: "PokerBack")
        } else {
            BankCardCollection[BankCurrentIndex].image = CardImage(Index: Card.CardIndex)
        }
        BankScore = (BankScore) + Score(Name: "Bank", Index: Card.CardIndex)
        BankCurrentIndex += 1
        Card.CardIndex += 1
    }
    
    func DealAll() {
        BankCurrentIndex = 0
        PlayerCurrentIndex = 0
        PlayerCardHidden = true
        AllHidden()
        
        BankDeal()
        PlayerDeal()
        BankDeal()
        PlayerDeal()
    }
    
    func show() {
        
        while BankScore < 17 || BankScore < PlayerScore || BankScore > 21 {
            if BankScore > 21 {
                if Card.BankHasA {
                    BankScore = BankScore - 10
                    Card.BankHasA = false
                }
                if BankScore < 21 {
                    BankDeal()
                    BankScoreTextField.text = String(BankScore)
                }
            }
            
            if BankScore > 17, BankScore >= PlayerScore {
                break
            }else {
                if BankScore < 21 {
                BankDeal()
                BankScoreTextField.text = String(BankScore)
                }
            }
        }
        
        if (BankScore > 21 || BankScore < PlayerScore), !Card.BankHasA {
            PlayerMoney = PlayerMoney + Bet
            PlayerMoneyTextField.text = "\(String(PlayerMoney))"
        }
        
        if BankScore >= PlayerScore, BankScore <= 21 {
            PlayerMoney = PlayerMoney - Bet
            PlayerMoneyTextField.text = "\(String(PlayerMoney))"
        }
    }

}

