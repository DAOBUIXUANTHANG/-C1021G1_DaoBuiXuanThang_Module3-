drop database if exists quan_ly_diem_thi ;

create table quan_ly_diem_thi ;

use quan_ly_diem_thi ;

create table hoc_sinh (
ma_hs varchar(45) primary key,
ten_hs varchar(45) ,
ngay_sinh datetime,
lop varchar(45),
gt varchar(45)
);

create table mon_hoc (
ma_mh varchar(45) primary key,
ten_mh varchar(45)
);

create table bang_diem (
ma_hs varchar(45),
ma_mh varchar(45),
diem_thi int,
ngay_kt datetime,
primary key (ma_hs, ma_mh) ,
foreign key (ma_hs) references hoc_sinh (ma_hs),
foreign key (ma_mh) references mon_hoc (ma_mh)
);

create table giao_vien(
ma_gv varchar(45) primary key,
ten_gv varchar(45),
sdt varchar(45)
);

alter table mon_hoc add ma_gv varchar(45) ; 
alter table mon_hoc add constraint fk_ma_gv foreign key (ma_gv) references giao_vien (ma_gv);