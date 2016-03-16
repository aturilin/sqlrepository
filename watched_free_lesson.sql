select distinct g.index, u.email as email
from foxford_mysql.user_lessons ul
join foxford_mysql.users u on u.id=ul.user_id and u.last_sign_in_at>'2015-08-01'
join foxford_mysql.grades g on u.grade_id=g.id
join foxford_mysql.lessons l on l.id = ul.lesson_id
where l.number = 1 and
ul.video_visited=1 or ul.translation_visited=1
having g.index not in (4,5,6,7,8)
order by g.index
;
