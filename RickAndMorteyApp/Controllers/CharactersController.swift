//
//  CharactersTableViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 01.10.2021.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var burgerMenu: UIView!
    @IBOutlet weak var buttonColor: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        burgerMenu.isHidden = true
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {

        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharactersTableViewCell



        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func burgerMenuOpening(_ sender: Any) {

        self.burgerMenu.isHidden.toggle()
    }
    @IBAction func charactersButton(_ sender: Any) {
        self.title = "Characters"
        self.burgerMenu.isHidden.toggle()
    }
    @IBAction func episodesButton(_ sender: Any) {
        self.title = "Episodes"
        self.burgerMenu.isHidden.toggle()
    }
    @IBAction func locationsButton(_ sender: Any) {
        self.title = "Locations"
        self.burgerMenu.isHidden.toggle()
    }
    @IBAction func statisticButton(_ sender: Any) {
        self.title = "Statistic"
        self.burgerMenu.isHidden.toggle()
    }
    @IBAction func favoritesButton(_ sender: Any) {
        self.title = "Favorites"
        self.burgerMenu.isHidden.toggle()
    }


}
