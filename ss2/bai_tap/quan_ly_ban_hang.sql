drop database if exists quan_ly_ban_hang ;

create database quan_ly_ban_hang ;

use quan_ly_ban_hang ;

create table customer (
c_id varchar(45) primary key ,
c_name varchar(45),
c_age varchar(45)
);

create table `order` (
o_id varchar(45) primary key,
c_id varchar(45),
o_date datetime,
o_total_price double,
foreign key (c_id) references customer(c_id)
);

create table product (
p_id varchar(45) primary key,
p_name varchar(45),
p_price varchar(45)
);

-- order_qty : so luong san pham
create table order_detail (
o_id varchar(45),
p_id varchar(45),
order_qty int,
foreign key (o_id) references `order` ( o_id),
foreign key (p_id) references product ( p_id),
primary key ( o_id, p_id)
);