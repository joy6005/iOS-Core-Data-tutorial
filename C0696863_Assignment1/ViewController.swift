


import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tblEmployee: UITableView!
    
    var employees: [NSManagedObject] = []
    
    let textCellIdentifier = "EmployeeCell"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Employees"
        let testUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "add.png"), style: .plain, target: self, action: #selector(self.newMovieClicked))
        self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        getData()
        tblEmployee.reloadData()
    }
    
    func getData()
    {
        do
        {
            employees = try context.fetch(Employee.fetchRequest())
        }
        catch
        {
            print("Fetching Failed")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CustomEmployeeCell = self.tblEmployee.dequeueReusableCell(withIdentifier: textCellIdentifier) as! CustomEmployeeCell
        
        let movie = employees[indexPath.row]
        
        cell.lblEmployeeName?.text = movie.value(forKeyPath: "empname") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let movie = employees[indexPath.row]
        
        let alert = UIAlertController(title: "Employee", message: movie.value(forKeyPath: "empname") as? String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let movie = employees[indexPath.row]
            context.delete(movie)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            getData()
        }
    }
    
    func newMovieClicked()
    {
        let lv1 = storyboard?.instantiateViewController(withIdentifier: "NewEmployee") as! NewEmployee
        navigationController?.pushViewController(lv1, animated: true)
    }
}

