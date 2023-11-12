//
//  ContentView.swift
//  group9
//
//

import SwiftUI

struct ContentView: View {
    @StateObject var accountManager = AccountManager()

    var body: some View {
        AccountListView(accountManager: accountManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AccountManager())
    }
}
