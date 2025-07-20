# This project is about some queries from 'netflixdb' database 
**We have diferents tables in this database, exactly, four tables**
## The table of 'Actores'
```sql
SELECT * FROM actores
LIMIT 10;
```
<img width="304" height="189" alt="image" src="https://github.com/user-attachments/assets/41c458c7-5aef-4bb4-a2de-dbdab7a2811e" />


## The table of 'Actuaciones'
```sql
SELECT * FROM actuaciones
LIMIT 10;
```
<img width="235" height="171" alt="image" src="https://github.com/user-attachments/assets/eeb6beec-def4-4e9f-afc6-e5754d74f97a" />

## The table of 'Episodios'
```sql
SELECT * FROM episodios
LIMIT 10;
````
<img width="791" height="185" alt="image" src="https://github.com/user-attachments/assets/cde38095-4cd6-4b5a-b446-012942b71f4a" />

## The table of 'Series'
```sql
SELECT * FROM series
LIMIT 10;
```
<img width="620" height="188" alt="image" src="https://github.com/user-attachments/assets/eb8eb8b4-e6fe-46a6-816e-9fe72a1a1ad8" />


**After already showed the tables of database, I would like show the queries I did to my exploratory analysis**

### ANALYSIS
**--This queries is made from the 'netflixdb' database from which all the information from its corresponding tables was extracted,it helped us answer the following questions**

**1.- Who is the actor or actress who has participated in the most series?**

**2.-What is the series with the highest imdb rating?**

**3.- What is the longest episode?**

**4.- What genres are most prevalent in the NetflixDB database?**

**5.- What are the three highest-rated series on IMDb and how many episodes do they have?**

**6.- What is the total length of all the episodes for the series "Stranger Things"?**

**7.- What is the most popular gender in Netflix series?/What are the most popular series?

**FIRST QUESTION -> We got the actor who has participated in the most series: Gina Carano**

```sql
SELECT actor_id, COUNT(serie_id)
FROM actuaciones
GROUP BY 1
ORDER BY COUNT(serie_id) DESC
LIMIT 3;
```
<img width="176" height="73" alt="image" src="https://github.com/user-attachments/assets/8846bde2-ce12-49e6-a2d2-0d82a8a4a62d" />

```sql
SELECT nombre
FROM actores
WHERE actor_id = 18;
```
<img width="103" height="39" alt="image" src="https://github.com/user-attachments/assets/14e5cb9d-fa38-43c3-943a-3bd955d714b2" />

**SECOND QUESTION -> We got the series with the highest rating: Arcane**

```sql
SELECT serie_id, AVG(rating_imdb)
FROM episodios
GROUP BY serie_id
ORDER BY AVG(rating_imdb) DESC;
```
<img width="178" height="243" alt="image" src="https://github.com/user-attachments/assets/efeede41-9e77-40bb-8cd6-851008ee6cba" />

```sql
SELECT titulo FROM series WHERE serie_id=8;
```
<img width="80" height="40" alt="image" src="https://github.com/user-attachments/assets/f2da2424-5cbf-4f5a-859d-cd7bc537f700" />

**THIRD QUESTION -> We got the longest running episode: The Sing of Three**

```sql
SELECT episodio_id,serie_id, MAX(duracion) AS mayor_duracion
FROM episodios 
GROUP BY 1
ORDER BY mayor_duracion DESC
LIMIT 3;
```
<img width="241" height="71" alt="image" src="https://github.com/user-attachments/assets/9531569d-f296-44bc-9df0-ddcc7e44a140" />

```sql
SELECT titulo FROM episodios WHERE episodio_id=119;
```
<img width="126" height="38" alt="image" src="https://github.com/user-attachments/assets/6866354a-4001-4d47-ae48-45b0151ec613" />

**FOURTH QUESTION -> This SQL query allows us to see how many series there are in each genre within the NetflixDB database by grouping series by genre and counting them, we can identify which genres are most prevalent**

```sql
SELECT genero, COUNT(serie_id) AS 'Cantidad de series'
FROM series
GROUP BY 1
ORDER BY COUNT(serie_id) DESC;
```
<img width="216" height="149" alt="image" src="https://github.com/user-attachments/assets/6ad20879-318f-4d87-9044-615b9d79504c" />

**FIFTH QUESTION -> With this query, We identified the three series with the highest IMDB rating in the database and we count how many episodes each of them has, combining information from the Series and Episodes tables**

```sql
SELECT series.titulo AS 'Titulo de la Serie', 
COUNT(episodios.episodio_id) AS 'Numero de episodios',
AVG(episodios.rating_imdb) AS avg_imdb
FROM series 
LEFT JOIN episodios 
ON series.serie_id = episodios.serie_id
GROUP BY series.TITULO
ORDER BY avg_imdb DESC
LIMIT 3;
```
<img width="304" height="89" alt="image" src="https://github.com/user-attachments/assets/53b18449-aa19-49da-bbcc-e8eec284136f" />

**SIXTH QUESTION -> This analysis will help you understand the time commitment required to watch a full series**

```sql
SELECT series.titulo AS 'Titulo de Serie',
SUM(episodios.duracion) AS 'Duracion Total de los episodios'
FROM series 
LEFT JOIN episodios
ON series.serie_id=episodios.serie_id   
WHERE series.titulo= 'Stranger Things'
GROUP BY 1;
```
<img width="278" height="48" alt="image" src="https://github.com/user-attachments/assets/2a2ed0ad-a8c6-4a52-8224-d5c5723568a4" />

**SEVENTH QUESTION -> We need to identify the most popular genres in Netflix series, show the most popular series**
```sql
SELECT 
	series.titulo AS 'Titulo de la Serie',
    series.año_lanzamiento AS 'Año de lanzamiento',
    series.genero AS 'Genero',
    AVG(episodios.rating_imdb) AS rating_promedio
FROM series
JOIN episodios 
ON series.serie_id = episodios.serie_id
WHERE 
	series.genero IN (SELECT genero FROM(
						SELECT genero, COUNT(*) AS cantidad_de_series
                        FROM series
                        GROUP BY 1
                        ORDER BY cantidad_de_series DESC 
                        LIMIT 3) AS top3)
GROUP BY series.serie_id
ORDER BY rating_promedio DESC;
```
<img width="418" height="153" alt="image" src="https://github.com/user-attachments/assets/01eb24a2-6c91-4655-b077-8422c7f1d448" />

This is the end of my analysis about 'netflixdb' database.











