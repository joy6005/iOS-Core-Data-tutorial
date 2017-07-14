

import Foundation

class EmployeeMaster
{
    var EmployeeId: Int!
    var EmployeeName: String!
    var BirthDate: String!
    var Salary: String!
    
    init(EmployeeId: Int, EmployeeName: String, BirthDate: String, Salary: String)
    {
        self.EmployeeId = EmployeeId
        self.EmployeeName = EmployeeName
        self.BirthDate = BirthDate
        self.Salary = Salary
    }
    
    public func getEmployeeId() -> Int!
    {
        return self.EmployeeId
    }
    public func getEmployeeName() -> String!
    {
        return self.EmployeeName
    }
    public func getBirthDate() -> String!
    {
        return self.BirthDate
    }
    public func getSalary() -> String!
    {
        return self.Salary
    }
}
