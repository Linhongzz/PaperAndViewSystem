package cn.edu.hebeu.service.impl;

import cn.edu.hebeu.mapper.WendangMapper;
import cn.edu.hebeu.mapper.WendangleibieMapper;
import cn.edu.hebeu.pojo.Tuzhi;
import cn.edu.hebeu.pojo.Wendang;
import cn.edu.hebeu.pojo.Wendangleibie;
import cn.edu.hebeu.service.WendangService;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
@Service
public class WendangServiceImpl implements WendangService {
    @Autowired
    WendangMapper wendangMapper;
    @Autowired
    WendangleibieMapper wendangleibieMapper;
    /**
     * 仅仅为点击查询文档服务
     * @param request
     * @return
     */
    @Override
    public List<Wendang> findWendangByPages(HttpServletRequest request) {
        HttpSession session = request.getSession();
        int currentWendangPage = 1;//默认这个参数为1
        //把当前页页码存入session
        session.setAttribute("currentWendangPage", currentWendangPage);
        //分页参数
        RowBounds rowBounds = new RowBounds((currentWendangPage - 1) * 20, 20);

        return wendangMapper.findWendangByPages(rowBounds);
    }

    /**
     * 查询所有文档类别
     * @return
     */
    @Override
    public List<Wendangleibie> findAllWendangLeibies() {
        return wendangleibieMapper.findAllWendangLeibies();
    }

    /**
     * 获取总页数
     * @return
     */
    @Override
    public int getTotalPage() {
        int totalByLeibieId = wendangMapper.getTotal();
        return (int) Math.ceil(totalByLeibieId/20.0);
    }

    @Override
    public int getTotalPage(Long leibieId) {
        int totalByLeibieId = wendangMapper.getTotalByLeibieId(leibieId);
        return (int) Math.ceil(totalByLeibieId/20.0);
    }

    @Override
    public List<Wendang> listWendangByParams(Long leibieId, int currentWendangPage) {
        //分页参数
        RowBounds rowBounds = new RowBounds((currentWendangPage - 1) * 20, 20);
        if (leibieId == 0L) {
            return wendangMapper.listWendangByParamsWithoutLeibieId(rowBounds);
        } else {
            return wendangMapper.listWendangByParams(rowBounds,leibieId);
        }
    }

    @Override
    public List<Wendang> listWendangByFuzzyQuery(String text, int currentPage) {
        //分页参数
        RowBounds rowBounds = new RowBounds((currentPage - 1) * 20, 20);

            return wendangMapper.listWendangByFuzzyQuery(rowBounds, text);

    }

    @Override
    public int getTotalPageForFuzzyQuery(String text) {
        return (int) Math.ceil(wendangMapper.getTotalPageForFuzzyQuery(text)/20.0);
    }

    @Override
    public int saveWendang(Wendang wendang) {
        return wendangMapper.saveWendang(wendang);
    }

    @Override
    public int saveWendangLeibie(Wendangleibie wendangleibie) {
        // 获取到夫类别文档类别的depth
        Wendangleibie parentLeibie = wendangleibieMapper.getLeibie(wendangleibie.getParentId());
        wendangleibie.setDepth(parentLeibie.getDepth()+1);
        return wendangleibieMapper.addWendangLeibie(wendangleibie);
    }

    @Override
    public Wendang getWendangById(Long wendangId) {
        return wendangMapper.getWendangById(wendangId);
    }

    @Override
    public int updateWendang(Wendang changeWendang) {
        return wendangMapper.updateWendang(changeWendang);
    }

    @Override
    public int deleteWendangById(Long wendangId,String pathRoot) {
        //删除服务器中的文件
        Wendang wendang = wendangMapper.getWendangById(wendangId);
        String filePath = pathRoot;//保存图片的路径,tomcat中有配置
        String pdfPath = filePath+"/"+wendang.getPath();//被转成pdf的文件
        String origPath=filePath+"/"+wendang.getYuanshihouzhui();

        //删除硬盘中的文件
        File file = new File(pdfPath);
        if (!file.isDirectory()) {
            file.delete();
        }

        File file1 = new File(origPath);
        if (!file1.isDirectory()) {
            file1.delete();
        }

        //删除数据库中的数据
        return wendangMapper.deleteWendangById(wendangId);
    }
    //更新文档地址
    @Override
    public int updatePath(Long id, String path) {
        Wendang wendang = wendangMapper.getWendangById(id);
        wendang.setPath(path);
        return wendangMapper.updateWendang(wendang);
    }
}
