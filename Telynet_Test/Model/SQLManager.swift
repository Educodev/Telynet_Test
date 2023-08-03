//
//  SQLManager.swift
//  Telynet_Test
//
//  Created by Eduardo Herrera on 3/8/23.
//


import Foundation
import SQLite3
import SQLite

struct SQLManager {
    //singleton
    static var shared: SQLManager {
        let sqlManager = SQLManager()
        return sqlManager
    }
    
    //path of the file containing the sqlite database in the project navigator.
    private let bundleDBPath = Bundle.main.path(forResource: "telynetsales-test", ofType: "sqlite")
    //Instace of data base
    private var db: Connection!
    
    //table of accounts
    public var acounts: AnySequence<Row>? {
        return prepareTable(name: "ACCOUNTS")
    }
    
    //table of contacts
    public var contacts: AnySequence<Row>? {
        return prepareTable(name: "CONTACTS")
    }
    
    //table of  CONTACTS_ACCOUNTS
    public var contactsAccounts: AnySequence<Row>? {
        return prepareTable(name: "CONTACTS_ACCOUNTS")
        
    }
    
    //table of  CONTACTS_BUDGET
    public var contactsBudget: AnySequence<Row>? {
        return prepareTable(name: "CONTACTS_BUDGET")
    }
    
    init() {
        do {
            //init value to db
            db = try Connection(bundleDBPath!)
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    // prepare table
    private func prepareTable(name: String) -> AnySequence<Row>? {
        do {
            return try db.prepare(Table(name))
        } catch  {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    
    
    //generic method to return data from a table that contains a value such as id that matches the id of another table created in order to have a relationship between tables
     public func getValueFromRelation<T:Value>(value: Expression<T>, from sequence: AnySequence<Row>,  relationValue:Int, relationKey: String) -> T? {
            
        if let thisAccount = sequence.first(where: {$0[Expression<Int64>(relationKey)] == relationValue}) {
                return thisAccount[value]
            }
        return nil
    }
    
    
    
}
