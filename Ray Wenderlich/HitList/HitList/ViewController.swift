//
//  ViewController.swift
//  HitList
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
//    // A butable array holding string values displayed
//    // by the table view
//    var names: [String] = []
    
    // For core data use
    var people: [NSManagedObject] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set a title on the navigation bar and register the
        // UITableViewCell class with the table view
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        // 1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else  {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        // 3
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error). \(error.userInfo)")
        }
    }
    
    // Action connected to the storyboard, adds a new name
    // each time the button is clicked
    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                    return
            }
            
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        person.setValue(name, forKey: "name")
        
        // 4
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // grab the name attribute from the NSManagedObject
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
}


// Used in the for code with out core data
//extension ViewController: UITableViewDataSource {
//
//    // return the number of rows in the table view
//    // as the number of items in your names array
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return names.count
//    }
//
//
//    // dequeues table view cells and populates them with the coresponding string
//    // from the names array
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = names[indexPath.row]
//        return cell
//    }
//}

