//
//  DBHelper.swift
//  BirdRolodex
//
//  Created by Monisha Ravi on 10/3/21.
//

import Foundation
import SQLite3

class DBHelperBird
{

    let dbPath: String = "birds4.sqlite"
    var db:OpaquePointer?
    
    init()
    {
        db = openDatabase()
        createTable()
    }

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
           let createTableString =  """
CREATE TABLE bird(
Id INT,
Name TEXT,
ImageURL TEXT,
BirdDescription TEXT,
AbilityIds TEXT);
"""
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
       
    func insert(id:Int, name:String, imageURL:String, birdDescription: String, abilityIds: String)
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
            let insertStatementString = "INSERT INTO bird (Id, Name, ImageURL, birdDescription, abilityIds) VALUES (?, ?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(insertStatement, 1, Int32(id))
                sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (imageURL as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (birdDescription as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (abilityIds as NSString).utf8String, -1, nil)
                
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

    func deleteRow(row: Int) {
            let deleteStatementString = "DELETE FROM bird WHERE id = \(row);"
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
                    let imageURL = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let birdDescription = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                    let abilityIds = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                    birds.append(BirdModel(id: Int(id), name: name, imageURL: imageURL, birdDescription: birdDescription, abilityIds: abilityIds))
                    print("Query Result:")
                    print("\(id) | \(name) | \(imageURL) | \(birdDescription) | \(abilityIds)")
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return birds
        }
}

class DBHelperAbility
{

    let dbPath: String = "ability.sqlite"
    var db:OpaquePointer?
    
    init()
    {
        db = openDatabase()
        createTable()
    }

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
           let createTableString =  """
CREATE TABLE ability(
Id INT,
abilityId TEXT,
abilityName TEXT,
);
"""
           var createTableStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
           {
               if sqlite3_step(createTableStatement) == SQLITE_DONE
               {
                   print("ability table created.")
               } else {
                   print("ability table could not be created.")
               }
           } else {
               print("CREATE TABLE statement could not be prepared.")
           }
           sqlite3_finalize(createTableStatement)
       }
       
    func insert(id: Int, abilityId: String, abilityName:String)
        {
            let abilities = read()
            for a in abilities
            {
                if a.id == id
                {
                    print("ALREADY PRESENT")

                    return
                }
            }
            let insertStatementString = "INSERT INTO bird (abilityId, abilityName) VALUES (?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(insertStatement, 1, (abilityId as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (abilityName as NSString).utf8String, -1, nil)
                
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

    func deleteRow(row: Int) {
            let deleteStatementString = "DELETE FROM ability WHERE abilityId = \(row);"
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
    func read() -> [AbilityModel] {
            let queryStatementString = "SELECT * FROM ability;"
            var queryStatement: OpaquePointer? = nil
            var birds : [AbilityModel] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id = sqlite3_column_int(queryStatement, 0)
                    let abilityId = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    birds.append(AbilityModel(id: Int(id), abilityId: abilityId, abilityName: name))
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
    var imageURL: String = ""
    var birdDescription: String = ""
    var abilityIds: String = ""
    
    init(id: Int, name: String, imageURL: String, birdDescription: String, abilityIds: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.birdDescription = birdDescription
        self.abilityIds = abilityIds
    }
}
struct AbilityModel {
    var id: Int = 0
    var abilityId: String = ""
    var abilityName: String = ""
    
    init(id:Int, abilityId: String, abilityName: String) {
        self.id = id
        self.abilityId = abilityId
        self.abilityName = abilityName
    }
}
