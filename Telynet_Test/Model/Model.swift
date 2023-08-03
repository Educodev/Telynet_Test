//
//  Model.swift
//  Telynet_Test
//
//  Created by Eduardo Herrera on 3/8/23.
//


import Foundation
import SQLite

struct Model {
    
    //accounts with mapped values
    var accounts: [Account] {
        return mapAccounts()
        
    }
    
    // contacts with mapped values
    func getContacts(_ codeAccount: Int) -> [Contact]  {
        return mapContacts(id: codeAccount)
    }
    
    //account mapping
    func mapAccounts() -> [Account] {
        if let dataFromDB = SQLManager.shared.acounts {
            return dataFromDB.map({ acount in
                Account(id: Int(acount[Expression<Int64>("code")]),
                        code: Int(acount[Expression<Int64>("code")]),
                        name: acount[Expression<String>("name1")],
                        phone: acount[Expression<String>("phone1")],
                        email: acount[Expression<String>("e_mail")],
                        visited: acount[Expression<String>("code_status")])
            })
        }
        
        return []
    }
    
    
    //contact mapping
    func mapContacts(id: Int) -> [Contact] {
        // get account code to use as id to get "budget"
        let codeContact = SQLManager.shared.getValueFromRelation(value: Expression<Int64>("code_contact"),
                                                                 from: SQLManager.shared.contactsAccounts!,
                                                                 relationValue: id,
                                                                 relationKey: "code_account")
        
        //get 'budget' using the 'contact_id' as relation value
        let budget = SQLManager.shared.getValueFromRelation(value: Expression<Int64>("budget"),
                                                            from: SQLManager.shared.contactsBudget!,
                                                            relationValue: Int(codeContact ?? 0),
                                                            relationKey: "code_contact")
        
        //check that the sequence 'contacts' is not nil
        if let dataFromDB = SQLManager.shared.contacts {
            
            //
            //table filter containing the columns related to the 'code_ofclient'
            //then contact mapping
            return dataFromDB.filter({$0[Expression<String>("code_ofclient")] == String(codeContact!)}).map({
                
                Contact(id: $0[Expression<String>("code_ofclient")],
                        code: Int($0[Expression<Int64>("code")]),
                        name: $0[Expression<String>("name1")],
                        budget: Int(budget!))
            })
            
        }
        
        return []
    }

    
}



struct Account: Identifiable {
    let id: Int
    let code: Int
    let name: String
    let phone: String
    let email: String
    let visited: String
}

struct Contact: Identifiable {
    let id: String
    let code: Int
    let name: String
    let budget: Int
    
}
