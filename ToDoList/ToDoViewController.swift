//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Александр Макаров on 25.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoViewController: UITableViewController {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
//    var todo: ToDo?
    
    var isPickerHidden = true {
        didSet {
            dueDatePickerView?.isHidden = isPickerHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dueDatePickerView.date = Date().addingTimeInterval(24 * 60 * 60)
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(156)
        
        switch indexPath {
        case [0, 2]:
            return isPickerHidden ? 0 : largeCellHeight
        case [1, 0]:
            return notesTextView.contentSize.height
        default:
            return normalCellHeight
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 1]:
            isPickerHidden = !isPickerHidden
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.beginUpdates()
            tableView.endUpdates()
            view.endEditing(true)
        default:
            break
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard segue.identifier == "saveUnwind" else { return }
//
//        let title = titleTextField.text ?? ""
//        let isComplete = isCompleteButton.isSelected
//        let dueDate = dueDatePickerView.date
//        let notes = notesTextView.text
//        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
//    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        var todo: ToDo!
        todo = ToDo()
        todo.title = self.titleTextField.text!
        todo.isComplete = self.isCompleteButton.isSelected
        todo.dueDate = self.dueDatePickerView.date
        todo.notes = self.notesTextView.text
        
        try! realm.write {
            realm.add(todo)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
        view.endEditing(true)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
        view.endEditing(true)
    }

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
}
