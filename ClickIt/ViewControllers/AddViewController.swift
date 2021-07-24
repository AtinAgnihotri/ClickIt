//
//  AddViewController.swift
//  ClickIt
//
//  Created by Atin Agnihotri on 24/07/21.
//

import UIKit

protocol AddClickDelegate {
    func doneSavingClick(for click: ClickedItem)
}

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var delegate: AddClickDelegate?
    
    var captionTF: UITextField!
    var notesLabel: UILabel!
    var notesTV: UITextView!
    var saveButton: UIButton!
    var cancelButton: UIButton!
    
    var click: UIImage?
    var sourceType: UIImagePickerController.SourceType?
    
    override func loadView() {
        createView()
        addCaptionTF()
        addNotesLabel()
        addNotesTV()
        addSaveButton()
        addCancelButton()
        addConstraints()
    }
    
    func createView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    func addCaptionTF() {
        captionTF = UITextField()
        captionTF.placeholder = "Enter the caption here"
        captionTF.translatesAutoresizingMaskIntoConstraints = false
        captionTF.font = UIFont.systemFont(ofSize: 20)
        captionTF.textAlignment = .center
        captionTF.layer.borderWidth = 2
        captionTF.layer.borderColor = UIColor.lightGray.cgColor
        captionTF.layer.cornerRadius = 3
        captionTF.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(captionTF)
    }
    
    func getCaptionTFConstraints() -> [NSLayoutConstraint] {
        [
            captionTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            captionTF.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            captionTF.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            captionTF.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)
        ]
    }
    
    func addNotesLabel() {
        notesLabel = UILabel()
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.text = "Enter notes below, if any"
        notesLabel.font = UIFont.boldSystemFont(ofSize: 20)
        notesLabel.textAlignment = .center
        notesLabel.numberOfLines = 1
        view.addSubview(notesLabel)
    }
    
    func getNotesLabelConstraints() -> [NSLayoutConstraint] {
        [
            notesLabel.topAnchor.constraint(equalTo: captionTF.bottomAnchor, constant: 10),
            notesLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            notesLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]
    }
    
    func addNotesTV() {
        notesTV = UITextView()
        notesTV.isEditable = true
        notesTV.text = ""
        notesTV.translatesAutoresizingMaskIntoConstraints = false
        notesTV.font = UIFont.systemFont(ofSize: 20)
        notesTV.layer.borderWidth = 2
        notesTV.layer.borderColor = UIColor.lightGray.cgColor
        notesTV.layer.cornerRadius = 3
        view.addSubview(notesTV)
    }
    
    func getNotesTVConstraints() -> [NSLayoutConstraint] {
        [
            notesTV.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 5),
//            notesTV.topAnchor.constraint(equalTo: captionTF.bottomAnchor, constant: 10),
            notesTV.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            notesTV.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
//            notesTV.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ]
    }
    
    func addSaveButton() {
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveClick), for: .touchUpInside)
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        saveButton.backgroundColor = .green
        saveButton.layer.borderWidth = 2
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        saveButton.layer.cornerRadius = 7
        view.addSubview(saveButton)
    }
    
    func getSaveButtonConstraints() -> [NSLayoutConstraint] {
        [
            saveButton.topAnchor.constraint(equalTo: notesTV.bottomAnchor, constant: 40),
            saveButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]
    }
    
    func addCancelButton() {
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        cancelButton.backgroundColor = .red
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor
        cancelButton.layer.cornerRadius = 7
        view.addSubview(cancelButton)
    }
    
    func getCancelButtonConstraints() -> [NSLayoutConstraint] {
        [
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            cancelButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
    
    func addConstraints() {
        var constraints = getCaptionTFConstraints()
        constraints += getNotesLabelConstraints()
        constraints += getNotesTVConstraints()
        constraints += getSaveButtonConstraints()
        constraints += getCancelButtonConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTitle()
        loadPicker()
        // Do any additional setup after loading the view.
    }
    
    func addTitle() {
        title = "Add Click"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func loadPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType ?? .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        click = image
        dismiss(animated: true)
    }
    
    @objc func saveClick() {
        guard let caption = captionTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            showErrorAlert(title: "Please Enter a caption")
            return
        }
        guard !caption.isEmpty else {
            showErrorAlert(title: "Caption can't be empty")
            return
        }
        
        if click == nil {
            loadPicker()
        } else {
            let notes = notesTV.text ?? ""
            let savedImageName = saveImageToLocal()
            let click = ClickedItem(imageName: savedImageName, caption: caption, notes: notes)
            delegate?.doneSavingClick(for: click)
            dismissScreen()
        }
    }
    
    func saveImageToLocal() -> String {
        let imageName = UUID().uuidString
        let persistenceManager = PersistenceManager.shared
        let imagePath = persistenceManager
            .getDocumentsDirectory()
            .appendingPathComponent(imageName)
        persistenceManager.saveImage(click, to: imagePath)
        return imageName
    }
    
    @objc func cancel() {
//        self.dismiss(animated: true, completion: nil)
        dismissScreen()
    }
    
    func dismissScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func showErrorAlert(title: String, message: String? = nil) {
        let ac = UIAlertController(title: "⚠️ \(title)", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        ac.addAction(ok)
        present(ac, animated: true)
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
