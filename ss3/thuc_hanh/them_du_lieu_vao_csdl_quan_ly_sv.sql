use quan_ly_sinh_vien ;

insert into class value 
(1, 'A1', '2008-12-20', 1),
(2, 'A2', '2008-12-22', 1),
(3, 'B3', current_date, 0);

insert into student ( student_name, address, phone, `status`, class_id ) value 
('Hung', 'Ha Noi', '0912113113', 1, 1),
('Manh', 'HCM', '0123123123', 0, 2);

insert into student (student_name, address, `status`, class_id) value
('Hoa', 'Hai phong', 1, 1);

insert into `subject` value
(1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);


insert into mark (sub_id ,student_id ,mark, exam_times) value
(1, 1, 8, 1),
(1, 2, 10, 2),
(2, 1, 12, 1);


select * from class;
select * from student;
select * from `subject`;
select * from mark;