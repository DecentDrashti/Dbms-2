CREATE DATABASE CSE_4B_377

SELECT * FROM ALBUMS
SELECT * FROM ARTISTS
SELECT * FROM SONGS

--PART--A
--1.RETRIEVE A UNIQUE GENRE OF SONGS.
	SELECT DISTINCT GENRE FROM SONGS

--2.FIND TOP 2 ALBUMS RELEASED BEFORE 2010.
	SELECT TOP 2 * FROM ALBUMS
	WHERE RELEASE_YEAR < 2010

--3.Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005)
	INSERT INTO SONGS VALUES(1245,'ZAROOR',2.55,'FEEL GOOD',1005)

--4.Change the Genre of the song ‘Zaroor’ to ‘Happy’
	UPDATE SONGS
	SET SONG_TITLE = 'HAPPY'
	WHERE SONG_TITLE = 'ZAROOR'

--5.Delete an Artist ‘Ed Sheeran’
	DELETE FROM ARTIST
	WHERE ARTIST_NAME = 'ED SHEERAN'

--6.Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
	ALTER TABLE SONGS
	ADD RATING DECIMAL(3,2)

--7.Retrieve songs whose title starts with 'S'.
	SELECT SONG_TITLE FROM SONGS
	WHERE SONG_TITLE LIKE 'S%'

--8.Retrieve all songs whose title contains 'Everybody'.
	SELECT SONG_TITLE FROM SONGS
	WHERE SONG_TITLE LIKE '%EVERYBODY%'

--9.Display Artist Name in Uppercase.
	SELECT UPPER(ARTIST_NAME) FROM ARTISTS

--10.Find the Square Root of the Duration of a Song ‘Good Luck’
	SELECT SQRT(DURATION) FROM SONGS
	WHERE SONG_TITLE = 'GOOD LUCK'

--11.Find Current Date
	SELECT GETDATE()

--12.Find the number of albums for each artist.
	SELECT DURATION FROM SONGS 
	WHERE DURATION >100

--13.Retrieve the Album_id which has more than 5 songs in it.
     select Album_id from songs 
	 group by album_id 
	 having count(song_title)>5 

--14.Retrieve all songs from the album 'Album1'. (using Subquery)
     SELECT * FROM songs 
    WHERE Album_id = 
	(SELECT Album_id FROM albums 
	WHERE Album_title = 'Album1');

--15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)
      select album_title from Albums
	  where artist_id=
	  (select artist_id from artists 
	  where artist_name='Aparshakti Khurana')

--16. Retrieve all the song titles with its album title.
      select song_title ,album_title from songs 
	  join albums on songs.album_id=albums.album_id 
	
--17. Find all the songs which are released in 2020.
     select song_title from songs 
	 join albums on songs.album_id=albums.album_id 
	 where release_year=2020

--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
     CREATE VIEW Fav_songs 
	 AS 
	 SELECT song_title, song_id
	 FROM songs 
	 WHERE song_id BETWEEN 101 AND 105;
	 select *from fav_songs

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
     update Fav_songs
	 set song_title='Jannat' where song_id=101

--20. Find all artists who have released an album in 2020.
      select  artist_name from artists join albums
	  on artists.Artist_id=albums.Artist_id
	  where Release_year=2020

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.
      select song_title from songs join Albums
	  on albums.Album_id=songs.album_id
	  join Artists on albums.artist_id=artists.Artist_id
	  where Artist_name='shreya ghoshal'
	  order by duration

--PART--B
--22. Retrieve all song titles by artists who have more than one album. 
      select song_title , Artist_name from songs 
	  join Albums on songs.Album_id=Albums.Album_id
	  join Artists on Albums.Artist_id=Artists.Artist_id
      where Artists.Artist_id IN (select Artist_id from albums  
	  group by artist_id 
	  having count(album_id)>1)

--23. Retrieve all albums along with the total number of songs.
      select album_title,count(song_title) as total_songs from albums 
	  join songs 
	  on albums.album_id=songs.album_id
	  group by album_title

--24. Retrieve all songs and release year and sort them by release year. 
     select song_title,release_year from songs 
	 join Albums
	 on Albums.Album_id=songs.Album_id
	 order by Release_year desc

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs.
    select count(song_id)as total_song,genre from songs 
	group by genre
	having count(genre)>2

--26. List all artists who have albums that contain more than 3 songs.
    select artist_name from Artists join Albums 
	on artists.Artist_id=albums.Artist_id
	join songs on albums.Album_id=songs.Album_id
	group by Artist_name
	having count(songs.Album_id)>3

--	Part – C
--27. Retrieve albums that have been released in the same year as 'Album4'
      select album_title from albums
	  where Release_year=
	  (select Release_year from albums 
	  where album_title='album4') and album_title <> 'album4'

--28. Find the longest song in each genre
		SELECT genre, song_title, duration
		FROM songs s
		WHERE duration = (
			SELECT MAX(duration)
			FROM songs
			WHERE genre = s.genre
		);	

  --slect song_title from songs
	  --where duration in
	  --(select max(duration),genre from songs
	  --group by genre )

--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title.
		select song_title from songs 
		where song_title like '%album%'

--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes
		select artist_name,sum(duration)
		from artists join albums
		on artists.Artist_id=albums.Artist_id
		join songs on albums.Album_id=songs.Album_id
		group by Artist_name
		having sum(duration)>15