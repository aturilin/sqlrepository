select 'dbr.count', 'email';
select distinct g.index, u.email as email
from foxford_mysql.user_events ue
join foxford_mysql.users u on u.id=ue.user_id and u.last_sign_in_at>'2015-08-01'
join foxford_mysql.grades g on u.grade_id=g.id
where ue.visited = 1
having g.index not in (4,5,6,7,8)
order by g.index
;
