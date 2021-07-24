//
//  DetailViewController.swift
//  ClickIt
//
//  Created by Atin Agnihotri on 24/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var clickedItem: ClickedItem!
    var clickedImage: UIImageView!
    var notesLabel: UILabel!
    
    override func loadView() {
        createSuperView()
        addImageView()
        addNotesLabel()
        addConstraints()
    }
    
    func createSuperView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    func addImageView() {
        clickedImage = UIImageView()
        clickedImage.translatesAutoresizingMaskIntoConstraints = false
        clickedImage.contentMode = .scaleAspectFit
        clickedImage.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(clickedImage)
    }
    
    func getClickedImageConstraints() -> [NSLayoutConstraint] {
        [
            clickedImage.topAnchor.constraint(equalTo: view.topAnchor),
            clickedImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickedImage.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleCaption()
        setNotesLabel()
        loadImage()
    }
    
    func loadImage() {
        if let imageToLoad = clickedItem?.imageName {
            let imagePath = PersistenceManager
                .shared
                .getDocumentsDirectory()
                .appendingPathComponent(imageToLoad)

            clickedImage.image = UIImage(contentsOfFile: imagePath.path)
        }
    }
    
    func setTitleCaption() {
        title = clickedItem?.caption
    }
    
    func setNotesLabel() {
        notesLabel.text = clickedItem.notes
    }
    
    func addNotesLabel() {
        notesLabel = UILabel()
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.contentMode = .scaleAspectFit
        notesLabel.numberOfLines = 0
        notesLabel.textAlignment = .center
        notesLabel.setContentHuggingPriority(UILayoutPriority(2), for: .vertical)
        view.addSubview(notesLabel)
    }
    
    func getNotesLabelConstraints() -> [NSLayoutConstraint] {
        [
            notesLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            notesLabel.topAnchor.constraint(equalTo: clickedImage.bottomAnchor),
            notesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notesLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ]
    }
    
    func addConstraints() {
        var constraints = getClickedImageConstraints()
        constraints += getNotesLabelConstraints()
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
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
