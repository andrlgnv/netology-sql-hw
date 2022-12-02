-- количество исполнителей в каждом жанре
select g.name, count(*) from genre_band gb
left join genre g on gb.genre_id = g.id
group by g.name;

-- количество треков, вошедших в альбомы 2019-2020 годов
select count(s.id) from songs s
left join album a on s.album_id = a.id
where a.year between 2019 and 2020;

-- средняя продолжительность треков по каждому альбому
select a.name, round(avg(s.duration), 0) from songs s
left join album a on s.album_id = a.id
group by a.id;

-- все исполнители, которые не выпустили альбомы в 2020 году
select name from bands b2
except
select b.name from band_album ba
join album a on a.id = ba.album_id
join bands b on b.id = ba.band_id
where a.year = 2020;

-- названия сборников, в которых присутствует конкретный исполнитель (выберите сами)
select distinct c.name from collection c
join song_collection sc on sc.collection_id = c.id
join songs s on s.id = sc.song_id 
join album a on a.id = s.album_id 
join band_album ba on ba.band_id = a.id 
join bands b on b.id = ba.band_id 
where b.name = 'LSP';

-- название альбомов, в которых присутствуют исполнители более 1 жанра
select a.name, count(g.name) from album a
join band_album ba on ba.album_id = a.id 
join bands b on b.id = ba.band_id 
join genre_band gb on gb.band_id = b.id 
join genre g on g.id = gb.genre_id
group by a.name
having count(g.name) > 1
order by a.name;

-- наименование треков, которые не входят в сборники
select s.name from songs s
left join song_collection sc on sc.song_id = s.id 
where sc.collection_id is null;

-- исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)
select b.name, s.duration from songs s
left join album a on a.id = s.album_id 
left join band_album ba on ba.album_id = a.id 
left join bands b on b.id = ba.band_id 
group by b.name, s.duration
having s.duration = (select min(duration) from songs)
order by b.name;

-- название альбомов, содержащих наименьшее количество треков
select distinct a.name from album a 
left join songs s on s.album_id = a.id 
where s.album_id in (
	select album_id from songs 
	group by album_id
	having count(id) = (
		select count(id) from songs
		group by album_id
		order by count
		limit 1
		)
	)
order by a.name;