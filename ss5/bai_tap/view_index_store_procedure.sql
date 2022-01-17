drop database if exists view_index_sp;

create database view_index_sp;
use view_index_sp;
create table product (
id int auto_increment primary key,
product_code int ,
product_name varchar (50),
product_price double ,
product_amount int,
product_destription varchar(255),
product_status varchar(45)
);


insert into product value 
(1,123,'Iphone 10',12222,12,'nhap ngoai','con hang'),
(2,124,'Iphone 11',13333,12,'nhap ngoai','con hang'),
(3,125,'Iphone 12',14000,12,'mua lai','con hang'),
(4,126,'Iphone 13',150000,12,'mua lai','con hang');


-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
create unique index product_index on product(product_code) ;

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
create index composite_index on product(product_name, product_price);


-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from product where product_code = 1 ;

explain select * from product where product_name = 'Iphone 10' and product_price = 12222;

-- Bước 4:
-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view product_view as
select product_code, product_name, product_price , product_status 
from product ;

-- Tiến hành sửa đổi view
create or replace view product_view as 
select product_code, product_name, product_price 
from product ;

select * from product_view;


--  Tiến hành xoá view
drop view product_view;

-- Bước 5:

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product 

DELIMITER //
create procedure select_all ()
begin
select * from product;

end // 
DELIMITER ;

call select_all ();

-- Tạo store procedure thêm một sản phẩm mới
DELIMITER //
CREATE PROCEDURE CREATE_PR(
IN product_code1 INT , 
 product_name1 varchar(45) , 
 product_price1 double ,
 product_amount1 int, 
 product_destription1 varchar(255) , product_status1 varchar(45) )
BEGIN
INSERT INTO PRODUCT(product_code,product_name,product_price,product_amount,product_destription , product_status) value
(product_code1, product_name1, product_price1, product_amount1, product_destription1 , product_status1);
END //
DELIMITER ;

CALL CREATE_PR (127,'Iphone 10',12222,12,'nhap ngoai','con hang') ;

call select_all ();

-- Tạo store procedure sửa thông tin sản phẩm theo id

DELIMITER //
CREATE PROCEDURE UPDATE_PR(
IN id_in INT , 
 product_name_in varchar(45) , 
 product_price_in double ,
 product_amount_in int, 
 product_destription_in varchar(255) , product_status_in varchar(45) )
BEGIN
UPDATE product set
product_name = product_name_in ,
product_price =  product_price_in,
product_amount = product_amount_in,
product_destription =  product_destription_in,
product_status = product_status_in
where id = id_in ;
END //
DELIMITER ;

CALL select_all ();

CALL  UPDATE_PR (5,'Iphone x',1000000,10,'nhap ngoai','con hang');

CALL select_all ();

-- Tạo store procedure xoá sản phẩm theo id
DELIMITER //
CREATE PROCEDURE DELETE_PR (
IN id_in INT  )
BEGIN
DELETE FROM product
where id = id_in ;
END //
DELIMITER ;

 CALL  DELETE_PR(1);
CALL select_all ();