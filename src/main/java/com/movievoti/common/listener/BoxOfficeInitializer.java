package com.movievoti.common.listener;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
        
        MovieDAO dao = MovieDAO.getInstance();
        dao.resetAllFlags();
        
        MovieApiService apiService = new MovieApiService();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 2. 박스오피스 (최대 10개만 저장)
        List<BoxOfficeMovie> boxList = apiService.getDailyBoxOffice();
        int savedCount = 0; // 저장된 개수 카운트
        
        if (boxList != null) {
            for (BoxOfficeMovie m : boxList) {
                if (savedCount >= 10) break; // 10개 채워지면 중단
                savedCount++;
                m.setRank(String.valueOf(savedCount)); // 순위 재정렬 (1~10)
                dao.upsertMovie(m, false);
            }
            System.out.println(">> 박스오피스 데이터 " + savedCount + "건 저장 완료");
        }

        // 3. 개봉 예정작 (최대 5개만 저장)
        List<BoxOfficeMovie> upList = apiService.getUpcomingMovies();
        savedCount = 0; // 카운트 초기화
        
        if (upList != null) {
            for (BoxOfficeMovie m : upList) {
                if (savedCount >= 5) break; // 5개 채워지면 중단 (원하시면 10으로 변경 가능)

                // [필터링] 오늘보다 미래인 작품만
                try {
                    if (m.getOpenDt() != null && !m.getOpenDt().isEmpty()) {
                        LocalDate openDate = LocalDate.parse(m.getOpenDt(), formatter);
                        if (!openDate.isAfter(today)) {
                            continue; 
                        }
                    }
                } catch (Exception e) {}
                
                savedCount++;
                dao.upsertMovie(m, true);
            }
            System.out.println(">> 개봉예정작 데이터 " + savedCount + "건 저장 완료");
        }
        
        System.out.println("====== [MovieVoti] 데이터 업데이트 종료 ======");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) { }
}