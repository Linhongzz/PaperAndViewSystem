package cn.edu.hebeu.mapper;

import cn.edu.hebeu.pojo.Wendang;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WendangMapper {
    List<Wendang> findWendangByPages(RowBounds rowBounds);

    int getTotal();
    int getTotalByLeibieId(Long leibieId);

    List<Wendang> listWendangByParamsWithoutLeibieId(RowBounds rowBounds);
    List<Wendang> listWendangByParams(RowBounds rowBounds, Long leibieId);


    List<Wendang> listWendangByFuzzyQuery(RowBounds rowBounds, String text);

    int getTotalPageForFuzzyQuery(String text);

    int saveWendang(Wendang wendang);

    Wendang getWendangById(Long wendangId);

    int updateWendang(Wendang changeWendang);

    int deleteWendangById(Long wendangId);
}
