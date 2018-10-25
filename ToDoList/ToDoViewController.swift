//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Александр Макаров on 25.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesLabel: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let datePickerCellIndexPath = IndexPath(row: 2, section: 0)
    
    var isDatePickerShown: Bool = false {
        didSet {
            datePicker.isHidden = !isDatePickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDateViews()
    }
    
    func updateDateViews() {
        datePicker.minimumDate = datePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerCellIndexPath:
            if isDatePickerShown {
                print(#function, datePicker.frame.height)
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (datePickerCellIndexPath.section, datePickerCellIndexPath.row - 1):
            if isDatePickerShown {
                isDatePickerShown = false
            } else if isDatePickerShown {
                isDatePickerShown = false
                isDatePickerShown = true
            } else {
                isDatePickerShown = true
            }
        default:
            isDatePickerShown = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func daitePickuerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
}
