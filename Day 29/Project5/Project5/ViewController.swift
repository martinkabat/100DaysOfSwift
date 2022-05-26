//
//  ViewController.swift
//  Project5
//
//  Created by Martin Kabát on 17.05.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    enum ErrorReason {
        case shortOrSame
        case impossible
        case unoriginal
        case unreal
    }
    
    var allWord = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWord = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWord.isEmpty {
            allWord = ["silkworm"]
        }
        
        startGame()
    }

    @objc func startGame() {
        title = allWord.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isShortOrAsOriginal(word: lowerAnswer) {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        // insert answer to the array
                        usedWords.insert(lowerAnswer, at: 0)
                        
                        // animate inserting row by entering the answer in to the tableView
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                    } else {
                        showErrorMessage(reason: .unreal)
                    }
                } else {
                    showErrorMessage(reason: .unoriginal)
                }
            } else {
                showErrorMessage(reason: .impossible)
            }
        } else {
            showErrorMessage(reason: .shortOrSame)
        }
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false}
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isShortOrAsOriginal(word: String) -> Bool {
        if word == title?.lowercased() {
            return false
        } else if word.count < 4 {
            return false
        }
        else {
            return true
        }
        
    }
    
    func showErrorMessage(reason: ErrorReason) {
        var errorTitle: String
        var errorMessage: String
        
        switch reason {
        case .shortOrSame:
            errorTitle = "Short or same"
            errorMessage = "Word is too short or the same as the original."
        case .impossible:
            guard let title = title else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title.lowercased())"
        case .unoriginal:
            errorTitle = "Word already used"
            errorMessage = "Be more original!"
        case .unreal:
            errorTitle = "Word not recognized"
            errorMessage = "You can't just make them up, you know!"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
