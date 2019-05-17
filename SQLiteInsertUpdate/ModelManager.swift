//
//  ModelManager.swift
//  SQLiteInsertUpdate
//
//  Created by V9694436 on 07/03/19.
//  Copyright © 2019 Saint-Gobain. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()
class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    // This code is called at most once
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("Student.sqlite"))
        }
        return sharedInstance
    }
    
    func addStudentData(studentInfo: StudentInfo) -> Bool
    {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO student_info (Name, Marks) VALUES (?, ?)", withArgumentsInArray: [studentInfo.Name, studentInfo.Marks])
        sharedInstance.database!.close()
        return isInserted
    }
    func updateStudentData(studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE student_info SET Name=?, Marks=? WHERE RollNo=?", withArgumentsInArray: [studentInfo.Name, studentInfo.Marks, studentInfo.RollNo])
        sharedInstance.database!.close()
        return isUpdated
    }
    func deleteStudentData(studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM student_info WHERE RollNo=?", withArgumentsInArray: [studentInfo.RollNo])
        sharedInstance.database!.close()
        return isDeleted
    }
    func getAllStudentData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM student_info", withArgumentsInArray: [])
        let marrStudentInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let studentInfo : StudentInfo = StudentInfo()
                studentInfo.RollNo = resultSet.stringForColumn("RollNo")!
                studentInfo.Name = resultSet.stringForColumn("Name")!
                studentInfo.Marks = resultSet.stringForColumn("Marks")!
                marrStudentInfo.addObject(studentInfo)
            }
        }
        sharedInstance.database!.close()
        return marrStudentInfo
    }


}
