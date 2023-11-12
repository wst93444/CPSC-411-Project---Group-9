//
//  TransactionsListView.swift
//  group9
//
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var account: Account
    @State private var newTransactionDescription = ""
    @State private var newTransactionAmount = ""

    var body: some View {
        List {
            Section(header: Text("Add New Transaction").font(.headline)) {
                HStack {
                    TextField("Description", text: $newTransactionDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Amount", text: $newTransactionAmount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    Button(action: addTransaction) {
                        Text("Add")
                    }
                }
                .padding()
            }
            
            Section(header: Text("Current Balance: \(account.currentBalance, specifier: "%.2f")")) {
                ForEach(account.transactions) { transaction in
                    HStack {
                        Text(transaction.description)
                        Spacer()
                        Text("\(transaction.amount, specifier: "%.2f")")
                    }
                }
            }
//
//            Section(header: Text("Transactions")) {
//                ForEach(account.transactions) { transaction in
//                    Text("\(transaction.description): $\(transaction.amount, specifier: "%.2f")")
//                }
//                .onDelete(perform: deleteTransaction)
//            }
        }
        .listStyle(GroupedListStyle())
        //.navigationTitle(Text("Transactions for \(account.name)").font(.system(size: 14)))
        .navigationBarTitle(Text("Transactions for \(account.name)").font(.system(size: 14)), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
    }

    // add transaction method
    private func addTransaction() {
        if let amount = Double(newTransactionAmount), !newTransactionDescription.isEmpty {
            let newTransaction = Transaction(date: Date(), amount: amount, description: newTransactionDescription)
            account.transactions.append(newTransaction)
            newTransactionDescription = ""
            newTransactionAmount = ""
        }
    }
    
    // delete transaction method
    private func deleteTransaction(at offsets: IndexSet) {
        account.transactions.remove(atOffsets: offsets)
    }
}


struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(account: Account(name: "Sample", balance: 0.0, transactions: []))
    }
}
