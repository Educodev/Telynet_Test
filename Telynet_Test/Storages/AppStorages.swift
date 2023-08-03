//
//  AppStorages.swift
//  Telynet_Test
//
//  Created by Eduardo Herrera on 3/8/23.
//

import SwiftUI


struct AppStorages {
    @AppStorage("orderBy") static var orderBy = "Nombre"
    @AppStorage("filterBy") static var filterBy = "Todos"
}
