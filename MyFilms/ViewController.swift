//
//  ViewController.swift
//  MyFilms
//
//  Created by Diane Christy on 10/20/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    let managedObjectContext =
    (UIApplication.sharedApplication() .delegate
        as! AppDelegate) .managedObjectContext
    
    var filmdb:NSManagedObject!
    
    @IBAction func btnBack(sender: AnyObject) {
    }
    
    
   
    @IBOutlet weak var film: UITextField!

    @IBOutlet weak var genre: UITextField!
    
    @IBOutlet weak var length: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    
    @IBOutlet weak var info: UITextView!
    
    
    @IBOutlet weak var btnSave: UIButton!
    
       

    @IBAction func btnSave(sender: AnyObject) {
               if (filmdb != nil)
        
        {
            filmdb.setValue(film.text, forKey: "film")
            filmdb.setValue(year.text, forKey: "year")
            filmdb.setValue(genre.text, forKey: "genre")
            filmdb.setValue(length.text, forKey: "length")
            filmdb.setValue(info.text, forKey: "info")
        }
        else
        {
            let entityDescription =
            NSEntityDescription.entityForName("Films",inManagedObjectContext: managedObjectContext)
            
            let films = Films(entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            
            films.title = film.text!
            films.year = year.text!
            films.genre = genre.text!
            films.length = length.text!
            films.info = info.text!
        }
        
        var error: NSError?
        do {
            try managedObjectContext.save()
            
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            info.text = err.localizedFailureReason
        }
        else{
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }


    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if (filmdb != nil)
        {
            film.text = filmdb.valueForKey("film") as? String
            year.text = filmdb.valueForKey("year") as? String
            genre.text = filmdb.valueForKey("genre") as? String
            length.text = filmdb.valueForKey("length") as? String
            info.text = filmdb.valueForKey("info") as? String
            btnSave.setTitle("Update", forState: UIControlState.Normal)
            
        }
        
        film.becomeFirstResponder()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            DismissKeyboard()
        }
        
        super.touchesBegan(touches , withEvent:event)
    }
    
    
    func DismissKeyboard(){
        film.endEditing(true)
        year.endEditing(true)
        genre.endEditing(true)
        length.endEditing(true)
        info.endEditing(true)
        
    }
    func textFieldShoulReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
