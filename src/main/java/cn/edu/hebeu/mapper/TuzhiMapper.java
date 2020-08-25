package cn.edu.hebeu.mapper;

import cn.edu.hebeu.pojo.Tuzhi;
import cn.edu.hebeu.pojo.Tuzhileibie;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface TuzhiMapper {
    List<Tuzhi> findTuzhiByPages(RowBounds rowBounds);
    List<Tuzhi> listTuzhiByParams(RowBounds rowBounds,Long leibieId);

    int getTotalByLeibieId(Long leibieId);
    int getTotal();

    List<Tuzhi> listTuzhiByParamsWithoutLeibieId(RowBounds rowBounds);


    int getTotalByTuming(String text);
    int getTotalByTuhao(String text);

    List<Tuzhi> listTuzhiByTuming(RowBounds rowBounds, String text);

    List<Tuzhi> listTuzhiByTuhao(RowBounds rowBounds, String text);

    int addTuzhi(Tuzhi tuzhi);

    Tuzhi getTuzhiById(Long tuzhiId);

    int updateTuzhi(Tuzhi changeTuzhi);

    int deleteTuzhiById(Long tuzhiId);
}
