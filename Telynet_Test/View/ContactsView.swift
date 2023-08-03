//
//  ContactsView.swift
//  Telynet_Test
//
//  Created by Eduardo Herrera on 3/8/23.
//

import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var showInfo = false
    let codeAccount: Int
    
    var body: some View {
        List(viewModel.model.getContacts(codeAccount)) { contact in
            
            DisclosureGroup(isExpanded: $showInfo) {
                HStack {
                    Text("Presupuesto:")
                    Spacer()
                    Text(String(contact.budget))
                }
                .fontWeight(.light)
            } label: {
                HStack {
                    Text(contact.name)
                    Spacer()
                    Text(String(contact.code))
                }
            }
            
        }
        .navigationTitle("Contactos")
        .onAppear {
            
        }
        .toolbar {
            Button {
                showInfo.toggle()
            } label: {
                HStack {
                    Text("Expandir")
                    Image(systemName: showInfo ?
                          "eye" : "eye.slash")
                }
            }
            
        }
    }
    
}


