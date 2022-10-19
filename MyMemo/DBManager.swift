//
//  DBManager.swift
//  MyMemo
//
//  Created by Znfod on 2022/10/10.
//

import UIKit
import FMDB

class DBManager: NSObject {
    static let shared = DBManager()
    var fmDB: FMDatabase?
    
    override init() {
        
    }
    
    func firstInit() {
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("mymemo.sqlite")
            self.fmDB = FMDatabase(url: fileURL)
            guard let db = fmDB, db.open() else {
                return
            }
            _ = self.createMemeo()
        } catch {
            
        }
    }
    
    private func createTable(sql: String) -> Bool{
        guard let db = fmDB, db.open() else {
            return false
        }
        let success = db.executeStatements(sql)
        db.close()
        return success
    }
    
    private func executeSQL(_ sql: String) -> Bool {
        guard let db = fmDB, db.open() else {
            return false
        }
        let success = db.executeStatements(sql)
        db.close()
        return success
    }
    
    private func deleteTable(_ tableName: String) -> Bool {
        let sql = "DELETE from \(tableName)"
        return self.executeSQL(sql)
    }
    
    private func dropTable(_ tableName: String) -> Bool {
        let sql = "DROP table \(tableName)"
        return self.executeSQL(sql)
    }
}


// MARK: -
extension DBManager {
    
    func createMemeo() -> Bool {
        let sql: String = "CREATE TABLE if not exists memo (" +
        "id integer PRIMARY KEY," +
        "title text," +
        "contents text," +
        "reg_date integer" +
        ");"
        return self.createTable(sql: sql)
    }
    
    func insertMemo(memo: MemoData) {
        guard let db = fmDB, db.open() else {
            return
        }
        let sql: String = "INSERT INTO memo (" +
        "title," +
        "contents," +
        "reg_date" +
        ") VALUES (" + self.getQuestionWithComma(count: 3) + ");"

        let title = memo.title ?? ""
        let contents = memo.contents ?? ""
        let reg_date = Int(Date().timeIntervalSince1970 * 1000)

        let values = [title, contents, reg_date] as [Any]
        do {
            try db.executeUpdate(sql, values: values)
        } catch {
            print("e : \(error)")
        }
    }
    
    func readMemo() -> [MemoData] {
        guard let db = fmDB, db.open() else {
            return [MemoData]()
        }
        let sql = "SELECT * from memo " +
        ";"
        
        do {
            let rs = try db.executeQuery(sql, values: nil)
            var result = [MemoData]()
            while rs.next() {
                let memo = MemoData(rs: rs)
                result.append(memo)
            }
            return result
        } catch {
            print("error : \(error)")
            return [MemoData]()
        }
    }
    
    func deleteMemo(memo: MemoData) -> Bool {
        guard let db = fmDB, db.open() else {
            return false
        }
        let sql = "DELETE from memo where id == \(memo.memoId);"
        let success = db.executeStatements(sql)
        db.close()
        return success
    }
    
    func updateMemo(memo: MemoData) -> Bool{
        guard let db = fmDB, db.open() else {
            return false
        }
        guard let title = memo.title, let contents = memo.contents else {
            return false
        }
        let regDate = Int(Date().timeIntervalSince1970 * 1000)
        let sql = "UPDATE memo SET " +
        "title='\(title)'," +
        "contents='\(contents)'," +
        "reg_date='\(regDate)' " +
        "where id = \(memo.memoId)" +
        ";"
        db.executeStatements(sql)
        return true
    }
    
}

extension DBManager {
    func getQuestionWithComma(count: Int = 1) -> String {
        if count < 1 {
            return ""
        }
        var result = "?"
        for _ in 0..<count - 1 {
            result.append(", ?")
        }
        return result
    }
}
