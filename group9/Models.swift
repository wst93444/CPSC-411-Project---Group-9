//
//  Models.swift
//  group9
//
//

import Foundation

class Account: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String
    @Published var balance: Double
    @Published var transactions: [Transaction]

    init(name: String, balance: Double, transactions: [Transaction]) {
        self.name = name
        self.balance = balance
        self.transactions = transactions
    }
    
    // Computed property to calculate the current balance based on transactions
    var currentBalance: Double {
        transactions.reduce(balance) { $0 + $1.amount }
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    var date: Date
    var amount: Double
    var description: String
}
