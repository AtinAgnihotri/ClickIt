//
//  ViewController.swift
//  ClickIt
//
//  Created by Atin Agnihotri on 24/07/21.
//

import UIKit

class MainViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AddClickDelegate {
    
    var clickedItems = [ClickedItem]()

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(promptUserChoice))
    }
    
    func clickIt(with sourceType: UIImagePickerController.SourceType) {
//        let picker = UIImagePickerController()
//        picker.sourceType = sourceType
//        picker.allowsEditing = true
//        picker.delegate = self
//        present(picker, animated: true)
        let vc = AddViewController()
        vc.delegate = self
        vc.sourceType = sourceType
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func doneSavingClick(for click: ClickedItem) {
        let indexPath = IndexPath(row: 0, section: 0)
        clickedItems.insert(click, at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: .right)
    }
    
    @objc func promptUserChoice() {
        let ac = UIAlertController(title: "Get image from", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let camera = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                self?.clickIt(with: .camera)
            }
            ac.addAction(camera)
        }
        
        let library = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.clickIt(with: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(library)
        ac.addAction(cancel)
        
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clickedItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClickItCell", for: indexPath) as? ClickItItem else {
            fatalError("Failed to dequeue cell")
        }
        let clickedItem = clickedItems[indexPath.row]
        
        cell.imageView?.image = getResizedCellImage(withName: clickedItem.imageName, targetSize: CGSize(width: 60, height: 60))
//        cell.imageView?.frame = CGRect(x: 20, y: 20, width: 120, height: 60)
        
        cell.imageView?.layer.borderWidth = 2
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
//        cell.imageView?.contentMode = .scaleAspectFit
        cell.caption.text = clickedItem.caption
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemFill.cgColor
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.clickedItem = clickedItems[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = PersistenceManager
            .shared
            .getDocumentsDirectory()
            .appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        
        
        dismiss(animated: true)
        
        let click = ClickedItem(imageName: imageName, caption: "Sample Image", notes: "Sample Notes")
        let indexPath = IndexPath(row: 0, section: 0)
        clickedItems.insert(click, at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: .right)
        
        
    }
    
    func loadCellImage(withName imageName: String) -> UIImage? {
        let imagePath = PersistenceManager
            .shared
            .getDocumentsDirectory()
            .appendingPathComponent(imageName)
        let image = UIImage(contentsOfFile: imagePath.path)
//        image?.s = CGSize(width: 60, height: 60)
        return image
    }
    
    func getResizedCellImage(withName imageName: String, targetSize: CGSize) -> UIImage? {
        guard let image = loadCellImage(withName: imageName) else { return nil }
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}

