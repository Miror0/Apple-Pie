//
//  ViewController.swift
//  Apple Pie
//
//  Created by Denis Bystruev on 16/11/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = [
        "арбуз",
        "банан",
        "гном",
        "дом",
        "ель",
        "ёж",
        "железная Дорога",
        "часы",
        "курица",
        "человек",
        "ложка"
           ]
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var scores = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
        }
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()// Do any additional setup after loading the view, typically from a nib.
    }
    func newRound () {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            
            currentGame = Game( word: newWord, incorrectMovesRemaining:
                incorrectMovesAllowed,
                                guessedLetters: []
            )
            
            enableLetterButtons(enable: true)
        } else {
            enableLetterButtons(enable: false)
        }
        updateUI()
    
    }
    
    func enableLetterButtons(enable: Bool ) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI () {
        let imageName = "Tree \(currentGame.incorrectMovesRemaining)"
        treeImageView.image = UIImage(named: imageName)
        var letters = [String] ()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpaces = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpaces
        
        scoreLabel.text = "Выигрыши: \(totalWins), проигрышь: \(totalLosses)"
        scoresLabel.text = "очки: \(scores)"
    }
    
    
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }

    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
            
        } else if currentGame.word ==
            currentGame.formattedWord {
            totalWins += 1
            scores += 10
        } else {
           updateUI()
        }
        
    }
}

