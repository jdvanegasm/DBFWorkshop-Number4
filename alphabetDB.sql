drop database if exists AlphabetDB;
create database AlphabetDB;

create table alphabetdb.country(
	country_id int auto_increment primary key,
	name varchar(25) unique not null
);

create table alphabetdb.user(
	user_id varchar(36) primary key,
	name varchar(50) not null,
	email varchar(30) unique,
	phone varchar(50),
	nickname varchar(20) unique not null,
	password_ varchar(30) not null,
	country_fk int not null,
	foreign key (country_fk) references country(country_id)
);

create table alphabetdb.genre(
	genre_id int auto_increment primary key,
	name varchar(15) not null,
	description varchar(100)
);

create table alphabetdb.channel(
	channel_id int auto_increment primary key,
	description varchar(200),
	user_fk varchar(36),
	foreign key (user_fk) references user(user_id)
);

create table alphabetdb.video(
	video_id int auto_increment primary key,
	name varchar(100) not null,
	description varchar(200),
	date_upload int not null,
	likes int default(0),
	dislikes int default(0),
	user_fk varchar(36),
	genre_fk int,
	channel_fk int,
	foreign key (user_fk) references user(user_id),
	foreign key (genre_fk) references genre(genre_id),
	foreign key (channel_fk) references channel(channel_id)
);

create table alphabetdb.playlist(
	playlist_id int auto_increment primary key,
	name varchar(30) not null,
	likes int default(0),
	user_fk varchar(36),
	foreign key (user_fk) references user(user_id)
);

create table alphabetdb.bankAccount(
	bankAccount_id varchar(36) primary key, 
	bank_name varchar (40) not null,
	account_number varchar(16) unique not null,
	country_fk int,
	user_fk varchar(36),
	foreign key (country_fk) references country(country_id),
	foreign key (user_fk) references user(user_id)
);

create table alphabetdb.community(
	community_id int auto_increment primary key,
	name varchar(25) unique not null,
	description varchar(200)
);

create table alphabetdb.playlist_video_rel(
	playlist_fk int,
	video_fk int,
	primary key (playlist_fk, video_fk),
	foreign key (playlist_fk) references playlist(playlist_id),
	foreign key (video_fk) references video(video_id)
);

create table alphabetdb.comment(
	comment_id int auto_increment primary key,
	content varchar(300) not null, 
	date_creation int not null,
	likes int default(0),
	dislikes int default(0),
	user_fk varchar(36),
	video_fk int,
	foreign key (user_fk) references user(user_id),
	foreign key (video_fk) references video(video_id)
);

create table alphabetdb.community_user_rel(
	community_fk int,
	user_fk varchar(36),
	expiration_date int,
	primary key (community_fk, user_fk),
	foreign key (community_fk) references community(community_id),
	foreign key (user_fk) references user(user_id)
);
	
create table alphabetdb.suscriber_rel(
	user_fk varchar(36),
	channel_fk int,
	pay bool default(false),
	pay_cost float default(0.0),
	date_subscription int not null,
	primary key (user_fk, channel_fk),
	foreign key (user_fk) references user(user_id),
	foreign key (channel_fk) references channel(channel_id)
);

-- country
insert into alphabetdb.country (name) values
('Colombia'),
('Estados Unidos'),
('Canadá'),
('España'),
('México');

-- user
insert into alphabetdb.user (user_id, name, email, phone, nickname, password_, country_fk) values
(uuid(), 'Juan Perez', 'juanperez@mail.com', '3200000001', 'JuanP', 'password1', 1),
(uuid(), 'Laura García', 'lauragarcia@mail.com', '3200000002', 'LauraG', 'password2', 2),
(uuid(), 'Carlos López', 'carloslopez@mail.com', '3200000003', 'CarlosL', 'password3', 3),
(uuid(), 'Sofía Martín', 'sofiamartin@mail.com', '3200000004', 'SofiaM', 'password4', 4),
(uuid(), 'David Ruiz', 'davidruiz@mail.com', '3200000005', 'DavidR', 'password5', 5),
(uuid(), 'Ana Torres', 'anatorres@mail.com', '3200000006', 'AnaT', 'password6', 1),
(uuid(), 'Luis Hernández', 'luishernandez@mail.com', '3200000007', 'LuisH', 'password7', 2),
(uuid(), 'Diana Gómez', 'dianagomez@mail.com', '3200000008', 'DianaG', 'password8', 3),
(uuid(), 'Roberto Díaz', 'robertodiaz@mail.com', '3200000009', 'RobertoD', 'password9', 4),
(uuid(), 'Lucía Moreno', 'luciamoreno@mail.com', '3200000010', 'LuciaM', 'password10', 5);

-- genre
insert into alphabetdb.genre (name, description) values
('Drama', 'Contenidos con tramas intensas y emotivas'),
('Comedia', 'Contenidos humorísticos y divertidos'),
('Documental', 'Contenidos educativos y informativos'),
('Aventura', 'Contenidos de exploración y aventura'),
('Ciencia Ficción', 'Contenidos futuristas y fantásticos');

-- channel
use alphabetdb;
insert into channel (description, user_fk) values
('Canal de viajes y aventuras', (select user_id from user where nickname = 'JuanP')),
('Canal de cocina y gastronomía', (select user_id from user where nickname = 'LauraG')),
('Canal de tecnología y gadgets', (select user_id from user where nickname = 'CarlosL')),
('Canal de tutoriales y DIY', (select user_id from user where nickname = 'SofiaM')),
('Canal de fitness y bienestar', (select user_id from user where nickname = 'DavidR'));

-- video
insert into alphabetdb.video (name, description, date_upload, user_fk, genre_fk, channel_fk) values
('Un día en las montañas', 'Explorando las montañas más altas del mundo', 20240520, (select user_id from user where nickname = 'JuanP'), 4, 1),
('Receta de paella', 'Cómo hacer una auténtica paella española', 20240519, (select user_id from user where nickname = 'LauraG'), 2, 2),
('Review iPhone 14', 'Análisis completo del nuevo iPhone 14', 20240518, (select user_id from user where nickname = 'CarlosL'), 3, 3),
('Hazlo tú mismo: estantería', 'Crea tu propia estantería con materiales reciclados', 20240517, (select user_id from user where nickname = 'SofiaM'), 1, 4),
('Rutina de yoga para principiantes', 'Empieza tu día con esta sencilla rutina de yoga', 20240516, (select user_id from user where nickname = 'DavidR'), 1, 5),
('La historia de la ciencia', 'Un recorrido por los grandes descubrimientos científicos', 20240515, (select user_id from user where nickname = 'LuciaM'), 3, 1),
('Guía de viajes: París', 'Los mejores lugares para visitar en París', 20240514, (select user_id from user where nickname = 'JuanP'), 4, 1),
('Decoración de interiores', 'Consejos para decorar tu sala de estar', 20240513, (select user_id from user where nickname = 'SofiaM'), 1, 4),
('El futuro de la tecnología', 'Qué esperar en los próximos 10 años', 20240512, (select user_id from user where nickname = 'CarlosL'), 5, 3),
('Postres deliciosos', 'Aprende a hacer un cheesecake perfecto', 20240511, (select user_id from user where nickname = 'LauraG'), 2, 2);

INSERT INTO alphabetdb.playlist (name, user_fk) VALUES
('Mis favoritos de aventura', (SELECT user_id FROM user WHERE nickname = 'JuanP')),
('Recetas de cocina', (SELECT user_id FROM user WHERE nickname = 'LauraG')),
('Tecnología punta', (SELECT user_id FROM user WHERE nickname = 'CarlosL')),
('Proyectos DIY', (SELECT user_id FROM user WHERE nickname = 'SofiaM')),
('Ejercicios en casa', (SELECT user_id FROM user WHERE nickname = 'DavidR'));


-- bankAccount
insert into alphabetdb.bankaccount (bankaccount_id, bank_name, account_number, country_fk, user_fk) values
(uuid(), 'Banco de Colombia', '1234567890123456', 1, (select user_id from user where nickname = 'JuanP')),
(uuid(), 'American Bank', '2345678901234567', 2, (select user_id from user where nickname = 'LauraG')),
(uuid(), 'Canadian Bank', '3456789012345678', 3, (select user_id from user where nickname = 'CarlosL')),
(uuid(), 'Banco de España', '4567890123456789', 4, (select user_id from user where nickname = 'SofiaM')),
(uuid(), 'Banco de México', '5678901234567890', 5, (select user_id from user where nickname = 'DavidR'));

-- community
insert into alphabetdb.community (name, description) values
('Cineasta', 'Comunidad para amantes del cine y aspirantes a cineastas'),
('Gamer', 'Discusiones sobre los últimos juegos y noticias del gaming'),
('Viajero del mundo', 'Consejos y relatos de viajes por todo el mundo'),
('Fitness', 'Tips y rutinas para mantenerse en forma'),
('Amantes de Tecnologia', 'Discusiones sobre las últimas innovaciones tecnológicas');

-- playlist_video_rel (relación entre playlists y videos)
insert into alphabetdb.playlist_video_rel (playlist_fk, video_fk) values
(1, 1),
(1, 7),
(2, 2),
(2, 10),
(3, 3),
(3, 9),
(4, 4),
(4, 8),
(5, 5),
(5, 11);

-- comment
insert into alphabetdb.comment (content, date_creation, user_fk, video_fk) values
('Increíble video, gracias por compartir!', 20240520, (select user_id from user where nickname = 'LuciaM'), 1),
('No estoy de acuerdo con este punto de vista.', 20240519, (select user_id from user where nickname = 'RobertoD'), 3),
('¿Puedes hacer un video sobre cómo empezar en yoga?', 20240518, (select user_id from user where nickname = 'AnaT'), 5),
('Excelente receta, la probé y quedó deliciosa.', 20240517, (select user_id from user where nickname = 'DianaG'), 2),
('Muy útil para mi proyecto de ciencias.', 20240516, (select user_id from user where nickname = 'LuisH'), 6);


-- community_user_rel (relación entre comunidades y usuarios)
insert into alphabetdb.community_user_rel (community_fk, user_fk, expiration_date) values
(1, (select user_id from user where nickname = 'JuanP'), 20251231),
(2, (select user_id from user where nickname = 'LauraG'), 20251231),
(3, (select user_id from user where nickname = 'CarlosL'), 20251231),
(4, (select user_id from user where nickname = 'SofiaM'), 20251231),
(5, (select user_id from user where nickname = 'DavidR'), 20251231);

-- suscriber_rel (relación entre suscriptores y canales)
insert into alphabetdb.suscriber_rel (user_fk, channel_fk, pay, pay_cost, date_subscription) values
((select user_id from user where nickname = 'LuciaM'), 1, true, 5.99, 20240520),
((select user_id from user where nickname = 'RobertoD'), 2, false, 0.0, 20240519),
((select user_id from user where nickname = 'AnaT'), 3, true, 4.99, 20240518),
((select user_id from user where nickname = 'DianaG'), 4, false, 0.0, 20240517),
((select user_id from user where nickname = 'LuisH'), 5, true, 3.99, 20240516);

-- video por pais
select v.video_id, v.name, v.description, u.name as user_name, u.email
from alphabetdb.video as v
join alphabetdb.user as u on v.user_fk = u.user_id
join alphabetdb.country as c on u.country_fk = c.country_id
where c.name = 'Colombia';

-- generos
select g.name as genre_name, count(v.video_id) as video_count
from alphabetdb.genre as g
left join alphabetdb.video as v on g.genre_id = v.genre_fk
group by g.name;


-- info de videos populares
select v.name as video_name, v.description, v.likes, u.name as user_name, u.email
from alphabetdb.video as v
join alphabetdb.user as u on v.user_fk = u.user_id
where v.likes > 20;

-- canales y subs por país
select ch.channel_id, ch.description
from alphabetdb.channel as ch
join alphabetdb.suscriber_rel as sr on ch.channel_id = sr.channel_fk
join alphabetdb.user as u on sr.user_fk = u.user_id
join alphabetdb.country as c on u.country_fk = c.country_id
where c.name = 'España'
group by ch.channel_id;

-- comentarios negativos
select cm.content, cm.likes, cm.dislikes, u.name as user_name, u.email, v.name as video_name
from alphabetdb.comment as cm
join alphabetdb.user as u on cm.user_fk = u.user_id
join alphabetdb.video as v on cm.video_fk = v.video_id
where lower(cm.content) like '%ugly%';

-- usuarios ordenados por email
select u.user_id, u.name, u.email, u.phone, u.nickname, u.password_, c.name as country_name
from alphabetdb.user as u
join alphabetdb.country as c on u.country_fk = c.country_id
order by u.email
limit 3;

