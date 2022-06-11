//
//  DBHelper.swift
//  PruebaCeiba
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import Foundation
import SQLite3

class DBHelper {
    
    private var db : OpaquePointer?
    private var path : String = "pruebaCeiba.sqlite"
    
    private let userTable = "user"
    
    init() {
        self.db = createDB()
        self.createTables()
    }
    
    private func createTables(){
        self.createTable(tableName: userTable, query: "CREATE TABLE IF NOT EXISTS \(userTable)(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER, name TEXT, username TEXT, email TEXT, street TEXT, suite TEXT, city TEXT, zipcode TEXT, lat TEXT, lng TEXT, phone TEXT, website TEXT, companyName TEXT, catchPhrase TEXT, bs TEXT);")
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

        let docsDir = dirPaths[0]

        print(docsDir)
    }
    
    private func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("❌ There is error in creatingDB")
            return nil
        }else {
            print("✅ Database has been created with path \(filePath.path)")
            return db
        }
    }
    
    private func createTable(tableName:String, query:String)  {
        
        var statement : OpaquePointer? = nil
            
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("✅ Table \(tableName): creation success")
            }else{
                print("❌ Table \(tableName): creation fail")
            }
            
        }else{
            print("❌ Table \(tableName): preparation fail")
        }
    }
    
    //#MARK: USER
    func insertUser(user:User) {
        let tableName = userTable
        let query = "INSERT INTO \(tableName) (id, userId, name, username, email, street, suite, city, zipcode, lat, lng, phone, website, companyName, catchPhrase, bs) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var statement : OpaquePointer? = nil
        var isEmpty = false
        
        if readUsers().isEmpty {
            isEmpty = true
        }
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if isEmpty {
                sqlite3_bind_int(statement, 1, 1)
            }
            sqlite3_bind_int(statement, 2, Int32(user.id))
            sqlite3_bind_text(statement, 3, (user.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (user.username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (user.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, (user.address.street as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 7, (user.address.suite as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 8, (user.address.city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 9, (user.address.zipcode as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 10, (user.address.geo.lat as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 11, (user.address.geo.lng as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 12, (user.phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 13, (user.website as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 14, (user.company.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 15, (user.company.catchPhrase as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 16, (user.company.bs as NSString).utf8String, -1, nil)
                
            if sqlite3_step(statement) == SQLITE_DONE {
                print("✅ Table \(tableName): Data inserted success")
            }else{
                print("❌ Table \(tableName): Data is not inserted in table")
            }
        }else{
            print("❌ Table \(tableName): Query is not as per requirement")
        }
    }
    
    func readUsers() -> [User] {
        let tableName = userTable
        var mainList = [User]()
        let query = "SELECT * FROM \(tableName) ORDER BY userId ASC;"
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            while sqlite3_step(statement) == SQLITE_ROW {
                let userId = Int(sqlite3_column_int(statement, 1))
                let name = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                let username = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                let email = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                let street = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                let suite = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                let city = String(describing: String(cString: sqlite3_column_text(statement, 7)))
                let zipcode = String(describing: String(cString: sqlite3_column_text(statement, 8)))
                let lat = String(describing: String(cString: sqlite3_column_text(statement, 9)))
                let lng = String(describing: String(cString: sqlite3_column_text(statement, 10)))
                let phone = String(describing: String(cString: sqlite3_column_text(statement, 11)))
                let website = String(describing: String(cString: sqlite3_column_text(statement, 12)))
                let companyName = String(describing: String(cString: sqlite3_column_text(statement, 13)))
                let catchPhrase = String(describing: String(cString: sqlite3_column_text(statement, 14)))
                let bs = String(describing: String(cString: sqlite3_column_text(statement, 15)))
                let geo = Geo(lat: lat, lng: lng)
                let address = Address(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo)
                let company = Company(name: companyName, catchPhrase: catchPhrase, bs: bs)
                let user = User(id: userId, name: name, username: username, email: email, address: address, phone: phone, website: website, company: company)
                mainList.append(user)
            }
        }
        return mainList
    }
    
    func deleteUsers() {
        let tableName = userTable
        let query = "DELETE FROM \(tableName)"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("✅ Table \(tableName): Data delete success")
            }else {
                print("❌ Table \(tableName): Data is not deleted in table")
            }
        }
    }
    
}

