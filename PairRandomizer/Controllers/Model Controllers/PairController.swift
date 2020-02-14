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
        //loadFromPersistentStorage()
        //loadPersistentPairsIntoDataHolder()
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
        //saveToPersistantStore()
    }
    
    func deleteData(data: String) {
        guard let index = dataHolder.firstIndex(of: data) else { return }
        dataHolder.remove(at: index)
        for (i, pair) in sortedPairs.enumerated() {
            if pair.firstPerson == data {
                sortedPairs[i].firstPerson = nil
            } else if pair.secondPerson == data {
                sortedPairs[i].secondPerson = nil
            }
        }
        //saveToPersistantStore()
    }
    
    func deleteEmptyPairs() {
        for (i, pair) in sortedPairs.enumerated() {
            if pair.firstPerson == nil && pair.secondPerson == nil {
                sortedPairs.remove(at: i)
            }
        }
        //saveToPersistantStore()
    }
    
     // MARK: - Persistence
    
//    func createFileForPersistence() -> URL {
//        // Grab the users Document directory
//        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        // Create the new fileURL on the users Phone
//         let fileUrl = urls[0].appendingPathComponent("Pairs2.json")
//         return fileUrl
//     }
//
//    func saveToPersistantStore() {
//        // Create an instance of JSONEncoder
//        let jsonEncoder = JSONEncoder()
//        // Attempt to convert our playlist array into JSON
//        // Anytime a method throws, it must be placed in a do, try, catch block
//        do {
//            let jsonPairs = try jsonEncoder.encode(sortedPairs)
//            //let jsonHolder = try jsonEncoder.encode(dataHolder)
//            // With the new JSON(d) playlist arraay, save it to the users device
//            try jsonPairs.write(to: createFileForPersistence())
//            //try jsonHolder.write(to: createFileForPersistence())
//        } catch let encodingError {
//            print("There was an error saving the data! \(encodingError)")
//        }
//    }
//
//    func loadFromPersistentStorage() {
//        let jsonDecoder = JSONDecoder()
//        do {
//            let jsonData = try Data(contentsOf: createFileForPersistence())
//            let decodedPairs = try jsonDecoder.decode([Pair].self, from: jsonData)
//            //let decodedDataHolder = try jsonDecoder.decode([String].self, from: jsonData)
//            self.sortedPairs = decodedPairs
//            //self.dataHolder = decodedDataHolder
//        } catch let decodingError {
//            print("Error loading data \(decodingError)")
//        }
//    }
//
//    func loadPersistentPairsIntoDataHolder() {
//        for pair in sortedPairs {
//            if let firstPerson = pair.firstPerson {
//                self.dataHolder.append(firstPerson)
//            }
//            if let secondPerson = pair.secondPerson {
//                self.dataHolder.append(secondPerson)
//            }
//        }
//    }

    
}
