//
//  ViewController.swift
//  ClickIt
//
//  Created by Atin Agnihotri on 24/07/21.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addTitle()
        addClickItButton()
    }
    
    func addTitle() {
        title = "ClickIt"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addClickItButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(clickIt))
    }
    
    @objc func clickIt() {
        print("Click It")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClickItCell", for: indexPath) as? ClickItItem else {
            fatalError("Failed to dequeue cell")
        }
        cell.clickedImage.image = UIImage(systemName: "camera")
        cell.caption.text = "Test Caption"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.clickedItem = ClickedItem(imageName: "camera", caption: "Test Caption", notes: "These are some test notes")
        navigationController?.pushViewController(vc, animated: true)
    }

}

