//
//  ActionViewController.swift
//  ImageAndMovieShare
//
//  Created by しゅん on 2022/01/11.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! {
                if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakImageView = self.imageView
                    provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil, completionHandler: { (imageURL, error) in
                        OperationQueue.main.addOperation {
                            if let strongImageView = weakImageView {
                                if let imageURL = imageURL as? URL {
                                    let image = UIImage(data: try! Data(contentsOf: imageURL))
                                    strongImageView.image = image
                                    let filename = self.saveUIImageToAppGroup(image!)
                                    self.openUrl(url: URL(string: "seminar://?filename=\(filename)")!)
                                }
                            }
                        }
                    })
                    
                    imageFound = true
                    break
                }
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
    
    func saveUIImageToAppGroup(_ image: UIImage) -> String {
        if let shareURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.seminar.kaijiIshi") {
            let fileName = "image-\(UUID().uuidString).jpg"
            if let data = image.jpegData(compressionQuality: 1.0) {
                do {
                    try data.write(to: shareURL.appendingPathComponent(fileName))
                    return fileName
                } catch {
                    return fileName
                }
            }
        }
        return "test"
    }
    
    @objc func openURL(_ url: URL) {}  // #selector(openURL(_:))はこの関数がないと作れない
    func openUrl(url: URL?) {
        let selector = #selector(openURL(_:))
        var responder = (self as UIResponder).next
        while let r = responder, !r.responds(to: selector) {
            responder = r.next
        }
        _ = responder?.perform(selector, with: url)
    }

}
