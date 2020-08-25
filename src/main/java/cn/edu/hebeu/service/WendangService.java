package cn.edu.hebeu.service;

import cn.edu.hebeu.pojo.Tuzhi;
import cn.edu.hebeu.pojo.Wendang;
import cn.edu.hebeu.pojo.Wendangleibie;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface WendangService {
    public List<Wendang> findWendangByPages(HttpServletRequest request);
    public List<Wendangleibie> findAllWendangLeibies();
    public int getTotalPage();
    public int getTotalPage(Long leibieId);

    List<Wendang> listWendangByParams(Long leibieId, int currentWendangPage);

    List<Wendang> listWendangByFuzzyQuery(String text, int currentPage);

    int getTotalPageForFuzzyQuery(String text);

    int saveWendang(Wendang wendang);

    Wendang getWendangById(Long wendangId);

    int updateWendang(Wendang changeWendang);

    int deleteWendangById(Long wendangId,String pathRoot);

    int updatePath(Long id, String path);
}
