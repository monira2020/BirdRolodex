//
//  DBHelper.swift
//  BirdRolodex
//
//  Created by Monisha Ravi on 10/3/21.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "bird.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
           let createTableString = "CREATE TABLE IF IT DOES NOT EXIST bird(Id INTEGER PRIMARY KEY,name TEXT);"
           var createTableStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
           {
               if sqlite3_step(createTableStatement) == SQLITE_DONE
               {
                   print("bird table created.")
               } else {
                   print("bird table could not be created.")
               }
           } else {
               print("CREATE TABLE statement could not be prepared.")
           }
           sqlite3_finalize(createTableStatement)
       }
       
    func insert(id:Int, name:String)
        {
            let birds = read()
            for p in birds
            {
                if p.id == id
                {
                    print("ALREADY PRESENT")

                    return
                }
            }
            let insertStatementString = "INSERT INTO bird (Id, name) VALUES (?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(insertStatement, 1, Int32(id))
                sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertStatement)
        }

        func deleteRow() {
            let deleteStatementString = "DELETE FROM bird WHERE id = 1;"
          var deleteStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
              SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
              print("\nSuccessfully deleted row.")
            } else {
              print("\nCould not delete row.")
            }
          } else {
            print("\nDELETE statement could not be prepared")
          }
          
          sqlite3_finalize(deleteStatement)
        }
    func read() -> [BirdModel] {
            let queryStatementString = "SELECT * FROM bird;"
            var queryStatement: OpaquePointer? = nil
            var birds : [BirdModel] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id = sqlite3_column_int(queryStatement, 0)
                    let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    birds.append(BirdModel(id: Int(id), name: name))
                    print("Query Result:")
                    print("\(id) | \(name)")
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return birds
        }
}


struct BirdModel {
    var id: Int = 0
    var name: String = ""
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
