//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-08-08.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        let item = items[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText =  item.description
        cell.contentConfiguration = content
        return cell
    }
    

    

    @IBOutlet weak var tableView: UITableView!

    private var items: [ItemToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDefaultItems()
        tableView.dataSource = self
    }
    

    @IBAction func onQuitButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSelectCategoryScreen", sender: self)
    }
    private func loadDefaultItems(){
        items.append(ItemToDo(title: "title 1", description: "Description 1"))
        items.append(ItemToDo(title: "title 2", description: "Description 2"))
        items.append(ItemToDo(title: "title 3", description: "Description 3"))
        items.append(ItemToDo(title: "title 4", description: "Description 4"))

    }
}
    struct ItemToDo{
        let title: String
        let description: String
    }

