//
//  DBHelper.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 19/01/23.
//

import Foundation
import SQLite3

class DBHelper {
    
    init() {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "babyDb.sqlite"
    var db: OpaquePointer?

    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        }
        else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS babies(Id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, yearOfBirth TEXT, gender TEXT, ethnicity TEXT, numberOfBabies TEXT, rank TEXT);"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("babies table created.")
            } else {
                print("babies table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(name: String, yearOfBirth: String, gender: String, ethnicity: String, numberOfBabies: String, rank: String) {
        let babies = read()
        let isEmpty = babies.isEmpty
        
        for p in babies {
            if p.name == name && p.yearOfBirth == yearOfBirth && p.gender == gender && p.ethnicity == ethnicity && p.numberOfBabies == numberOfBabies && p.rank == rank {
                return
            }
        }
        
        let insertStatementString = "INSERT INTO babies (Id, name, yearOfBirth, gender, ethnicity, numberOfBabies, rank) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            if isEmpty {
                sqlite3_bind_int(insertStatement, 1, 1)
            }
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (yearOfBirth as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (ethnicity as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (numberOfBabies as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (rank as NSString).utf8String, -1, nil)
            
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
    
    func read() -> [Baby] {
        let queryStatementString = "SELECT * FROM babies;"
        var queryStatement: OpaquePointer? = nil
        var babies : [Baby] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let yearOfBirth = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let ethnicity = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let numberOfBabies = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let rank = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                babies.append(Baby(yearOfBirth: yearOfBirth, gender: gender, ethnicity: ethnicity, name: name, numberOfBabies: numberOfBabies, rank: rank))
                print("Query Result:")
                print("\(id) | \(name) | \(gender)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        
        return babies
    }
    
    func update(id: Int, name: String, yearOfBirth: String, gender: String, ethnicity: String, numberOfBabies: String, rank: String) {
        let query = "UPDATE babies SET name = '\(name)', yearOfBirth = '\(yearOfBirth)', gender = '\(gender)', ethnicity = '\(ethnicity)', numberOfBabies = '\(numberOfBabies)', rank = '\(rank)' WHERE id = \(id);"
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data updated success")
            } else {
                print("Data is not updated in table")
            }
        }
    }
    
    func deleteByID(id: Int) {
        let deleteStatementStirng = "DELETE FROM babies WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        
        sqlite3_finalize(deleteStatement)
    }
}
