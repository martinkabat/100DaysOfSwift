//
//  ViewController.swift
//  Hangman
//
//  Created by Martin Kabát on 03.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var attemptsLabel: UILabel!
    var answersLabel: UILabel!
    var hintsLabel: UILabel!
    var currentAnswer: UITextField!
    var submitButton: UIButton!
    var usedLettersLabel: UILabel!
    
    var rightAnswer: String!
    var usedLetters: [String]! = [] {
        
        didSet {
            var text = "Used words: "
            for letter in usedLetters {
                text.append(" \(letter)")
            }
            usedLettersLabel.text = text
        }
    }
    
    var attempts = 5 {
        didSet {
            attemptsLabel.text = "Remaining attempts: \(attempts)"
            
            if attempts == 0 {
                let ac = UIAlertController(title: "Game over", message: "You are out of attempts!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: {action in
                    self.loadLevel()
                }))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    var level = 1
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemMint
        
        attemptsLabel = UILabel()
        attemptsLabel.translatesAutoresizingMaskIntoConstraints = false
        attemptsLabel.textAlignment = .right
        attemptsLabel.text = "Remaining attempts: \(attempts)"
        view.addSubview(attemptsLabel)
        
        hintsLabel = UILabel()
        hintsLabel.translatesAutoresizingMaskIntoConstraints = false
        hintsLabel.font = UIFont.systemFont(ofSize: 24)
        hintsLabel.textAlignment = .center
        hintsLabel.text = "HINT"
        hintsLabel.numberOfLines = 0
        hintsLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(hintsLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 44)
        answersLabel.text = "??????"
        answersLabel.textAlignment = .center
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Choose a character in the word"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 22)
        view.addSubview(currentAnswer)
        
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        usedLettersLabel = UILabel()
        usedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        usedLettersLabel.font = UIFont.systemFont(ofSize: 20)
        usedLettersLabel.textAlignment = .center
        usedLettersLabel.text = "Used words:"
        usedLettersLabel.numberOfLines = 0
        usedLettersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(usedLettersLabel)
        
        
        NSLayoutConstraint.activate([
            attemptsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            attemptsLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            hintsLabel.topAnchor.constraint(equalTo: attemptsLabel.bottomAnchor, constant: 100),
            hintsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hintsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            answersLabel.topAnchor.constraint(equalTo: hintsLabel.bottomAnchor, constant: 20),
            answersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            currentAnswer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //currentAnswer.topAnchor.constraint(equalTo: answersLabel.bottomAnchor, constant: 100),
            
            submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            usedLettersLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 80),
            usedLettersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usedLettersLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel()
    }
    
    @objc func submitTapped() {
        guard let answeredText = currentAnswer.text else { return }
        
        usedLetters.append(answeredText)
        
        if rightAnswer.contains(answeredText) {
            
        } else {
            attempts -= 1
        }
        
        currentAnswer.text = "" // delete text from input
        
        var promptWord = ""

        for letter in rightAnswer {
            let strLetter = String(letter)

            if usedLetters.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord += "?"
            }
        }
        
        answersLabel.text = promptWord
        
        var questionMarkOccurences = 0
        
        for letter in promptWord {
            let strLetter = String(letter)
            
            if letter == "?" {
                questionMarkOccurences += 1
            }
        }
        
        if questionMarkOccurences == 0 {
            let ac = UIAlertController(title: "You won", message: "You guessed the word!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New game", style: .default, handler: {action in
                self.loadLevel()
            }))
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func loadLevel() {
        attempts = 5
        usedLetters.removeAll()
        var hintString = ""

        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                let line = lines.first // Pick first line
                let parts = line!.components(separatedBy: ": ")
                rightAnswer = parts[0]
                hintString = parts[1]
                
                
                hintsLabel.text = hintString.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Replace characters with question marks
                var answerInQuestionMarks: String = ""
                for _ in 0..<rightAnswer.count {
                    answerInQuestionMarks += "?"
                }
                
                answersLabel.text = answerInQuestionMarks.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        hintsLabel.text = hintString.trimmingCharacters(in: .whitespacesAndNewlines)
    }

}

