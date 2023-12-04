//
//  Models.swift
//  group9
//
//

import Foundation


class Account: ObservableObject, Identifiable, Codable {
    let id = UUID()
    @Published var name: String
    @Published var balance: Double
    @Published var transactions: [Transaction]

    enum CodingKeys: CodingKey {
        case id, name, balance, transactions
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        balance = try container.decode(Double.self, forKey: .balance)
        transactions = try container.decode([Transaction].self, forKey: .transactions)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(balance, forKey: .balance)
        try container.encode(transactions, forKey: .transactions)
    }
    
    // The init for non-decoding purpose
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


struct Transaction: Identifiable, Codable {
    let id = UUID()
    var date: Date
    var amount: Double
    var description: String
    
    enum CodingKeys: CodingKey {
        case id, date, amount, description
    }
    // Computed property to categorize the transaction
    var category: String {
        amount >= 0 ? "deposit" : "withdraw"
    }
}

extension AccountManager {
    // Path for the stored data file
    private var dataFilePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("accounts_data.json")
    }

    // Function to save account data to a file
    func saveAccounts() {
        do {
            let data = try JSONEncoder().encode(accounts)
            try data.write(to: dataFilePath, options: [.atomic])
        } catch {
            print("Error saving accounts data: \(error.localizedDescription)")
        }
    }

    // Function to load account data from a file
    func loadAccounts() {
        do {
            let data = try Data(contentsOf: dataFilePath)
            accounts = try JSONDecoder().decode([Account].self, from: data)
        } catch {
            print("Error loading accounts data: \(error.localizedDescription)")
        }
    }
}

