###Tenemos que identificar los generos mas populares en la series de Netflixdb
###Mostrar las series mas populares 
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

