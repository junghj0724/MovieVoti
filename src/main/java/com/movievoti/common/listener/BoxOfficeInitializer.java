package com.movievoti.common.listener;

import java.util.List;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import com.movievoti.model.dao.MovieDAO;
import com.movievoti.service.MovieApiService;
import com.movievoti.service.MovieApiService.BoxOfficeMovie;

@WebListener
public class BoxOfficeInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("====== [MovieVoti] 서버 시작: 영화 데이터 업데이트 시작 ======");
        
        // 1. 기존 데이터 플래그 초기화
        MovieDAO dao = MovieDAO.getInstance();
        dao.resetAllFlags();
        
        MovieApiService apiService = new MovieApiService();

        // 2. 박스오피스 데이터 가져오기 & 저장 (isUpcoming = false)
        List<BoxOfficeMovie> boxList = apiService.getDailyBoxOffice();
        if (boxList != null) {
            for (BoxOfficeMovie m : boxList) {
                dao.upsertMovie(m, false); // false: 박스오피스
            }
            System.out.println(">> 박스오피스 " + boxList.size() + "건 저장 완료");
        }

        // 3. 개봉 예정작 데이터 가져오기 & 저장 (isUpcoming = true)
        List<BoxOfficeMovie> upList = apiService.getUpcomingMovies();
        if (upList != null) {
            for (BoxOfficeMovie m : upList) {
                dao.upsertMovie(m, true); // true: 예정작
            }
            System.out.println(">> 개봉예정작 " + upList.size() + "건 저장 완료");
        }
        
        System.out.println("====== [MovieVoti] 데이터 업데이트 종료 ======");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) { }
}