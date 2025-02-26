use music_schema;

#List all the rows in customer table
select * from customer;

#List all the customer first name start with "A"
select * from customer where first_name like "A%";

##List all the customer Last name Ends with "N"
select * from customer where last_name like "%N";

#######List customer name who bought Genre ="Jazz" with track_id 

                  ######connected Genre, track,invoiceline,invoice and customer tables 
with new_table1 as(select t.track_id,g.genre_id,genre_name from track t left join genre g on t.genre_id=g.genre_id where genre_name ='Jazz'),

new_table2 as (select b.*,c.invoice_id,c.customer_id from 
(select a.*,i.invoice_id as invline_invoice_id from new_table1 a join invoice_line i on a.track_id =i.track_id) as b 
left join invoice c on b.invline_invoice_id=c.invoice_id),

new_table3 as (select distinct c.first_name,c.last_name,n.customer_id,n.genre_id,n.genre_name
from new_table2 n join customer c on c.customer_id = n.customer_id)

select * from new_table3 ;


######################################################
###List Top 10 Customers who spent more money on music

 select c.first_name,c.last_name,i.customer_id,sum(i.total) total_money_spent from invoice i 
 join customer c on c.customer_id =i.customer_id group by i.customer_id order by (total_money_spent) desc limit 10;
 
 
#####################################################
#Find Artist name and their total Albums
select b.artist_id,a.artist_name,count(b.album_id) n_albums from artist a join album b on a.artist_id = b.artist_id group by 1 order by n_albums desc;


####################################################
####Find the most popular genre (based on track count)
select g.*,count(t.track_id) as n_tracks from genre g left join track t on g.genre_id= t.genre_id group by 1 order by 3 desc;

##########################################################
#########Find the track counts by media type
select m.*,count(t.track_id) as n_tracks from media_type m join track t on m.media_type_id=t.media_type_id group by 1;

##########################################
##########Find the number of customers per country
select country,count(customer_id) n_customer from customer group by 1 order by 2 desc;

#####################################################
######### Total Sales on month and year wise #########
select concat(month(invoice_date),"-",year(invoice_date)) as month_year,sum(total) as total_sales from invoice group by 1;
 
########################################################
########## selling genres from country France 
select distinct c.country, g.genre_name from 
customer c join invoice i on c.customer_id=i.customer_id
join invoice_line ivl on i.invoice_id =ivl.invoice_line_id
join track t on ivl.track_id = t.track_id
join genre g on t.genre_id = g.genre_id where c.country="France";









