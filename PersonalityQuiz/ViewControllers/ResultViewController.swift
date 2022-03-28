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
        
        navigationItem.hidesBackButton = true
        
        defineMostFrequent()
    }
}

// MARK: - Private Methods
extension ResultViewController {
    private func defineMostFrequent(){
        // First approach
        /*
        let character = answers.map { $0.animal.rawValue }.max()
        var result = answers.first
        
        for answer in answers {
            if answer.animal.rawValue == character
            {
                result = answer
            }
        }
        return result
        */
        
        // Second approach
        // return answers.filteredByMostPopular()
        
        // Alexey Efimov
        
        //        var frequencyOfAnimals: [Animal: Int] = [:]
        //        let animals = answers.map { $0.animal }
        
        /*
         for animal in animals {
         if let animalTypeCount = frequencyOfAnimals[animal] {
         frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
         } else {
         frequencyOfAnimals[animal] = 1
         }
         }
         */
        
        //        for animal in animals {
        //            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
        //        }
        
        //        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        //        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        // Решение в одну строку:
        let mostFrequencyAnimal = Dictionary(grouping: answers) { $0.animal }
            .sorted { $0.value.count > $1.value.count }
            .first?.key
        showResults(for: mostFrequencyAnimal)
    }
    
    private func showResults(for animal: Animal?) {
        youAreLB.text = "Вы - \(animal?.rawValue ?? "🐶")!"
        descriptionLB.text = animal?.definition
    }
    
}

extension Array where Element: Equatable {
    func filteredByMostPopular() -> Element? {
        let countedSet = NSCountedSet(array: self)
        return self.max { countedSet.count(for: $0) < countedSet.count(for: $1) }
    }
}
