//
//  AllListTableViewController.swift
//  TLPEvents
//
//  Created by user143339 on 8/20/18.
//  Copyright © 2018 user143339. All rights reserved.
//

import UIKit

class AllListTableViewController: UITableViewController {

    var events: [Event] = []
    var eventsShow: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonUrlString = "https://opendata.tpl.ca/resources/events" //"https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                
                //let courses = try JSONDecoder().decode([Course].self, from: data)
                //print(courses)
                
                let calendar = Calendar.current
                let event = try JSONDecoder().decode([Event].self, from: data)
                //print(event)
                //self.events = (event)
                for event in event {//self.events {
                    if (event.enddate != nil){
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEEE, MMM dd, yyyy"
                        var auxStartDate = dateFormatter.date(from: event.date!)
                        var auxEndDate = dateFormatter.date(from: event.enddate!)
                        var today = Date()
                        var aux = dateFormatter.string(from: today)
                        today = dateFormatter.date(from: aux)!
                        today = today.addingTimeInterval(100)
                        
                        let auxStartDateYear = calendar.component(.year, from: auxStartDate!)
                        let auxEndDateYear = calendar.component(.year, from: auxEndDate!)
                        let todayYear = calendar.component(.year, from: today)
                        let auxDateMonth = calendar.component(.month, from: auxStartDate!)
                        //let auxEndDateMonth = calendar.component(.month, from: auxEndDate!)
                        let todayMonth = calendar.component(.month, from: today)
                        
                        if (todayYear == auxEndDateYear && (todayYear < auxStartDateYear || (todayYear == auxStartDateYear && todayMonth <= auxDateMonth))) {
                            self.eventsShow.append(event)
                        }
                    }
                }
                print(self.eventsShow)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            self.tableView.reloadData()
            }.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if let db = db {
//            data.removeAll()
//            data = db.readValues()
//            tableView.reloadData()
//        }
//
        let userLoggedIn = UserDefaults.standard.value(forKey: "userLoggedIn") as? Bool
        
        if (userLoggedIn != true) {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "loginView", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return events.count
        return eventsShow.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AllListTableViewCell", for: indexPath) as? AllListTableViewCell{
        //let cell = tableView.dequeueReusableCell(withIdentifier: "AllListTableViewCell", for: indexPath)
        
            cell.lblTitle.text = eventsShow[indexPath.row].title//events[indexPath.row].title
            
            return cell
        }else{
            fatalError("the dequeued cell is not an instance of AllListTableViewCell.")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
