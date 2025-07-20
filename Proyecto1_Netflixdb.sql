###Esta es una query que esta hecha a partir de la base de datos 'netflixdb' de la cual se extrayo toda la informacion 
###de sus tablas correspondientes, nos sirvio para contestar las siguientes preguntas 
###¿Quién es el actor o actriz que ha participado en la mayor cantidad de series?
###¿Cuál es la serie con rating de imdb mas alto?
###¿Cuál es el episodio mas largo?

SELECT * FROM actores;
SELECT * FROM actuaciones;
SELECT * FROM episodios;
SELECT * FROM series;

###Obtuvimos el actor que en mas series ha participado: Gina Carano
SELECT actor_id, COUNT(serie_id) FROM actuaciones GROUP BY 1 ORDER BY COUNT(serie_id) DESC; 
SELECT nombre FROM actores WHERE actor_id= 18;

#Obtuvimos la serie con el raiting mas alto: Arcane 
SELECT serie_id, AVG(rating_imdb) FROM episodios GROUP BY serie_id ORDER BY AVG(rating_imdb) DESC;
SELECT titulo FROM series WHERE serie_id=8;

#Obtuvimos el episodio con duracion mas larga: The Sing of Three
SELECT episodio_id,serie_id, MAX(duracion) FROM episodios GROUP BY 1 ORDER BY MAX(duracion) DESC;
SELECT titulo FROM series WHERE serie_id=10;
SELECT titulo FROM episodios WHERE episodio_id=119;

SELECT * FROM episodios ORDER BY duracion DESC;