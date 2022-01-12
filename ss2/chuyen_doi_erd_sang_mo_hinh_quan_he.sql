drop database if exists don_dat_hang;

create database don_dat_hang;
use don_dat_hang;
CREATE TABLE customers (
    customer_number INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    contact_Lastname VARCHAR(50) NOT NULL,
    contact_firstname VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    address_line1 VARCHAR(50) NOT NULL,
    address_line2 VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(15) NOT NULL,
    country VARCHAR(50) NOT NULL,
    credit_limit DOUBLE
);

CREATE TABLE offices (
    office_code VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    address_line1 VARCHAR(50) NOT NULL,
    address_line2 VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    postal_code VARCHAR(15) NOT NULL
);

CREATE TABLE employees (
    employee_number INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    job_title VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_code VARCHAR(15) PRIMARY KEY,
    product_name VARCHAR(70) NOT NULL,
    product_scale VARCHAR(10) NOT NULL,
    product_vendor VARCHAR(50) NOT NULL,
    product_description TEXT NOT NULL,
    quantity_inStock INT NOT NULL,
    buy_price DOUBLE NOT NULL,
    MSRP DOUBLE NOT NULL
);

CREATE TABLE productlines (
    product_line VARCHAR(50) PRIMARY KEY,
    text_description TEXT,
    image VARCHAR(255)
);

CREATE TABLE orders (
    order_number INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE,
    status VARCHAR(15) NOT NULL,
    comments TEXT,
    quantity_ordered INT NOT NULL,
    price_each DOUBLE NOT NULL
);

CREATE TABLE payments (
    customer_number INT NOT NULL,
    check_number VARCHAR(50) PRIMARY KEY,
    payment_date DATE NOT NULL,
    amount DOUBLE NOT NULL
);

alter table customers
add employee_number INT NOT NULL,
add FOREIGN KEY (employee_number) REFERENCES employees (employee_number);
        
alter table employees
add office_code VARCHAR(10) NOT NULL,
add manager_number int NOT NULL,
add FOREIGN KEY (office_code) REFERENCES offices (office_code),
add FOREIGN KEY (manager_number) REFERENCES employees (employee_number);

alter table products
add product_line VARCHAR(50) NOT NULL,
add FOREIGN KEY (product_line) REFERENCES productlines (product_line);

alter table orders
add customer_number INT NOT NULL,
add FOREIGN KEY (customer_number) REFERENCES customers (customer_number);

alter table payments
add FOREIGN KEY (customer_number) REFERENCES customers (customer_number);

CREATE TABLE order_details (
    order_number INT,
    product_code VARCHAR(15),
    quantity_ordered INT NOT NULL,
    price_each DOUBLE NOT NULL,
    PRIMARY KEY (order_number , product_code),
    FOREIGN KEY (order_number)
        REFERENCES orders (order_number),
    FOREIGN KEY (product_code)
        REFERENCES products (product_code)
);

 alter table orders
 drop quantity_ordered,
 drop price_each;