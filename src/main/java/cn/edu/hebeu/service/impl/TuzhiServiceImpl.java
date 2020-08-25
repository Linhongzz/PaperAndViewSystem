package cn.edu.hebeu.service.impl;

import cn.edu.hebeu.mapper.TuzhiMapper;
import cn.edu.hebeu.mapper.TuzhileibieMapper;
import cn.edu.hebeu.pojo.Tuzhi;
import cn.edu.hebeu.pojo.Tuzhileibie;
import cn.edu.hebeu.pojo.User;
import cn.edu.hebeu.service.TuzhiService;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

@Service
public class TuzhiServiceImpl implements TuzhiService {
    @Autowired
    TuzhiMapper tuzhiMapper;
    @Autowired
    TuzhileibieMapper tuzhileibieMapper;

    /**
     * 仅仅为点击查询图纸服务
     * @param request
     * @return
     */
    @Override
    public List<Tuzhi> findTuzhiByPages(HttpServletRequest request) {
        HttpSession session = request.getSession();
        int currentTuzhiPage = 1;//默认这个参数为1
        //把当前页页码存入session
        session.setAttribute("currentTuzhiPage", currentTuzhiPage);
        //分页参数
        RowBounds rowBounds = new RowBounds((currentTuzhiPage - 1) * 20, 20);

        return tuzhiMapper.findTuzhiByPages(rowBounds);
    }

    /**
     * 查询所有的图纸类别
     * @return
     */
    @Override
    public List<Tuzhileibie> findAllTuzhiLeibies() {
        return tuzhileibieMapper.findAllTuzhiLeibies();
    }

    @Override
    public List<Tuzhi> listTuzhiByParams(Long leibieId,int currentPage) {
        //分页参数
        RowBounds rowBounds = new RowBounds((currentPage - 1) * 20, 20);
        if (leibieId == 0L) {
            return tuzhiMapper.listTuzhiByParamsWithoutLeibieId(rowBounds);
        } else {

            return tuzhiMapper.listTuzhiByParams(rowBounds,leibieId);
        }

    }

    @Override
    public int getTotalPage(Long leibieId) {
        //需要获得的参数
        int totalByLeibieId = tuzhiMapper.getTotalByLeibieId(leibieId);
        return (int) Math.ceil(totalByLeibieId/20.0);
    }

    @Override
    public int getTotalPage() {
        int totalByLeibieId = tuzhiMapper.getTotal();
        return (int) Math.ceil(totalByLeibieId/20.0);
    }

    @Override
    public List<Tuzhi> listTuzhiByFuzzyQuery(String tumingOrTuhao, String text, int currentPage) {
        //分页参数
        RowBounds rowBounds = new RowBounds((currentPage - 1) * 20, 20);
        if (tumingOrTuhao.equals("tuming")) {
            //tuming
            return tuzhiMapper.listTuzhiByTuming(rowBounds, text);
        } else {//图号
            return tuzhiMapper.listTuzhiByTuhao(rowBounds, text);
        }



    }

    @Override
    public int getTotalPageForFuzzyQuery(String tumingOrTuhao, String text) {
        //需要获得的参数
        int totalByLeibieId ;
        if (tumingOrTuhao.equals("tuming")) {
            //tuming
            totalByLeibieId= tuzhiMapper.getTotalByTuming(text);
        } else {//图号
            totalByLeibieId=tuzhiMapper.getTotalByTuhao(text);
        }
        return (int) Math.ceil(totalByLeibieId/20.0);
    }

    @Override
    public int saveTuzhi(Tuzhi tuzhi) {
        return tuzhiMapper.addTuzhi(tuzhi);
    }

    @Override
    public Tuzhi getTuzhiById(Long tuzhiId) {
        return tuzhiMapper.getTuzhiById(tuzhiId);
    }

    @Override
    public int updateTuzhi(Tuzhi changeTuzhi) {
        return tuzhiMapper.updateTuzhi(changeTuzhi);
    }

    @Override
    public int deleteTuzhiById(Long tuzhiId) {
        //删除服务器中的文件
        Tuzhi tuzhi = tuzhiMapper.getTuzhiById(tuzhiId);
        String filePath = "C:/documents";//保存图片的路径,tomcat中有配置
        filePath = filePath+"/"+tuzhi.getPath();
        //删除硬盘中的文件
        File file = new File(filePath);
        if (!file.isDirectory()) {
            file.delete();
        }

        //删除数据库中的数据
        return tuzhiMapper.deleteTuzhiById(tuzhiId);
    }
}
