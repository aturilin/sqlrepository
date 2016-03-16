create temporary table tmp as (
select u.id as user_id,u.first_name,u.last_name,g.index as grade_index,u.phone,(select count(*) from foxford_mysql.carts c2 where c2.user_id = u.id and c2.state='successful') as purchases,
(select count(*) from foxford_mysql.carts c3 where c3.user_id = u.id and (c3.state='created' or c3.state='pending')) as cart_created from 
 foxford_mysql.users u
 join foxford_mysql.grades g on g.id = u.grade_id
where u.created_at between '2016-02-22' and '2016-03-07'
and u.phone is NOT NULL and grade_id in (4,5,6)
having purchases=0 and cart_created=1);

select 'dbr.hdr', 'user_id','first_name','grade_index','phone';

select tmp.*,co.name,co.subtitle from tmp 
join foxford_mysql.carts c on tmp.user_id = c.user_id
join foxford_mysql.cart_items ci on ci.cart_id = c.id
join foxford_mysql.courses co on co.id = ci.course_id;


create temporary table tmp2 as (
select u.id as user_id,u.first_name,u.last_name,g.index as grade_index,u.phone,(select count(*) from foxford_mysql.carts c2 where c2.user_id = u.id) as carts_cnt,
(select count(*) from foxford_mysql.users_courses uc where uc.user_id = u.id) as users_courses_cnt from 
 foxford_mysql.users u
 join foxford_mysql.grades g on g.id = u.grade_id
where u.created_at between '2016-02-22' and '2016-03-07'
and u.phone is NOT NULL and grade_id in (4,6)
having carts_cnt=0 and users_courses_cnt>0);


select 'dbr.hdr', 'user_id','first_name','grade_index','phone';

select tmp2.*,co.name,co.subtitle from tmp2
join foxford_mysql.users_courses uc on tmp2.user_id = uc.user_id
join foxford_mysql.courses co on co.id = uc.course_id;
