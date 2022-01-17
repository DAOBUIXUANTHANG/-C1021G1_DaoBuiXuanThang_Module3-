 
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