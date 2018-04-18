movies = read.csv('./data/movie_metadata.csv')

pairs(~budget+imdb_score+gross+movie_facebook_likes, data = movies)

most.liked.films = movies[order(movies$movie_facebook_likes),]