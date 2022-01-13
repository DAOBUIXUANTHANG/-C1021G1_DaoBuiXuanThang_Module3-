drop database if exists quan_ly_ban_hang ;

create database quan_ly_ban_hang ;

use quan_ly_ban_hang ;

create table customer (
c_id int primary key ,
c_name varchar(45),
c_age tinyint
);

create table `order` (
o_id int primary key,
c_id int,
o_date datetime,
o_total_price int,
foreign key (c_id) references customer(c_id)
);

create table product (
p_id int primary key,
p_name varchar(45),
p_price int
);

-- order_qty : so luong san pham
create table order_detail (
o_id int,
p_id int,
order_qty int,
foreign key (o_id) references `order` ( o_id),
foreign key (p_id) references product ( p_id),
primary key ( o_id, p_id)
);