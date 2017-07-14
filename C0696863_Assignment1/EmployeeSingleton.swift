
import Foundation

class EmployeeSingleton
{
    var employeeList = [EmployeeMaster]()
    
    init(){}
    
    static let sharedInstant: EmployeeSingleton = EmployeeSingleton()
    
    func addEmployee(newEmployee: EmployeeMaster)
    {
        employeeList.append(newEmployee)
    }
    
    func getAllEmployees() -> [EmployeeMaster]
    {
        return employeeList
    }
}
