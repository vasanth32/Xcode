//
//  InsertRecordViewController.swift
//  SQLiteInsertUpdate
//
//  Created by V9694436 on 06/03/19.
//  Copyright © 2019 Saint-Gobain. All rights reserved.
//

import UIKit

class InsertRecordViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMarks: UITextField!
    
    var isEdit : Bool = false
    var studentData : StudentInfo!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    }
    
    @IBAction func btnBackClicked(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    @IBAction func btnSaveClicked(sender: AnyObject) {
        
        let studentInfo: StudentInfo = StudentInfo()
        studentInfo.Name = txtName.text!
        studentInfo.Marks = txtMarks.text!
        let isInserted = ModelManager.getInstance().addStudentData(studentInfo)
        if isInserted {
            Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
        }
  
        
    }
    //dbt
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
