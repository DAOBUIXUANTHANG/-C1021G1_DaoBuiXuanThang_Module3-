use quan_ly_sinh_vien ;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from `subject` ;

select *, max(credit) from `subject` ;


-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
-- select *  from student s join mark m on s.student_id = m.student_id
-- join `subject` sb on sb.sub_id = m.sub_id ;

select sb.sub_name , max(m.mark ) from student s join mark m on s.student_id = m.student_id
join `subject` sb on sb.sub_id = m.sub_id;


-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần

SELECT S.student_id,S.student_name, AVG(Mark)
FROM Student S join Mark M on S.student_id = M.student_id
GROUP BY S.student_id, S.student_name