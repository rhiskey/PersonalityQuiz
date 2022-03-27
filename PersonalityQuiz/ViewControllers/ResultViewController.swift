//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Alexey Efimov on 30.08.2021.
//

import UIKit

class ResultViewController: UIViewController {
// MARK: - IBOutlets
    @IBOutlet var youAreLB: UILabel!
    @IBOutlet var descriptionLB: UILabel!
    
    var answers: [Answer]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if let bestMatch = defineMostFrequent() {
            showResults(for: bestMatch)
        }
    }
}

// MARK: - Private Methods
extension ResultViewController {
    private func defineMostFrequent() -> Answer? {
        let character = answers.map { $0.animal.rawValue }.max()
        var result = answers.first
        
        for answer in answers {
            if answer.animal.rawValue == character
            {
                result = answer
            }
        }
        return result
        
        ////  Second approach
        // answers.filteredByMostPopular()
    }
    
    private func showResults(for bestMatch: Answer) {
        youAreLB.text = "Вы - \(bestMatch.animal.rawValue)"
        descriptionLB.text = bestMatch.animal.definition
    }
    
}

extension Array where Element: Equatable {
    func filteredByMostPopular() -> Element? {
        let countedSet = NSCountedSet(array: self)
        return self.max { countedSet.count(for: $0) < countedSet.count(for: $1) }
    }
}
