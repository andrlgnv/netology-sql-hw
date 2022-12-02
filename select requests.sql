select name, year from album
where year = 2018;

select name, duration from songs
order by duration desc
limit 1;

select name, duration from songs
where duration >= 210;

select name, year from collection
where year between 2018 and 2021;

select name from bands
where name not like '% %';

select name from songs
where lower(name) like '%my%' or lower(name) like '%мой%';