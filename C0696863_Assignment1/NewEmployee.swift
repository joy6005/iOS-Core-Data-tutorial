

import UIKit
import CoreData

class NewEmployee: UIViewController
{
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtBirthDate: UITextField!
    @IBOutlet var txtSalary: UITextField!
    
    @IBOutlet var btnSave: UIButton!
    
    let datePicker = UIDatePicker()
    
    var employees: [NSManagedObject] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        createDatePicker()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do
        {
            employees = try context.fetch(Employee.fetchRequest())
        }
        catch
        {
            print("Fetching Failed")
        }
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton)
    {
        let EmployeeName: String = txtName.text!
        let BirthDate: String = txtBirthDate.text!
        let Salary: String = txtSalary.text!
        
        self.save(EmployeeName: EmployeeName, BirthDate: BirthDate, Salary: Salary)
    }
    
    func createDatePicker()
    {
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        txtBirthDate.inputAccessoryView = toolbar
        txtBirthDate.inputView = datePicker
    }
    
    func donePressed()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        txtBirthDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func save(EmployeeName: String, BirthDate: String, Salary: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        let i = employees.count
        
        person.setValue(i+1, forKeyPath: "empid")
        person.setValue(EmployeeName, forKeyPath: "empname")
        person.setValue(BirthDate, forKeyPath: "birthdate")
        person.setValue(Salary, forKeyPath: "salary")
        
        do
        {
            try managedContext.save()
            navigationController?.popViewController(animated: true)
        }
        catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
