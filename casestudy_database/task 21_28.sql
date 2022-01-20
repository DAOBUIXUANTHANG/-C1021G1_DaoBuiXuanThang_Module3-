use furama;

select * from hop_dong;

-- task 21
create view v_nhan_vien as
select * from nhan_vien nv
where nv.dia_chi = 'Hải Châu' and ma_nhan_vien in
( select ma_nhan_vien from hop_dong
where ngay_lam_hop_dong like '2019-12-12'
);

select * from v_nhan_vien ;

-- task 22 : chua lam 
update nhan_vien
set dia_chi = 'Liên Chiểu'
where ma_nhan_vien in (
select ma_nhan_vien from v_nhan_vien 
);

-- 23 :

 DELIMITER //
 CREATE procedure sp_xoa_khach_hang (
 IN id_khach_hang int
 )
 begin
 delete from khach_hang 
 where ma_khach_hang = id_khach_hang ;

 end // 
 DELIMITER ;
 
 -- task 24
