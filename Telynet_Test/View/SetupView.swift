//
//  SetupView.swift
//  Telynet_Test
//
//  Created by Eduardo Herrera on 3/8/23.
//

import SwiftUI

struct SetupView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack {
            GroupBox("Opciones") {
                row(label: "Ordenar clientes por",
                    selsection: $viewModel.selectionOrderBy,
                    titles: ["Nombre","Codigo"])
                
                row(label: "Filtrar clientes por",
                    selsection: $viewModel.selectionFilterBy,
                    titles: ["Todos","Visitados","No visitados"])
                
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Ajustes")
    }
    
    private func row(label: String, selsection: Binding<String>, titles: [String]) -> some View {
        HStack {
            Text(label)
            Spacer()
            Picker("", selection: selsection) {
                ForEach(titles, id: \.self) {
                    Text("\($0)")
                        .foregroundColor(.blue)
                }
            }
            .pickerStyle(.menu)
        }
    }
}
