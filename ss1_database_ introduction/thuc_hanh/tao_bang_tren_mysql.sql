drop database if exists student_management ;

create database `student_management` ;

create table student_management.`student` (
id int not null primary key,
`name` varchar(45) null,
age int null,
country varchar(45) null
);