create table if not exists Genre (
	id serial primary key,
	name varchar(60) not null
);

create table if not exists Bands (
	id serial primary key,
	name varchar(60) unique not null
);

create table if not exists Genre_Band(
	Genre_id integer references Genre(id),
	Band_id integer references Bands(id),
	constraint pk_Genre_Band primary key (Genre_id, Band_id)
);

create table if not exists Album (
	id serial primary key,
	name varchar(60) unique not null,
	year integer
);

create table if not exists Band_Album (
	Album_id integer references Album(id),
	Band_id integer references Bands(id),
	constraint pk_Band_Album primary key (Album_id, Band_id)
);

create table if not exists Songs (
	id serial primary key,
	Album_id integer references Album(id),
	name varchar(60) not null,
	duration integer
);

create table if not exists Collection (
	id serial primary key,
	name varchar(60) not null,
	year integer
);

create table if not exists Song_Collection (
	Song_id integer references Songs(id),
	Collection_id integer references Collection(id),
	constraint pk_Song_Collection primary key (Song_id, Collection_id)
);

