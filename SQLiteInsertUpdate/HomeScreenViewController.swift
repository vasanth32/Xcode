//
//  HomeScreenViewController.swift
//  SQLiteInsertUpdate
//
//  Created by V9694436 on 06/03/19.
//  Copyright © 2019 Saint-Gobain. All rights reserved.
//

import UIKit

class HomeScreenViewController :ViewController{
    
    @IBOutlet weak var tblStudentData: UITableView!
    var markStudentData : NSMutableArray!
   
    
    @IBOutlet weak var viewInsert: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(animated: Bool) {
        self.getStudentData()
    }

    @IBAction func btnEditClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("editSegue", sender: sender)
        
    }
    @IBAction func btnDeleteClicked(sender: AnyObject) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markStudentData.count
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //tmp
        //Initialize Reuseable cell
        let cell:StudentCell = tableView.dequeueReusableCellWithIdentifier("cell") as! StudentCell
        
        let student:StudentInfo = markStudentData.objectAtIndex(indexPath.row) as! StudentInfo
        cell.lblContent.text = "Name : \(student.Name)  \n  Marks : \(student.Marks)"
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        return cell
    }
    
    func getStudentData()
    {
        markStudentData = NSMutableArray()
        markStudentData = ModelManager.getInstance().getAllStudentData()
        tblStudentData.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "editSegue")
        {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            let viewController : InsertRecordViewController = segue.destinationViewController as! InsertRecordViewController
            viewController.isEdit = true
            viewController.studentData = markStudentData.objectAtIndex(selectedIndex) as! StudentInfo
        }
    }

}
