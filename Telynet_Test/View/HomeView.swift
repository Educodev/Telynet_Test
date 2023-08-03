//
//  HomeView.swift
//  Telynet_Test
//
//  Created by Eduardo Herrera on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var showUpButton = false
    @State var goUp = false
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            NavigationView {
                //customers list
                ScrollViewReader { proxy in
                    let accounts = viewModel.searchText.isEmpty ? viewModel.accounts : viewModel.searchResults
                    
                    List(Array(accounts.enumerated()), id: \.offset) {index, customer in
                        DisclosureGroup {
                            HStack {
                                Text(customer.phone)
                                    .font(.caption)
                                Spacer()
                                Button {
                                    //open app phone and call.
                                    UIApplication.shared.open(URL(string: "tel://"+customer.phone)!)
                                } label: {
                                    Image(systemName: "phone.circle.fill")
                                        .imageScale(.large)
                                }
                                .buttonStyle(.borderless)
                                
                            }
                            Text(!customer.email.isEmpty ? customer.email : "Sin correo" )
                                .font(.caption)
                            
                            //Contacts view
                            NavigationLink {
                                ContactsView(codeAccount: customer.code)
                                
                            } label: {
                                Label("Contactos", systemImage: "person.crop.circle.badge")
                            }
                            
                        } label: {
                            HStack {
                                Text(customer.name)
                                Spacer()
                                Text(String(customer.code))
                            }
                        }
                        .onAppear {
                            if index >= 20 {
                                showUpButton = true
                            } else {
                                showUpButton = false
                            }
                        }
                        .onChange(of: goUp, perform: { newValue in
                            withAnimation {
                                if newValue {
                                    proxy.scrollTo(0, anchor: .top)
                                    goUp = false
                                }
                            }
                        })
                        
                    }
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                    .searchable(text: $viewModel.searchText)
                    .navigationTitle("Cuentas")
                    .toolbar {
                        NavigationLink {
                            SetupView()
                        } label: {
                            Image(systemName: "gear.badge")
                        }
                        
                    }
                    
                }
            }
            
            if showUpButton {
                Button {
                        goUp.toggle()
                } label: {
                    Image(systemName: "chevron.up")
                        .padding()
                        .background(.gray.opacity(0.8))
                        .clipShape(Circle())
                        .padding()
                }
            }
        }
    }
}


