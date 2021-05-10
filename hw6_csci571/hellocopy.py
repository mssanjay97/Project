from flask import Flask
import requests
import json

app = Flask(__name__)


@app.route('/')
def root():
    return app.send_static_file('index.html')


@app.route('/trendmovie')
def trendmovie():
    trendmovie=requests.get('https://api.themoviedb.org/3/trending/movie/week?api_key=3b28ffe100d9e19f677ab8170e8b76a4')
    trendmovie=json.loads(trendmovie.text)
    top5=trendmovie["results"][0:5]
    ret=[]
    for movie in top5:
        temp={}
        temp["title"]=str(movie['title']) if 'title' in movie else ""
        temp["backdrop_path"]="https://image.tmdb.org/t/p"+"/w780"+str(movie['backdrop_path']) if 'backdrop_path' in movie and str(movie['backdrop_path'])!='None' else "https://bytes.usc.edu/cs571/s21_JSwasm00/hw/HW6/imgs/movie-placeholder.jpg"
        temp["release_date"]=str(movie['release_date'])[0:4] if 'release_date' in movie else ""
        ret.append(temp)
    return json.dumps({"res":ret})
    

@app.route('/trendshow')
def trendshow():
    trendmovie=requests.get('https://api.themoviedb.org/3/tv/airing_today?api_key=3b28ffe100d9e19f677ab8170e8b76a4')
    trendmovie=json.loads(trendmovie.text)
    top5=trendmovie["results"][0:5]
    ret=[]
    for movie in top5:
        temp={}
        temp["name"]=str(movie['name']) if 'name' in movie else ""
        temp["backdrop_path"]="https://image.tmdb.org/t/p"+"/w780"+str(movie['backdrop_path']) if 'backdrop_path' in movie and str(movie['backdrop_path'])!='None' else "https://bytes.usc.edu/cs571/s21_JSwasm00/hw/HW6/imgs/movie-placeholder.jpg"
        temp["first_air_date"]=str(movie['first_air_date'])[0:4] if 'first_air_date' in movie else ""
        ret.append(temp)
    return json.dumps({"res":ret})


def getgenre(l,genres):
        
    ret=[]
    for g in l:
        for it in genres:
            if(g==it['id']):
                ret.append(it['name'])
                break;
    return (', ').join(ret)


    
@app.route("/searchmovie/<name>")
def searchmovie(name):
    genres=requests.get("https://api.themoviedb.org/3/genre/movie/list?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=en-US");
    genres=json.loads(genres.text)
    genres=genres['genres']


        
    name=("%20").join(name.split(' '))
    searchmovie=requests.get("https://api.themoviedb.org/3/search/movie?api_key=3b28ffe100d9e19f677ab8170e8b76a4&query="+ str(name)+"&language=en-US&page=1&include_adult=false")
    searchmovie=json.loads(searchmovie.text)
    searchmovie=searchmovie["results"]
    ret=[]
    for movie in searchmovie:
        temp={}
        temp["id"]=str(movie['id']) if 'id' in movie else ""
        temp["title"]=str(movie['title']) if 'title' in movie else ""
        temp["overview"]=str(movie['overview']) if 'overview' in movie else ""
        temp["poster_path"]="https://image.tmdb.org/t/p"+"/w185"+str(movie['poster_path']) if 'poster_path' in movie  and str(movie['poster_path'])!='None' else "https://cinemaone.net/images/movie_placeholder.png"
        temp["release_date"]=str(movie['release_date'])[0:4] if 'release_date' in movie else ""
        temp["vote_average"]=str(round(float(movie['vote_average'])/2,2)) if 'vote_average' in movie else "0"
        temp["vote_count"]=str(movie['vote_count']) if 'vote_count' in movie else "0"
        temp["genre_ids"]=str(getgenre(movie['genre_ids'],genres)) if 'genre_ids' in movie else "[]"
        ret.append(temp)
    return json.dumps({"res":ret})



@app.route("/searchtv/<name>")
def searchtv(name):
    genres=requests.get("https://api.themoviedb.org/3/genre/tv/list?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=en-US");
    genres=json.loads(genres.text)
    genres=genres['genres']


        
    name=("%20").join(name.split(' '))



    searchmovie=requests.get("https://api.themoviedb.org/3/search/tv?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=en-US&page=1&query="+str(name)+"&include_adult=false")
    searchmovie=json.loads(searchmovie.text)
    searchmovie=searchmovie["results"]
    ret=[]
    for movie in searchmovie:
        temp={}
        temp["id"]=str(movie['id']) if 'id' in movie else ""
        temp["name"]=str(movie['name']) if 'name' in movie else ""
        temp["overview"]=str(movie['overview']) if 'overview' in movie else ""
        temp["poster_path"]="https://image.tmdb.org/t/p"+"/w185"+str(movie['poster_path']) if 'poster_path' in movie  and str(movie['poster_path'])!='None' else "https://cinemaone.net/images/movie_placeholder.png"
        temp["first_air_date"]=str(movie['first_air_date'])[0:4] if 'first_air_date' in movie else ""
        temp["vote_average"]=str(round(float(movie['vote_average'])/2,2)) if 'vote_average' in movie else "0"
        temp["vote_count"]=str(movie['vote_count']) if 'vote_count' in movie else "0"
        temp["genre_ids"]=str(getgenre(movie['genre_ids'],genres)) if 'genre_ids' in movie else "[]"
        ret.append(temp)
    return json.dumps({"res":ret})



@app.route("/searchmulti/<name>")
def searchmulti(name):

    genresmovie=requests.get("https://api.themoviedb.org/3/genre/movie/list?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=en-US");
    genresmovie=json.loads(genresmovie.text)
    genresmovie=genresmovie['genres']




    genrestv=requests.get("https://api.themoviedb.org/3/genre/tv/list?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=en-US");
    genrestv=json.loads(genrestv.text)
    genrestv=genrestv['genres']


        
    name=("%20").join(name.split(' '))



    searchmulti=requests.get("https://api.themoviedb.org/3/search/multi?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=enUS&query="+str(name)+"&page=1&include_adult=false")
    searchmulti=json.loads(searchmulti.text)
    searchmulti=searchmulti["results"]
    ret=[]
    for movie in searchmulti:
        temp={}
        if(movie['media_type']=='movie'):
            temp["id"]=str(movie['id']) if 'id' in movie else ""
            temp["title"]=str(movie['title']) if 'title' in movie else ""
            temp["overview"]=str(movie['overview']) if 'overview' in movie else ""
            temp["poster_path"]="https://image.tmdb.org/t/p"+"/w185"+str(movie['poster_path']) if 'poster_path' in movie  and str(movie['poster_path'])!='None' else "https://cinemaone.net/images/movie_placeholder.png"
            temp["release_date"]=str(movie['release_date'])[0:4] if 'release_date' in movie else ""
            temp["vote_average"]=str(round(float(movie['vote_average'])/2,2)) if 'vote_average' in movie else "0"
            temp["vote_count"]=str(movie['vote_count']) if 'vote_count' in movie else "0"
            temp["genre_ids"]=str(getgenre(movie['genre_ids'],genresmovie)) if 'genre_ids' in movie else "[]"
            
        elif(movie['media_type']=='tv'):
            temp["id"]=str(movie['id']) if 'id' in movie else ""
            temp["name"]=str(movie['name']) if 'name' in movie else ""
            temp["overview"]=str(movie['overview']) if 'overview' in movie else ""
            temp["poster_path"]="https://image.tmdb.org/t/p"+"/w185"+str(movie['poster_path']) if 'poster_path' in movie  and str(movie['poster_path'])!='None' else "https://cinemaone.net/images/movie_placeholder.png"
            temp["first_air_date"]=str(movie['first_air_date'])[0:4] if 'first_air_date' in movie else ""
            temp["vote_average"]=str(round(float(movie['vote_average'])/2,2)) if 'vote_average' in movie else "0"
            temp["vote_count"]=str(movie['vote_count']) if 'vote_count' in movie else "0"
            temp["genre_ids"]=str(getgenre(movie['genre_ids'],genrestv)) if 'genre_ids' in movie else "[]"
        temp["media_type"]=str(movie['media_type'])
        ret.append(temp)
    return json.dumps({"res":ret})



@app.route("/moremovie/<int:id>")
def moremovie(id):

    searchmovie=requests.get("https://api.themoviedb.org/3/movie/"+str(id)+"?api_key=97588ddc4a26e3091152aa0c9a40de22&language=en-US");
    movie=json.loads(searchmovie.text)


    searchcast=requests.get("https://api.themoviedb.org/3/movie/"+str(id)+"/credits?api_key=97588ddc4a26e3091152aa0c9a40de22&language=en-US"); 
    searchcast=json.loads(searchcast.text)
    cast=searchcast['cast'][:8]

    

    searchreview=requests.get("https://api.themoviedb.org/3/movie/"+str(id)+"/reviews?api_key=97588ddc4a26e3091152aa0c9a40de22&language=enUS&page=1");
    review=json.loads(searchreview.text)
    review=review["results"]

    
    ret=[]
  
    temp={}
    temp["id"]=str(movie['id']) if 'id' in movie else ""
    temp["title"]=str(movie['title']) if 'title' in movie else ""
    temp["runtime"]=str(movie['runtime']) if 'runtime' in movie else ""
        
    spoken_txt=""
       
    for lang in movie['spoken_languages']:
        spoken_txt+=lang['name']+", "
    spoken_txt=spoken_txt[:-1]
    temp["spoken_languages"]=spoken_txt if 'spoken_languages' in movie else ""
     
    temp["overview"]=str(movie['overview']) if 'overview' in movie else ""
    temp["poster_path"]="https://image.tmdb.org/t/p"+"/w185"+str(movie['poster_path']) if 'poster_path' in movie  and str(movie['poster_path'])!='None' else "https://cinemaone.net/images/movie_placeholder.png"
    temp["release_date"]=str(movie['release_date'])[0:4] if 'release_date' in movie else ""
    temp["vote_average"]=str(round(float(movie['vote_average'])/2,2)) if 'vote_average' in movie else "0"
    temp["vote_count"]=str(movie['vote_count']) if 'vote_count' in movie else "0"

    temp["backdrop_path"]="https://image.tmdb.org/t/p"+"/w780"+str(movie['backdrop_path']) if 'backdrop_path' in movie and str(movie['backdrop_path'])!='None' else "https://bytes.usc.edu/cs571/s21_JSwasm00/hw/HW6/imgs/movie-placeholder.jpg"

    genres_txt=""
        
    for g in movie['genres']:
        genres_txt+=g['name']+", "
    genres_txt=genres_txt[:-1]
    temp["genres"]=genres_txt if 'genres' in movie else "[]"

    temp["cast"]=[]
    for actor in cast:
        t={}
        t["name"]=actor["name"] if 'name' in actor else ""
        t["character"]=actor["character"] if 'character' in actor else ""
        t["profile_path"]= "https://image.tmdb.org/t/p"+"/w185"+str(actor['profile_path']) if 'profile_path' in actor and str(actor['profile_path'])!='None' else "https://bytes.usc.edu/cs571/s21_JSwasm00/hw/HW6/imgs/person-placeholder.png"
        temp["cast"].append(t)
        

    temp["reviews"]=[]
    rcount=0
    for r in review:
        if(rcount==5):
            break
        """if(str(r['author_details']['rating'])=='None'):
            continue"""
        rcount+=1
        t={}
        t["username"]=r["author_details"]['username'] if 'username' in r["author_details"] else ""
        t["content"]=r["content"] if 'content' in r else ""
        t["rating"]=str(round(float(r['author_details']['rating'])/2,2)) if 'rating' in r["author_details"] and str(r['author_details']['rating'])!='None' else ""
        t["created_at"]=r["created_at"][5:7]+"/"+r["created_at"][8:10]+"/"+r["created_at"][0:4] if 'created_at' in r else ""
        temp["reviews"].append(t)
        
        
    

    ret.append(temp)
    return json.dumps({"res":ret})




@app.route("/moretv/<int:id>")
def moretv(id):
    searchmovie=requests.get("https://api.themoviedb.org/3/tv/"+str(id)+"?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=enUS");    
    movie=json.loads(searchmovie.text)

    searchcast=requests.get("https://api.themoviedb.org/3/tv/"+str(id)+"/credits?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=en-US"); 
    searchcast=json.loads(searchcast.text)
    cast=searchcast['cast'][:8]

    searchreview=requests.get("https://api.themoviedb.org/3/tv/"+str(id)+"/reviews?api_key=3b28ffe100d9e19f677ab8170e8b76a4&language=enUS&page=1");
    review=json.loads(searchreview.text)
    review=review["results"]

    
    ret=[]
  
    temp={}
    temp["id"]=str(movie['id']) if 'id' in movie else ""
    temp["name"]=str(movie['name']) if 'name' in movie else ""
    temp["episode_run_time"]=str(movie['episode_run_time'][0]) if 'episode_run_time' in movie else ""
        
    spoken_txt=""
    
    for lang in movie['spoken_languages']:
        spoken_txt+=lang['name']+", "
    spoken_txt=spoken_txt[:-1]
    temp["spoken_languages"]=spoken_txt if 'spoken_languages' in movie else ""
    temp["number_of_seasons"]=str(movie["number_of_seasons"]) if 'number_of_seasons' in movie else ""
    temp["overview"]=str(movie['overview']) if 'overview' in movie else ""
    temp["poster_path"]="https://image.tmdb.org/t/p"+"/w185"+str(movie['poster_path']) if 'poster_path' in movie  and str(movie['poster_path'])!='None' else "https://cinemaone.net/images/movie_placeholder.png"
    temp["first_air_date"]=str(movie['release_date'])[0:4] if 'release_date' in movie else ""
    temp["vote_average"]=str(round(float(movie['vote_average'])/2,2)) if 'vote_average' in movie else "0"
    temp["vote_count"]=str(movie['vote_count']) if 'vote_count' in movie else "0"

    temp["backdrop_path"]="https://image.tmdb.org/t/p"+"/w780"+str(movie['backdrop_path']) if 'backdrop_path' in movie and str(movie['backdrop_path'])!='None' else "https://bytes.usc.edu/cs571/s21_JSwasm00/hw/HW6/imgs/movie-placeholder.jpg"

    genres_txt=""
        
    for g in movie['genres']:
        genres_txt+=g['name']+", "
    genres_txt=genres_txt[:-1]
    temp["genres"]=genres_txt if 'genres' in movie else "[]"

    temp["cast"]=[]
    for actor in cast:
        t={}
        t["name"]=actor["name"] if 'name' in actor else ""
        t["character"]=actor["character"] if 'character' in actor else ""
        t["profile_path"]= "https://image.tmdb.org/t/p"+"/w185"+str(actor['profile_path']) if 'profile_path' in actor and str(actor['profile_path'])!='None' else "https://bytes.usc.edu/cs571/s21_JSwasm00/hw/HW6/imgs/person-placeholder.png"
        temp["cast"].append(t)
        

    temp["reviews"]=[]
    rcount=0
    for r in review:
        if(rcount==5):
            break
        """if(str(r['author_details']['rating'])=='None'):
            continue"""
        rcount+=1
        t={}
        t["username"]=r["author_details"]['username'] if 'username' in r["author_details"] else ""
        t["content"]=r["content"] if 'content' in r else ""
        t["rating"]=str(round(float(r['author_details']['rating'])/2,2)) if 'rating' in r["author_details"] and str(r['author_details']['rating'])!='None' else ""
        t["created_at"]=r["created_at"][5:7]+"/"+r["created_at"][8:10]+"/"+r["created_at"][0:4] if 'created_at' in r else ""
        temp["reviews"].append(t)
        
        
    

    ret.append(temp)
    return json.dumps({"res":ret})


if __name__ == '__main__':
   app.run()
