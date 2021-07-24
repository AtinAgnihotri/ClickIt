//
//  DetailViewController.swift
//  ClickIt
//
//  Created by Atin Agnihotri on 24/07/21.
//

import UIKit

class DetailViewController: UITabBarController {
    
    var clickedItem: ClickedItem!
    var clickedImage: UIImageView!
    
    override func loadView() {
        createSuperView()
        addImageView()
    }
    
    func createSuperView() {
        view = UIView()
        view.backgroundColor = .tertiarySystemFill
    }
    
    func addImageView() {
        clickedImage = UIImageView()
        NSLayoutConstraint.activate([
            clickedImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickedImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            clickedImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            clickedImage.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleCaption()
        setNotes()
        loadImage()
        // Do any additional setup after loading the view.
    }
    
    func loadImage() {
        if let imageToLoad = clickedItem?.imageName {
            let imagePath = PersistenceManager
                .shared
                .getDocumentsDirectory()
                .appendingPathComponent(imageToLoad)

            
        }
    }
    
    func setTitleCaption() {
        title = clickedItem?.caption
    }
    
    func setNotes() {
        tabBarItem = UITabBarItem(title: clickedItem?.notes, image: nil, tag: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
        tabBarController?.hidesBottomBarWhenPushed = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
