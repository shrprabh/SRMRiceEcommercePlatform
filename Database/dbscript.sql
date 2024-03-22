CREATE Datbase SidhalingeswaraRiceMill;

USE SidhalingeswaraRiceMill;

-- Department table
CREATE TABLE IF NOT EXISTS Department_tbl (
    Department_id INT PRIMARY KEY,
    Department_name VARCHAR(255),
    Department_location VARCHAR(255),
    Contact_email VARCHAR(255),
    Contact_phone VARCHAR(15)
);

-- Role table
CREATE TABLE IF NOT EXISTS Role_tbl (
    Role_id INT PRIMARY KEY,
    Role_name VARCHAR(255),
    Dept_id INT,
    FOREIGN KEY (Dept_id) REFERENCES Department_tbl(Department_id)
);

-- Address table
CREATE TABLE IF NOT EXISTS Address_tbl (
    Address_id INT PRIMARY KEY AUTO_INCREMENT,
    Entity_id INT,
    Entity_type VARCHAR(50),
    Address VARCHAR(255),
    City VARCHAR(255),
    State VARCHAR(255),
    Pincode VARCHAR(20),
    Country VARCHAR(255),
    Language VARCHAR(50)
);

-- Employee table
CREATE TABLE IF NOT EXISTS Employee_tbl (
    Employee_id INT PRIMARY KEY,
    Employee_name VARCHAR(255),
    Role INT,
    Dob_day INT,
    Dob_month INT,
    Dob_year INT,
    Department_id INT,
    Address_id INT,
    Email VARCHAR(255),
    Phone VARCHAR(15),
    FOREIGN KEY (Role) REFERENCES Role_tbl(Role_id),
    FOREIGN KEY (Department_id) REFERENCES Department_tbl(Department_id),
    FOREIGN KEY (Address_id) REFERENCES Address_tbl(Address_id)
);

-- Customers table
CREATE TABLE IF NOT EXISTS Customers (
    Customer_id INT PRIMARY KEY,
    Name VARCHAR(255),
    Gmail VARCHAR(255),
    Password VARCHAR(255),
    Dob DATE,
    Address_id INT,
    Phone VARCHAR(15),
    FOREIGN KEY (Address_id) REFERENCES Address_tbl(Address_id)
);

-- Product table
CREATE TABLE IF NOT EXISTS Product_tbl (
    Product_id INT PRIMARY KEY,
    Product_type VARCHAR(255),
    Price DECIMAL(10, 2),
    Product_description TEXT,
    Quantity_available INT
);

-- Orders table
CREATE TABLE IF NOT EXISTS Orders_tbl (
    Order_id INT PRIMARY KEY,
    Price DECIMAL(10, 2),
    Quantity INT,
    Cost DECIMAL(10, 2),
    Tax DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    Product_id INT,
    Order_date DATE,
    Order_day INT,
    Order_month INT,
    Order_year INT,
    Order_status VARCHAR(50),
    Shipping_id INT,
    Employee_id INT,
    Customer_id INT,
    FOREIGN KEY (Product_id) REFERENCES Product_tbl(Product_id),
    FOREIGN KEY (Employee_id) REFERENCES Employee_tbl(Employee_id),
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);

-- Shipping table
CREATE TABLE IF NOT EXISTS Shipping_table (
    Shipping_id INT PRIMARY KEY,
    Shipping_date DATE,
    Estimated_delivery_date DATE,
    Actual_delivery_date DATE,
    Order_id INT,
    Shipping_status VARCHAR(50),
    FOREIGN KEY (Order_id) REFERENCES Orders_tbl(Order_id)
);

-- Delivery table
CREATE TABLE IF NOT EXISTS Delivery_table (
    Delivery_id INT PRIMARY KEY,
    Customer_id INT,
    Order_id INT,
    Shipping_id INT,
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id),
    FOREIGN KEY (Order_id) REFERENCES Orders_tbl(Order_id),
    FOREIGN KEY (Shipping_id) REFERENCES Shipping_table(Shipping_id)
);

-- Salary table
CREATE TABLE IF NOT EXISTS Salary_tbl (
    Salary_id INT PRIMARY KEY,
    Salary DECIMAL(10, 2),
    Bonus DECIMAL(10, 2),
    Salary_date DATE,
    Employee_id INT,
    FOREIGN KEY (Employee_id) REFERENCES Employee_tbl(Employee_id)
);

-- Location data table
CREATE TABLE IF NOT EXISTS Location_data (
    Pincode VARCHAR(20) PRIMARY KEY,
    City_name VARCHAR(255),
    State_name VARCHAR(255),
    Country_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Cart (
    Cart_id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_id INT,
    Product_id INT,
    Quantity INT,
    Added_date DATE,
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id),
    FOREIGN KEY (Product_id) REFERENCES Product_tbl(Product_id)
);

ALTER TABLE Orders_tbl DROP FOREIGN KEY orders_tbl_ibfk_2;
ALTER TABLE Salary_tbl DROP FOREIGN KEY salary_tbl_ibfk_1;
ALTER TABLE Employee_tbl MODIFY COLUMN Employee_id INT AUTO_INCREMENT;
ALTER TABLE Orders_tbl
ADD CONSTRAINT orders_tbl_ibfk_2 FOREIGN KEY (Employee_id) REFERENCES Employee_tbl(Employee_id);
ALTER TABLE Salary_tbl
ADD CONSTRAINT salary_tbl_ibfk_1 FOREIGN KEY (Employee_id) REFERENCES Employee_tbl(Employee_id);

-- Inserting sample records into each table
-- [Insert statements...]

-- Inserting into Department_tbl
INSERT INTO Department_tbl (Department_id, Department_name, Department_location, Contact_email, Contact_phone) 
VALUES (1, 'Administration', 'Main Building', 'admin@example.com', '1234567890');

-- Inserting into Role_tbl
INSERT INTO Role_tbl (Role_id, Role_name, Dept_id) 
VALUES (1, 'Manager', 1);

-- Inserting into Address_tbl
INSERT INTO Address_tbl (Entity_id, Entity_type, Address, City, State, Pincode, Country, Language) 
VALUES (1, 'Employee', '123 Street', 'City', 'State', '12345', 'Country', 'English');

-- Inserting into Employee_tbl
INSERT INTO Employee_tbl (Employee_id, Employee_name, Role, Dob_day, Dob_month, Dob_year, Department_id, Address_id, Email, Phone) 
VALUES (1, 'John Doe', 1, 15, 6, 1985, 1, 1, 'john.doe@example.com', '0987654321');

-- Inserting into Customers
INSERT INTO Customers (Customer_id, Name, Gmail, Password, Dob, Address_id, Phone) 
VALUES (1, 'Jane Doe', 'jane.doe@gmail.com', 'password', '1980-01-01', 1, '9876543210');

-- Inserting into Product_tbl
INSERT INTO Product_tbl (Product_id, Product_type, Price, Product_description, Quantity_available) 
VALUES (1, 'Rice', 50.00, 'High-quality rice', 100);

-- Inserting into Orders_tbl
INSERT INTO Orders_tbl (Order_id, Price, Quantity, Cost, Tax, Total, Product_id, Order_date, Order_day, Order_month, Order_year, Order_status, Shipping_id, Employee_id, Customer_id) 
VALUES (1, 100.00, 2, 90.00, 10.00, 110.00, 1, '2020-06-15', 15, 6, 2020, 'Delivered', 1, 1, 1);

-- Inserting into Shipping_table
INSERT INTO Shipping_table (Shipping_id, Shipping_date, Estimated_delivery_date, Actual_delivery_date, Order_id, Shipping_status) 
VALUES (1, '2020-06-16', '2020-06-20', '2020-06-18', 1, 'Delivered');

-- Inserting into Delivery_table
INSERT INTO Delivery_table (Delivery_id, Customer_id, Order_id, Shipping_id) 
VALUES (1, 1, 1, 1);

-- Inserting into Salary_tbl
INSERT INTO Salary_tbl (Salary_id, Salary, Bonus, Salary_date, Employee_id) 
VALUES (1, 5000.00, 500.00, '2020-06-01', 1);

-- Inserting into Location_data
INSERT INTO Location_data (Pincode, City_name, State_name, Country_name) 
VALUES ('12345', 'City', 'State', 'Country');
-- Inserting into Cart
INSERT INTO Cart (Customer_id, Product_id, Quantity, Added_date) 
VALUES (1, 1, 2, '2020-06-15');


