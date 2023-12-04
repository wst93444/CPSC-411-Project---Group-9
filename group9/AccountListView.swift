//
//  AccountsListView.swift
//  group9
//
//

import SwiftUI

struct AccountListView: View {
    @StateObject var accountManager = AccountManager()
    @State private var newAccountName = ""
    @State private var newAccountBalance = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(accountManager.accounts) { account in
                        NavigationLink(destination: TransactionListView(account: account, accountManager: accountManager)) {
                            Text("\(account.name): $\(account.balance, specifier: "%.2f")")
                        }
                    }
                    .onDelete(perform: deleteAccount)
                }
                // ... Input textfield and Add Account button ...
                HStack {
                    TextField("Account Name", text: $newAccountName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Balance", text: $newAccountBalance)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .padding()
                    Button("Add Account") {
                        if let balance = Double(newAccountBalance) {
                            let newAccount = Account(name: newAccountName, balance: balance, transactions: [])
                            accountManager.accounts.append(newAccount)
                            accountManager.saveAccounts()
                            newAccountName = ""
                            newAccountBalance = ""
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Accounts")
            .navigationBarItems(trailing: EditButton()) // Add edit button
        }
    }
    
    // delete account method
    private func deleteAccount(at offsets: IndexSet) {
            accountManager.accounts.remove(atOffsets: offsets)
            accountManager.saveAccounts()
    }
}

class AccountManager: ObservableObject {
    @Published var accounts: [Account] = []

    init() {
        // Here you can load or initialize your account data.
        loadAccounts() // Load existing accounts
        // For example, add some sample account data.
//        let sampleTransactions = [Transaction(date: Date(), amount: -8.99, description: "Netflix Subscription"),
//                                  Transaction(date: Date(), amount: -3.50, description: "Coffee")]
//        let sampleAccount = Account(name: "Checking", balance: 1200.00, transactions: sampleTransactions)
//        accounts.append(sampleAccount)
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView()
    }
}
