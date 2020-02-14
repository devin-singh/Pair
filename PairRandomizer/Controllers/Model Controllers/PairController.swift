//
//  PairController.swift
//  PairRandomizer
//
//  Created by Devin Singh on 2/14/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation

class PairController {
    
    // MARK: - Properties
    
    var allData: [String] = ["John", "Devin", "Max", "Bob", "Hi", "Test", "Tom"]
    
    var dataHolder: [String] = []
    
    var sortedPairs: [Pair] = []
    
    // MARK: - Singleton
    
    static let shared = PairController()
    
    // Privte Init
   
    private init() {
        self.dataHolder = allData
    }
    
    // MARK: - Private Functions
    
    func sortIntoPairs() {
        
        PairController.shared.sortedPairs = []
        
        
           allData = dataHolder
        
        
        var randomIndex = Int.random(in: 0 ... (allData.count - 1))
        
        var lastPair: Pair?
        
        if allData.count % 2 == 1 {
            lastPair = Pair(firstPerson: allData[randomIndex], secondPerson: nil)
            allData.remove(at: randomIndex)
            guard let lastPair = lastPair else { return }
            sortedPairs.insert(lastPair, at: 0)
        }
        
        // Now we have an even amount of data remaining
        
        for _ in allData {
            randomIndex = Int.random(in: 0...(allData.count - 1))
            let pairToAdd = Pair(firstPerson: allData[randomIndex], secondPerson: nil)
            allData.remove(at: randomIndex)
            // Now time to get a new random index and add this new person to the pair object
            randomIndex = Int.random(in: 0...(allData.count - 1))
            pairToAdd.secondPerson = allData[randomIndex]
            allData.remove(at: randomIndex)
            // Now we have two people in our pair object and they are removed from the main array.
            
            // We need to add this newly created pair to the array of pairs.
            sortedPairs.insert(pairToAdd, at: 0)
            
            // Problem. We are removing from the array inside the for loop twice. We only want to do this if there are 2 or more elements remaining. If there are less than 2, return.
            if allData.count < 2 {
                return
            }
        }
        
        
        
    }
    
}
