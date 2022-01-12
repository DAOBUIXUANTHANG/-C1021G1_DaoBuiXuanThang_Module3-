drop database if exists chuyen_doi_erd ;

create database chuyen_doi_erd ;

use chuyen_doi_erd ;

create table phieu_xuat (
so_px varchar(45) primary key,
ngay_xuat datetime
);

create table vat_tu (
ma_vt varchar(45) primary key,
ten_vt varchar(45)
);

create table phieu_nhap (
so_pn varchar(45) primary key,
ngay_nhap datetime
);

create table chi_tiet_phieu_xuat (
so_px varchar(45),
ma_vt varchar(45),
don_gia double,
so_luong int,
foreign key (so_px) references phieu_xuat (so_px),
foreign key (ma_vt) references vat_tu (ma_vt),
primary key (so_px,ma_vt)
);

create table chi_tiet_phieu_nhap (
so_pn varchar(45),
ma_vt varchar(45),
don_gia double,
so_luong int,
foreign key (so_pn) references phieu_nhap (so_pn),
foreign key (ma_vt) references vat_tu (ma_vt),
primary key (so_pn,ma_vt)
);

create table nha_cung_cap (
ma_nha_cc varchar(45) primary key ,
ten_nha_cung_cap varchar(45),
dia_chi varchar(45)
);

create table so_dt (
so_dt varchar(45) ,
ma_nha_cc varchar(45),
foreign key (ma_nha_cc) references nha_cung_cap(ma_nha_cc) ,
primary key (so_dt,ma_nha_cc)
);

create table don_dat_hang (
so_dh varchar(45) primary key,
ngay_dh datetime
);

create table chi_tiet_don_dh (
so_dh varchar(45) ,
ma_vt varchar(45) ,
ma_nha_cc varchar(45) ,
foreign key (ma_nha_cc) references nha_cung_cap(ma_nha_cc) ,
foreign key (so_dh) references  don_dat_hang(so_dh),
foreign key (ma_vt) references vat_tu(ma_vt) ,
primary key (so_dh, ma_vt)
);