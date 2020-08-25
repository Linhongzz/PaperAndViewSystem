package cn.edu.hebeu.service;

import cn.edu.hebeu.pojo.Tuzhi;
import cn.edu.hebeu.pojo.Tuzhileibie;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface TuzhiService {

    List<Tuzhi> findTuzhiByPages(HttpServletRequest request);

    List<Tuzhileibie> findAllTuzhiLeibies();

    List<Tuzhi> listTuzhiByParams(Long leibieId,int currentPage);

    int getTotalPage(Long leibieId);
    int getTotalPage();

    List<Tuzhi> listTuzhiByFuzzyQuery(String tumingOrTuhao, String text, int currentPage);

    int getTotalPageForFuzzyQuery(String tumingOrTuhao, String text);

    int saveTuzhi(Tuzhi tuzhi);

    Tuzhi getTuzhiById(Long tuzhiId);

    int updateTuzhi(Tuzhi changeTuzhi);

    int deleteTuzhiById(Long tuzhiId);
}
