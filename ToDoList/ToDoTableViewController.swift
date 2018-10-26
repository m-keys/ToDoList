//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Александр Макаров on 23.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoTableViewController: UITableViewController {
    
//    var todos = [ToDo]()
    var notificationToken: NotificationToken?
    var publishedItem: Results<ToDo>!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        //        autoreleasepool {
        //            // all Realm usage here
        //        }
        if Realm.Configuration.defaultConfiguration.fileURL == nil {
            print("файл default.realm не найден")
        } else {
            let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
            let realmURLs = [
                realmURL,
                //realmURL.appendingPathExtension("lock"),
                //realmURL.appendingPathExtension("note"),
                //realmURL.appendingPathExtension("management")
            ]
            for URL in realmURLs {
                do {
                    try FileManager.default.removeItem(at: URL)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let savedToDos = ToDo.loadToDos() {
//            todos = savedToDos
//        } else {
//            todos = ToDo.loadSampleToDos()
//        }
        
        SyncUser.logIn(with: credencial, server: authServerURL) { (user, error) in
            
            DispatchQueue.main.async {
                
                Realm.Configuration.defaultConfiguration = Realm.Configuration.init(syncConfiguration: SyncConfiguration(user: user!, realmURL: realmURL))
                
                Realm.Configuration.defaultConfiguration = Realm.Configuration.init(fileURL: nil, inMemoryIdentifier: nil, syncConfiguration: SyncConfiguration(user: user!, realmURL: realmURL), encryptionKey: nil, readOnly: false, schemaVersion: 1, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, objectTypes: [ToDo.self])
                
                self.publishedItem = realm.objects(ToDo.self)
                self.notificationToken = realm.addNotificationBlock { _, _ in // или observe на новой версии
                    self.tableView.reloadData()
                }
                self.tableView.reloadData()
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todos.count
        
        return publishedItem?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") else {
            fatalError("\(#function) at \(#line): dequeueReusableCell(withIdentifier:) error")
        }
        
//        let todo = todos[indexPath.row]
        
        let todo = publishedItem[indexPath.row]
        cell.textLabel?.text = todo.title
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            todos.remove(at: indexPath.row)
            
            let item = publishedItem[indexPath.row]
            
            try! realm.write {
                realm.delete(item)
                self.tableView.reloadData()
            }
            
            publishedItem = realm.objects(ToDo.self).sorted(byKeyPath: "title", ascending: true)
            tableView.reloadData()
            
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
//        else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
//        guard segue.identifier == "saveUnwind" else { return }
//        guard let toDoViewController = segue.source as? ToDoViewController else { return }
//        guard let todo = toDoViewController.todo else { return }
//
//        let indexPath = IndexPath(row: todos.count, section: 0)
//        todos.append(todo)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//
//        tableView.reloadData()
    }
    
}
