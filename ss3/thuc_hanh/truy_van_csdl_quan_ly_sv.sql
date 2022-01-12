
-- Bước 1: Sử dụng câu lệnh Use QuanLySinhVien để sử dụng cơ sở dữ liệu:
use quan_ly_sinh_vien ;

-- Bước 2: Sử dụng câu lệnh Select * và lấy dữ liệu học viên từ bảng Student để hiển thị danh sách tất cả các học viên như sau:
select * from student ;

-- Bước 3: Để hiển thị danh sách học viên đang theo học cần phải sử dụng câu lệnh select ... from kèm theo where để xét điều kiện truy vấn như sau:
select * from student where `status` = true;

-- Bước 4: Sử dụng điều kiện where Credit < 10 và from Subject để lấy ra danh sách các môn học có thời gian học nhỏ hơn 10:
select * from `subject` where credit < 10;

-- Bước 5: Sử dụng câu lệnh Join và where để hiển thị danh sách học viên lớp A1
select s.student_id , s.student_name, c.class_name from student s join  class c on s.class_id = c.class_id;


select s.student_id , s.student_name, c.class_name from student s join class c on s.class_id = c.class_id
where c.class_name = 'A1';

-- Bước 6: Hiển thị điểm môn CF của các học viên

select * from student s join mark m on s.student_id = m.student_id 
join `subject` sb on m.sub_id = sb.sub_id;

select * from student s join mark m on s.student_id = m.student_id 
join `subject` sb on m.sub_id = sb.sub_id
where sb.sub_name ='CF';