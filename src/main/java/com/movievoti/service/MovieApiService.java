package com.movievoti.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class MovieApiService {
    private static final String TMDB_API_KEY = "e379422f0b12543b25907ac572b6f9e4";
    private static final String KOFIC_API_KEY = "ad8b0e5f6b14fefdb9170e53ed971f83";
    
    public static class BoxOfficeMovie {
        private int movieId;
        private String rank;
        private String title;
        private String openDt;
        private String audiAcc;
        private String posterPath;
        private String overview;
        private double voteAverage;
        private double myRating;
        private String trailerKey;
        private String genre;          // ★ 추가됨: 장르

        // Getter & Setter
        public int getMovieId() { return movieId; }
        public void setMovieId(int movieId) { this.movieId = movieId; }
        public String getRank() { return rank; }
        public void setRank(String rank) { this.rank = rank; }
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getOpenDt() { return openDt; }
        public void setOpenDt(String openDt) { this.openDt = openDt; }
        public String getTrailerKey() { return trailerKey; }
        public void setTrailerKey(String trailerKey) { this.trailerKey = trailerKey; }
        
        public String getGenre() { return genre; } // ★ 추가
        public void setGenre(String genre) { this.genre = genre; } // ★ 추가
        
        public String getAudiAcc() { 
            if (audiAcc == null) return "";
            try {
                int count = Integer.parseInt(audiAcc.replaceAll(",", ""));
                return String.format("%,d명", count);
            } catch(Exception e) { return audiAcc; }
        }
        public void setAudiAcc(String audiAcc) { this.audiAcc = audiAcc; }
        
        public String getPosterPath() {
            return (posterPath != null && !posterPath.isEmpty()) 
                   ? "https://image.tmdb.org/t/p/w500" + posterPath 
                   : "https://placehold.co/400x600?text=No+Image";
        }
        public void setPosterPath(String posterPath) { this.posterPath = posterPath; }
        
        public String getOverview() { return overview; }
        public void setOverview(String overview) { this.overview = overview; }
        public double getVoteAverage() { return voteAverage; }
        public void setVoteAverage(double voteAverage) { this.voteAverage = voteAverage; }
        public double getMyRating() { return myRating; }
        public void setMyRating(double myRating) { this.myRating = myRating; }
    }

    public List<BoxOfficeMovie> getDailyBoxOffice() {
        List<BoxOfficeMovie> list = new ArrayList<>();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, -1);
            String targetDt = sdf.format(cal.getTime());

            String koficUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
                            + "?key=" + KOFIC_API_KEY + "&targetDt=" + targetDt;
            
            String koficJson = requestApi(koficUrl);
            JsonObject root = JsonParser.parseString(koficJson).getAsJsonObject();
            JsonArray dailyList = root.getAsJsonObject("boxOfficeResult").getAsJsonArray("dailyBoxOfficeList");

            for (int i = 0; i < dailyList.size(); i++) {
                JsonObject obj = dailyList.get(i).getAsJsonObject();
                BoxOfficeMovie movie = new BoxOfficeMovie();
                movie.setRank(obj.get("rank").getAsString());
                movie.setTitle(obj.get("movieNm").getAsString());
                movie.setOpenDt(obj.get("openDt").getAsString());
                movie.setAudiAcc(obj.get("audiAcc").getAsString());
                updateMovieInfoFromTmdb(movie, movie.getTitle());
                list.add(movie);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public List<BoxOfficeMovie> getUpcomingMovies() {
        List<BoxOfficeMovie> list = new ArrayList<>();
        try {
            String tmdbUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=" + TMDB_API_KEY + "&language=ko-KR&page=1&region=KR";
            String json = requestApi(tmdbUrl);
            JsonObject root = JsonParser.parseString(json).getAsJsonObject();
            JsonArray results = root.getAsJsonArray("results");
            for (int i = 0; i < Math.min(results.size(), 5); i++) {
                JsonObject obj = results.get(i).getAsJsonObject();
                BoxOfficeMovie movie = new BoxOfficeMovie();
                movie.setTitle(obj.get("title").getAsString());
                movie.setOpenDt(obj.get("release_date").getAsString());
                movie.setVoteAverage(obj.get("vote_average").getAsDouble());
                if (!obj.get("poster_path").isJsonNull()) movie.setPosterPath(obj.get("poster_path").getAsString());
                if (!obj.get("overview").isJsonNull()) movie.setOverview(obj.get("overview").getAsString());
                list.add(movie);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ★ [업그레이드] 장르, 상세 정보, 예고편 모두 가져오기
    public void getMovieDetail(BoxOfficeMovie movie) {
        try {
            // 1. 검색으로 ID 찾기
            String encodedTitle = URLEncoder.encode(movie.getTitle(), "UTF-8");
            String searchUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + TMDB_API_KEY + "&language=ko-KR&page=1&query=" + encodedTitle;
            
            String searchJson = requestApi(searchUrl);
            JsonObject searchRoot = JsonParser.parseString(searchJson).getAsJsonObject();
            JsonArray results = searchRoot.getAsJsonArray("results");

            if (results.size() > 0) {
                JsonObject firstResult = results.get(0).getAsJsonObject();
                int tmdbId = firstResult.get("id").getAsInt();
                
                // 2. [추가] 상세 정보 API 호출 (여기서 장르를 가져옴)
                String detailUrl = "https://api.themoviedb.org/3/movie/" + tmdbId + "?api_key=" + TMDB_API_KEY + "&language=ko-KR";
                String detailJson = requestApi(detailUrl);
                JsonObject detailRoot = JsonParser.parseString(detailJson).getAsJsonObject();

                // 기본 정보 갱신
                if (!detailRoot.get("poster_path").isJsonNull()) movie.setPosterPath(detailRoot.get("poster_path").getAsString());
                if (!detailRoot.get("overview").isJsonNull()) movie.setOverview(detailRoot.get("overview").getAsString());
                movie.setVoteAverage(detailRoot.get("vote_average").getAsDouble());
                
                // ★ 장르 파싱
                JsonArray genres = detailRoot.getAsJsonArray("genres");
                List<String> genreNames = new ArrayList<>();
                for(JsonElement g : genres) {
                    genreNames.add(g.getAsJsonObject().get("name").getAsString());
                }
                movie.setGenre(String.join(", ", genreNames)); // "액션, 모험, SF" 형태로 저장

                // 3. 예고편 가져오기
                String videoUrl = "https://api.themoviedb.org/3/movie/" + tmdbId + "/videos?api_key=" + TMDB_API_KEY + "&language=ko-KR";
                String videoJson = requestApi(videoUrl);
                JsonObject videoRoot = JsonParser.parseString(videoJson).getAsJsonObject();
                JsonArray videos = videoRoot.getAsJsonArray("results");
                
                for (JsonElement el : videos) {
                    JsonObject v = el.getAsJsonObject();
                    if ("YouTube".equals(v.get("site").getAsString()) && "Trailer".equals(v.get("type").getAsString())) {
                        movie.setTrailerKey(v.get("key").getAsString());
                        break;
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    // [검색용]
    public List<BoxOfficeMovie> searchMovies(String keyword) {
        List<BoxOfficeMovie> list = new ArrayList<>();
        try {
            String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
            String searchUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + TMDB_API_KEY + "&language=ko-KR&page=1&query=" + encodedKeyword;
            
            String json = requestApi(searchUrl);
            JsonObject root = JsonParser.parseString(json).getAsJsonObject();
            JsonArray results = root.getAsJsonArray("results");

            for (int i = 0; i < results.size(); i++) {
                JsonObject obj = results.get(i).getAsJsonObject();
                BoxOfficeMovie movie = new BoxOfficeMovie();
                movie.setTitle(obj.get("title").getAsString());
                if (obj.has("release_date") && !obj.get("release_date").isJsonNull()) {
                    movie.setOpenDt(obj.get("release_date").getAsString());
                } else { movie.setOpenDt(""); }
                movie.setVoteAverage(obj.get("vote_average").getAsDouble());
                if (!obj.get("poster_path").isJsonNull()) movie.setPosterPath(obj.get("poster_path").getAsString());
                if (!obj.get("overview").isJsonNull()) movie.setOverview(obj.get("overview").getAsString());
                list.add(movie);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    private void updateMovieInfoFromTmdb(BoxOfficeMovie movie, String queryTitle) {
        try {
            String encodedTitle = URLEncoder.encode(queryTitle, "UTF-8");
            String tmdbUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + TMDB_API_KEY + "&language=ko-KR&page=1&query=" + encodedTitle;
            String json = requestApi(tmdbUrl);
            JsonObject root = JsonParser.parseString(json).getAsJsonObject();
            JsonArray results = root.getAsJsonArray("results");
            if (results.size() > 0) {
                JsonObject firstResult = results.get(0).getAsJsonObject();
                if (!firstResult.get("poster_path").isJsonNull()) movie.setPosterPath(firstResult.get("poster_path").getAsString());
                movie.setVoteAverage(firstResult.get("vote_average").getAsDouble());
                if (!firstResult.get("overview").isJsonNull()) movie.setOverview(firstResult.get("overview").getAsString());
            }
        } catch (Exception e) { }
    }

    private String requestApi(String apiUrl) throws Exception {
        URL url = new URI(apiUrl).toURL();
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) sb.append(line);
        br.close();
        return sb.toString();
    }
}