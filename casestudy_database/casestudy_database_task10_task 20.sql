 
 use furama;

 /* 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”. */
 
 use furama;

 
 select dvdk.ma_dich_vu_di_kem, dvdk.ten_dich_vu_di_kem from dich_vu_di_kem dvdk 
 join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
 join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
 where hd.ma_khach_hang in (
 select kh.ma_khach_hang from loai_khach lk 
 join khach_hang kh on lk.ma_loai_khach = kh.ma_loai_khach
 where kh.ma_loai_khach = 1 and ( kh.dia_chi like '%Vinh' or kh.dia_chi like '%Quảng Ngãi' )
 );
 
 /* 12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, 
 so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), 
 tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 
 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021. */
 
 select hd.ma_hop_dong, nv.ho_ten, kh.ho_ten , kh.so_dien_thoai, hd.tien_dat_coc  , dv.ten_dich_vu ,hd.ngay_lam_hop_dong , sum(hdct.so_luong) from nhan_vien nv
 join hop_dong hd on nv.ma_nhan_vien = hd.ma_nhan_vien
 right join khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
 left join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
 left join hop_dong_chi_tiet hdct on hdct.ma_hop_dong = hd.ma_hop_dong
where  hd.ngay_lam_hop_dong in 
 (select ngay_lam_hop_dong 
 from hop_dong 
 where year(ngay_lam_hop_dong) = 2020 and (month(ngay_lam_hop_dong) between 9 and 12) )
 and hd.ngay_lam_hop_dong not in
  (select ngay_lam_hop_dong 
 from hop_dong 
 where year(ngay_lam_hop_dong) = 2021 and (month(ngay_lam_hop_dong) between 1 and 6) )
 group by hdct.ma_hop_dong;
 
select hd.ma_hop_dong, nv.ho_ten, kh.ho_ten , kh.so_dien_thoai, hd.tien_dat_coc  ,hd.ngay_lam_hop_dong , sum(hdct.so_luong) from nhan_vien nv
 join hop_dong hd on nv.ma_nhan_vien = hd.ma_nhan_vien
 right join khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang

 left join hop_dong_chi_tiet hdct on hdct.ma_hop_dong = hd.ma_hop_dong
where  hd.ngay_lam_hop_dong in 
 (select ngay_lam_hop_dong 
 from hop_dong 
 where year(ngay_lam_hop_dong) = 2020 and (month(ngay_lam_hop_dong) between 9 and 12) )
 and hd.ngay_lam_hop_dong not in
  (select ngay_lam_hop_dong 
 from hop_dong 
 where year(ngay_lam_hop_dong) = 2021 and (month(ngay_lam_hop_dong) between 1 and 6) )
 group by hdct.ma_hop_dong;
 
 
 
/* 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. 
(Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).*/

select dvdk.ma_dich_vu_di_kem , dvdk.ten_dich_vu_di_kem, sum(hdct.so_luong) as so_luong_su_dung from dich_vu_di_kem dvdk 
join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
group by dvdk.ma_dich_vu_di_kem
having so_luong_su_dung >= all (select sum(hdct.so_luong) from hop_dong_chi_tiet hdct
join dich_vu_di_kem dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem 
group by dvdk.ma_dich_vu_di_kem);

/* 14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem). */

select  hd.ma_hop_dong, dv.ten_dich_vu, dvdk.ten_dich_vu_di_kem, count(dvdk.ma_dich_vu_di_kem) so_lan
from dich_vu_di_kem dvdk
join hop_dong_chi_tiet hdct on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
join dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu
group by dvdk.ma_dich_vu_di_kem
having so_lan = 1
order by hd.ma_hop_dong;

/* 15.	Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, 
so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021. */

select nv.ma_nhan_vien,nv.ho_ten , bp.ten_bo_phan, td.ten_trinh_do , nv.dia_chi   , so_dien_thoai
from nhan_vien nv
join bo_phan bp on bp.ma_bo_phan = nv.ma_bo_phan
join trinh_do td on td.ma_trinh_do = nv.ma_trinh_do
join hop_dong hd on nv.ma_nhan_vien = hd.ma_hop_dong
where year(hd.ngay_lam_hop_dong) between 2020 and 2021
group by hd.ma_nhan_vien
having (count(hd.ma_nhan_vien) <=3) ;

select * from hop_dong;

select nv.ma_nhan_vien,ho_ten,ten_trinh_do,ten_bo_phan,dia_chi 
from nhan_vien nv
join trinh_do td on nv.ma_trinh_do=td.ma_trinh_do
join bo_phan bp on nv.ma_bo_phan=bp.ma_bo_phan
join vi_tri vt on vt.ma_vi_tri=nv.ma_vi_tri
join hop_dong hd on hd.ma_nhan_vien=nv.ma_nhan_vien
where year(hd.ngay_lam_hop_dong) between 2020 and 2021
group by hd.ma_nhan_vien
having (count(hd.ma_nhan_vien)<=3) ;

/* 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.  */

select * from nhan_vien
where ma_nhan_vien not in (
select ma_nhan_vien from hop_dong
where year(ngay_lam_hop_dong) between 2019 and 2021);

SET SQL_SAFE_UPDATES = 0;
delete from nhan_vien
where ma_nhan_vien not in (
select ma_nhan_vien from hop_dong
where year(ngay_lam_hop_dong) between 2019 and 2021);
SET SQL_SAFE_UPDATES = 1;

-- 17.	Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
--  chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.
 use furama;

select * from khach_hang kh
join hop_dong hd on kh.ma_khach_hang = hd.ma_khach_hang
join loai_khach lk on lk.ma_loai_khach = kh.ma_loai_khach
where kh.ho_ten in (
select  kh.ho_ten from loai_khach lk
join khach_hang kh on lk.ma_loai_khach = kh.ma_loai_khach
join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
join hop_dong_chi_tiet hdct on hdct.ma_hop_dong = hd.ma_hop_dong
join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
where year(hd.ngay_lam_hop_dong) = 2021
group by hd.ma_hop_dong
having sum(ifnull(hdct.so_luong, 0) * ifnull(dvdk.gia, 0) + ifnull(dv.chi_phi_thue, 0) ) > 10000000
) and lk.ma_loai_khach =2 ;

create view update_kh as
select kh.ma_loai_khach , kh.ho_ten  , kh.ma_khach_hang
from loai_khach lk
join khach_hang kh on lk.ma_loai_khach = kh.ma_loai_khach
join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
join hop_dong_chi_tiet hdct on hdct.ma_hop_dong = hd.ma_hop_dong
join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem 
where year(hd.ngay_lam_hop_dong) = 2021 and lk.ma_loai_khach =2 
group by hd.ma_hop_dong
having sum(ifnull(hdct.so_luong, 0) * ifnull(dvdk.gia, 0) + ifnull(dv.chi_phi_thue, 0) ) > 10000000 ;

select * from update_kh ;


update khach_hang
set ma_loai_khach = 1
where ma_khach_hang in (
select ma_khach_hang
from update_kh
);

select * from khach_hang ;
-- drop view update_kh ;

/* 18.	Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng). */

select * 
from loai_khach lk
join khach_hang kh on lk.ma_loai_khach = kh.ma_loai_khach
join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
where year( hd.ngay_lam_hop_dong ) < 2021;



-- create view delete_kh as
-- select kh.ma_khach_hang, lk.ten_loai_khach, kh.ho_ten
-- from loai_khach lk
-- join khach_hang kh on lk.ma_loai_khach = kh.ma_loai_khach
-- join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
-- where year( hd.ngay_lam_hop_dong ) < 2021;

-- select * from delete_kh;
-- drop view delete_kh ;

SET SQL_SAFE_UPDATES = 0;
SET foreign_key_checks = 0; 


delete from khach_hang 
where ma_khach_hang in ( 
	select ma_khach_hang 
    from
	(select kh.ma_khach_hang
    from khach_hang kh
	join hop_dong hd on kh.ma_khach_hang = hd.ma_khach_hang
	where year( hd.ngay_lam_hop_dong) < 2021 
	group by kh.ma_khach_hang ) as tim
);


SET foreign_key_checks =1;
SET SQL_SAFE_UPDATES = 1;
 
 
 
 /* 19.	Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi. */
 
 select * 
 from dich_vu_di_kem dvdk
 join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
 join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
 where year( hd.ngay_lam_hop_dong ) = 2020
 group by dvdk.ma_dich_vu_di_kem
 having sum(hdct.so_luong) > 10;
 
 create view up_dvdk as
 (select dvdk.ma_dich_vu_di_kem , dvdk.ten_dich_vu_di_kem
 from dich_vu_di_kem dvdk
 join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
 join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
 where year( hd.ngay_lam_hop_dong ) = 2020
 group by dvdk.ma_dich_vu_di_kem
 having sum(hdct.so_luong) > 10) ;
 
 select * from up_dvdk;
 
 SET SQL_SAFE_UPDATES = 0;
 
 update dich_vu_di_kem
 set gia = gia * 2 
 where ma_dich_vu_di_kem in ( select ma_dich_vu_di_kem 
 from up_dvdk);
 
 SET SQL_SAFE_UPDATES = 1;
 
 /* 20.	Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), 
 ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi. */
 
 
 select ma_nhan_vien as id, ho_ten, email, so_dien_thoai, ngay_sinh , dia_chi , 'nhan vien' as 'phan loai'
 from nhan_vien
 union
 select ma_khach_hang as id, ho_ten, email, so_dien_thoai, ngay_sinh , dia_chi , 'khach_hang' as 'phan loai'
 from khach_hang