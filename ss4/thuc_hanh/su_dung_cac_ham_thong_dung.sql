-- Bước 1: Sử dụng câu lệnh Use QuanLySinhVien để sử dụng cơ sở dữ liệu:

use quan_ly_sinh_vien ;

-- Bước 2: Sử dụng hàm count để hiển thị số lượng sinh viên ở từng nơi

select address , count(student_id) as 'số lượng sinh viên' from student 
group by address;

-- Bước 3: Tính điểm trung bình các môn học của mỗi học viên bằng cách sử dụng hàm AVG

select s.student_id , s.student_name , avg(m.mark )  from student s join mark m on s.student_id = m.student_id 
group by s.student_id , s.student_name ;

-- Bước 4: Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15
SELECT S.student_id,S.student_name, AVG(Mark)
FROM Student S join Mark M on S.student_id = M.student_id
GROUP BY S.student_id, S.student_name;

-- Sử dụng having để xét điều kiện điểm trung bình các môn học phải lớn hơn 15

SELECT S.student_id,S.student_name, AVG(Mark)
FROM Student S join Mark M on S.student_id = M.student_id
GROUP BY S.student_id, S.student_name
having avg(mark ) > 15;

select * from mark ;

-- Bước 5: Hiển thị thông tin các học viên có điểm trung bình lớn nhất.

-- Hiển thị danh sách điểm trung bình của các học viên

SELECT S.student_id,S.student_name, AVG(Mark)
FROM Student S join Mark M on S.student_id = M.student_id
GROUP BY S.student_id, S.student_name
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.Student_Id);
