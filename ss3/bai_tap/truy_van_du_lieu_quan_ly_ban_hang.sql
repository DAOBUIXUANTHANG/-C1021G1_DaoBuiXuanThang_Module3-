use quan_ly_ban_hang ;

insert into customer value 
(1,'Minh Quan',10),
(2,'Ngoc Oanh',20),
(3,'Hong Ha',50);

insert into `order` value 
(1,1,'2006-3-21',null),
(2,2,'2006-3-23',null),
(3,1,'2006-3-16',null) ;

insert into product value 
(1,'May Giat',3 ),
(2,'Tu Lanh',5 ),
(3,'Dieu Hoa',7 ),
(4,'Quat',1 ),
(5,'Bep Dien',2 );

insert into order_detail value 
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);




-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order

select o_id , o_date, o_total_price from `order` ;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách

select c.c_name , p.p_name from customer c join `order` o on c.c_id = o.c_id
join order_detail od on o.o_id = od.o_id
join product p on p.p_id = od.p_id ;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select * from customer c left join `order` o on c.c_id = o.c_id
where o.o_total_price = null;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)

select *, sum(p.p_price * od.order_qty) as tong_gia from `order`  o join order_detail od on o.o_id = od.o_id
join product p on p.p_id = od.p_id 
group by o.o_id




