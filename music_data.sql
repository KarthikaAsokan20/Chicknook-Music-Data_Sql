create database music_schema;
use music_schema;

create table album(album_id int Primary Key,  title varchar(255), artist_id int );

Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/album.csv'
into table album 
fields terminated by',' 
enclosed by '"' 
lines terminated by '\n'
ignore 1 rows;

##########################    ARTIST TABLE    #############################################
#drop table artist;
create table artist (artist_id bigint Primary key, artist_name nvarchar(130));

SET GLOBAL local_infile = 1;

Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/artist.csv'
into table artist
fields terminated by ',' 
enclosed by '"' 
lines terminated by '\n'
ignore 1 rows;

################################ CUSTOMER TABLE########################

create table customer (customer_id int Primary key, first_name varchar(100), last_name varchar(100),company varchar(255),
    address varchar(255),city varchar(500),state varchar(20),country varchar(20),postal_code varchar(20),phone varchar(20),fax varchar(20),email varchar(40),support_rep_id int);

#alter table customer change Country country varchar(20);    
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/customer.csv'	
into table customer
fields terminated by ',' 
enclosed by '"' 
lines terminated by '\n'
ignore 1 rows;

##################################   EMPLOYEE TABLE #######################
create table employee (employee_id int Primary key, last_name varchar(50), first_name varchar(50),title varchar(100),
    reports_to int NULL,birthdate datetime,hire_date datetime,address varchar(50),city varchar(30),state char(20), 
    country varchar(20), postal_code varchar(20),phone varchar(20),fax varchar(20),email varchar(40));

#SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION'; for converting empty cell into NULL #create a table with a non-existent or unsupported storage engine, for support
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/employee.csv'	
into table employee fields terminated by ',' enclosed by '"' 
lines terminated by '\n' ignore 1 rows
SET reports_to = nullif(reports_to, '');

###########################  GENRE	table ############################
create table genre (genre_id int Primary key, genre_name varchar(30));

Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/genre.csv'
into table genre fields terminated by ','  enclosed by '"' 
lines terminated by '\n' ignore 1 rows;

#####################INVOICe	table    #####################
create table invoice(invoice_id int Primary Key, customer_id int,invoice_date datetime,billing_address varchar(70) ,
 billing_city varchar(30),billing_state varchar(30),billing_country varchar(30),billing_postal_code varchar(50),
   total decimal(10,2),
   Foreign key(customer_id) references customer(customer_id));
   
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/invoice.csv'
into table invoice fields terminated by ',' enclosed by '"'
lines terminated by '\n' ignore 1 rows;


#####################	MEDIA_TYPE	table  #####################
create table media_type(media_type_id int Primary key,media_name varchar(100));

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/media_type.csv'
into table media_type fields terminated by ',' enclosed by '"'
lines terminated by '\n' ignore 1 rows;

#####################	PLAYLIST	table   #####################
create table playlist (playlist_id int Primary key, playlist_name varchar(100));

Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/playlist.csv'
into table playlist fields terminated by ','  enclosed by '"' 
lines terminated by '\n' ignore 1 rows;

#####################	TRACK	table  #####################
create table track(track_id int Primary Key, track_name varchar(500), album_id int, media_type_id int, genre_id int,composer varchar(300),
       milliseconds bigint, bytes bigint, unit_price float,
       Foreign key(album_id) references album(album_id),
       Foreign key(genre_id) references genre(genre_id),
       Foreign key(media_type_id) references media_type(media_type_id));
 
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/track.csv'
into table track fields terminated by ','  enclosed by '"' 
lines terminated by '\n' ignore 1 rows;

####################	PLAYLIST_TRACK	table  #####################
#drop table playlist_track;
create table playlist_track (playlist_id int, track_id int , 
Foreign key(playlist_id) references playlist(playlist_id),
Foreign key(track_id) references track(track_id));

Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/playlist_track.csv'
into table playlist_track fields terminated by ','  enclosed by '"' 
lines terminated by '\n' ignore 1 rows;

##################### INVOICE_LINE	table  #####################
create table invoice_line( invoice_line_id int Primary key,invoice_id int,track_id int,unit_price decimal(10,2),quantity int,
Foreign key(invoice_id) references invoice(invoice_id),
Foreign key(track_id) references track(track_id),
Foreign key(track_id) references playlist_track(track_id));

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chinook-music-store-data/invoice_line.csv'
into table invoice_line fields terminated by ',' enclosed by '"'
lines terminated by '\n' ignore 1 rows;









