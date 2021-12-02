//
//  HistoryManager.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 01.12.2021.
//

import Foundation



final class HistoryManager {
    
 static let shared = HistoryManager()
    
    private let defaults = UserDefaults.standard
    private let historyKey = "searchRequests"
    private var requestTitles = NSMutableOrderedSet()
    
    private init() {
        let requestArray = defaults.object(forKey: historyKey) as? [String] ?? []
        requestTitles.addObjects(from: requestArray)
    }
    
    func saveHistory(for inputText: String) {
        if requestTitles.contains(inputText) {
            relocateSameElementToEnd(inputText)
        } else {
        requestTitles.add(inputText)
        defaults.set(requestTitles.array, forKey: historyKey)
        }
    }
    
    func fetchHistory() -> [String] {
        requestTitles.array as? [String] ?? []
    }
    
    private func relocateSameElementToEnd(_ inputText: String) {
        let index = requestTitles.index(of: inputText)
        let movedObjectIndexes = NSMutableIndexSet()
        movedObjectIndexes.add(index)
        requestTitles.moveObjects(at: movedObjectIndexes as IndexSet, to: requestTitles.count - 1)
    }
}
