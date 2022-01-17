/* 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống 
có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự. */
use furama;

select * from nhan_vien 
where (ho_ten like 'T%' or ho_ten like  'H%' or ho_ten like 'K%' ) and char_length(ho_ten) < 16 ;

/* 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”. */

select ma_khach_hang, ho_ten from khach_hang 
where ( (year(curdate()) - year(ngay_sinh) ) between 18 and 50 )
and ( dia_chi like '%Đà Nẵng%' or dia_chi like '%Quảng Trị' );

/* 4.Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”. */

select *, count(hd.ma_hop_dong)  so_lan_dat_phong  from loai_khach lk join khach_hang kh on lk.ma_loai_khach = kh.ma_loai_khach 
join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang 
group by kh.ma_khach_hang
having kh.ma_loai_khach = 1;

/* 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, 
tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem,
 hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).*/
 
 select kh.ma_khach_hang, lk.ten_loai_khach, hd.ma_hop_dong, dv.ten_dich_vu, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc , sum(dv.chi_phi_thue + hdct.so_luong * dvdk.gia) from loai_khach  lk
 join khach_hang  kh on lk.ma_loai_khach = kh.ma_loai_khach 
 left join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
 left join dich_vu  dv on  dv.ma_dich_vu = hd.ma_dich_vu
 left join hop_dong_chi_tiet hdct on hdct.ma_hop_dong = hd.ma_hop_dong
 left join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
 group by hd.ma_hop_dong
 order by kh.ma_khach_hang;
 
 /* 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu 
 của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).*/
 
 select dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.chi_phi_thue , ldv.ten_loai_dich_vu from loai_dich_vu ldv join
 dich_vu dv on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
 left join hop_dong hd  on dv.ma_dich_vu = hd.ma_dich_vu 
 where dv.ma_dich_vu not in 
 ( select dv.ma_dich_vu from hop_dong hd join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu 
 where month(ngay_lam_hop_dong) between 1 and 3 )
group by dv.ma_dich_vu;

/* 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu
 của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.*/
 
 select * from loai_dich_vu ldv 
 join dich_vu dv on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu 
where dv.ma_dich_vu in 
(select dv.ma_dich_vu from loai_dich_vu ldv 
join dich_vu on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
join hop_dong hd on dv.ma_dich_vu = hd.ma_dich_vu where year(hd.ngay_lam_hop_dong) = 2020) 
and dv.ma_dich_vu not in 
(select dv.ma_dich_vu from loai_dich_vu ldv 
join dich_vu on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
join hop_dong hd on dv.ma_dich_vu = hd.ma_dich_vu where year(hd.ngay_lam_hop_dong) = 2021);
 
 

 /* 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau*/
 
 select * from khach_hang;
 
 /* 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng */
 
 select month(hd.ngay_lam_hop_dong) as thang , count(kh.ma_khach_hang) from khach_hang kh 
 join hop_dong hd on kh.ma_khach_hang = hd.ma_khach_hang 
 group by thang
 order by thang ;
 
 /* 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem). */ 
select hd.ma_hop_dong, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc, hd.tien_dat_coc, sum(hdct.so_luong) as so_luong_dich_vu_di_kem from hop_dong hd
left join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
left  join dich_vu_di_kem dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
group by hd.ma_hop_dong
order by hd.ma_hop_dong ;
