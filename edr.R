movies = read.csv('../data/movie_metadata.csv')

movies = movies[movies$country == 'USA',]
movies = movies[!is.na(movies$gross),]
movies = movies[!is.na(movies$budget),]
movies = movies[!is.na(movies$movie_title),]
movies = movies[!duplicated(movies),]

movies$movie_title = gsub(' $', '', movies$movie_title)
movies = movies[movies$movie_title != 'Hardflip',]

# some things are factors, turn them into characters for analysis
movies$director = as.character(movies$director_name)
movies$genre = as.character(movies$genres)

# setup some indicators
movies$type = 'Other' # Documentary, Adventure, Fantasy, Sport
movies[grep('Family', x=movies$genre), 'type'] = 'Family'
movies[grep('Horror', x=movies$genre), 'type'] = 'Horror'
movies[grep('Comedy', x=movies$genre), 'type'] = 'Comedy'
movies[grep('Drama', x=movies$genre), 'type'] = 'Drama'
movies[grep('Action', x=movies$genre), 'type'] = 'Action'
movies[grep('Thriller', x=movies$genre), 'type'] = 'Thriller'
movies[grep('Music', x=movies$genre), 'type'] = 'Music'
movies[grep('Sci-Fi', x=movies$genre), 'type'] = 'Sci-Fi'
#tabmovies[grep('Documentary', x=movies$genre), 'type'] = 'Documentary'

movies$type = as.factor(movies$type)

movies$nudity = FALSE
movies[grep('nudity', x=movies$plot_keywords, ignore.case = TRUE), 'nudity'] = TRUE
movies[grep('breast', x=movies$plot_keywords, ignore.case = TRUE), 'nudity'] = TRUE

get.string.length.of.column.data = function(vector) {
  vector.with.data = vector[!is.na(vector)]
  max(nchar(as.character(vector.with.data)))
}

# get max characters from cells
# sapply(movies, get.string.length.of.column.data)
# plot(movies$budget, movies$gross)

highest.gross = movies[order(movies$gross, decreasing = TRUE),][1:20,]
highest.budget = movies[order(movies$budget, decreasing = TRUE),][1:20,]


after.2010 = movies[movies$title_year >=2010,]

plot(after.2010$budget, after.2010$gross, col=after.2010$type)
legend('topleft',unique(as.character(after.2010$type)),col=1:length(after.2010$type),pch=1)

highest.gross.after.2010 = after.2010[order(after.2010$gross, decreasing = TRUE),][1:20,]
highest.budget.after.2010 = after.2010[order(after.2010$budget, decreasing = TRUE),][1:20,]
highest.cast_total_facebook_likes.after.2010 = after.2010[order(after.2010$cast_total_facebook_likes, decreasing = TRUE),][1:20,]
#lowest.gross.after.2010 = after.2010[after.2010$gross < 11860000,]
#with(after.2010[after.2010$type=='Sci-Fi',], plot(budget, gross))

with.nudity = after.2010[after.2010$nudity,]
#pairs(~budget+gross+imdb_score+num_critic_for_reviews+num_user_for_reviews+facenumber_in_poster, data=after.2010)

# with(after.2010, plot(cast_total_facebook_likes, gross))

#with(after.2010, summary(ols = lm(gross ~ duration, facenumber_in_poster, director_facebook_likes, actor_3_facebook_likes, actor_1_facebook_likes, cast_total_facebook_likes, budget, actor_2_facebook_likes)))

