package cn.edu.hebeu.controller;

import cn.edu.hebeu.pojo.Tuzhi;
import cn.edu.hebeu.pojo.Tuzhileibie;
import cn.edu.hebeu.pojo.Wendang;
import cn.edu.hebeu.pojo.Wendangleibie;
import cn.edu.hebeu.service.WendangService;
import com.aspose.words.Document;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/wendang")
public class WendangController {
    @Autowired
    WendangService wendangService;

    //获取物理路径webapp所在路径
    WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
    ServletContext servletContext = webApplicationContext.getServletContext();
    // 得到文件绝对路径
    String destRealRoot = servletContext.getRealPath("/resources/plugins/pdfJs/web")+"/";


    //文档在服务器的位置
    String pathRoot = "C:/documents/";
    //服务器位置
    String webPath="http://localhost:8080";


    @RequestMapping("/listWendang")
    public String listWendang(HttpServletRequest request) {
        //调用service查询所有的文档
        List<Wendang> wendangList = wendangService.findWendangByPages(request);
        //查询到所有图纸的类别并存入session，便于渲染树状结构，选择图纸类别进行查询
        List<Wendangleibie> wendangleibieList = wendangService.findAllWendangLeibies();
        //查询所有图纸的数量，用于 分页条
        int totalWendangPage = wendangService.getTotalPage();

        //存入session
        request.getSession().setAttribute("wendangList", wendangList);
        request.getSession().setAttribute("wendangleibieList", wendangleibieList);
        request.getSession().setAttribute("totalWendangPage", totalWendangPage);
        //交给jsp渲染视图
        return "wendangList";
    }

    /**
     * 通过参数 来获得不同页的文档
     */
    @RequestMapping("/listWendangByParams")
    public ModelAndView listWendangByParams(@RequestParam("leibieId") Long leibieId, @RequestParam("currentWendangPage") int currentWendangPage) {
        ModelAndView mv = new ModelAndView();
        //调用service查询文件
        List<Wendang> wendangList = wendangService.listWendangByParams(leibieId, currentWendangPage);
        mv.addObject("wendangList", wendangList);
        //调用service查询有多少分页条的属性
        int totalPage = 0;
        if (leibieId == 0L) {
            totalPage = wendangService.getTotalPage();
        } else {
            totalPage = wendangService.getTotalPage(leibieId);
        }

        mv.addObject("totalPage", totalPage);

        mv.addObject("currentPage", currentWendangPage);
        mv.setView(new MappingJackson2JsonView());//设置视图为json
        return mv;
    }

    @RequestMapping("/listWendangByParamsRedirect")
    public String listWendangByParamsRedirect(HttpServletRequest request) {
        String leibieId_str = request.getParameter("leibieId");
        Long leibieId = Long.parseLong(leibieId_str);
        List<Wendang> wendangList = wendangService.listWendangByParams(leibieId,1);
        //查询所有图纸的数量，用于 分页条
        int totalWendangPage = wendangService.getTotalPage(leibieId);

        //存入session
        request.getSession().setAttribute("wendangList", wendangList);
        request.getSession().setAttribute("totalWendangPage", totalWendangPage);
        //交给jsp渲染视图
        return "wendangList";
    }

    /**
     * 模糊查询
     * tumingOrTuhao:tumingOrTuhao,text:text,currentPage:currentPage
     */
    @RequestMapping("/listWendangByFuzzyQuery")
    public ModelAndView listWendangByFuzzyQuery(
            @RequestParam("text") String text,
            @RequestParam("currentPage") int currentPage) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        text = URLDecoder.decode(text, "utf-8");
        //调用service执行方法 查询文件
        List<Wendang> wendangList = wendangService.listWendangByFuzzyQuery(text, currentPage);
        mv.addObject("wendangList", wendangList);
        //调用service查询有多少分页条的属性
        int totalPage = wendangService.getTotalPageForFuzzyQuery(text);
        mv.addObject("totalPage", totalPage);
        mv.addObject("currentPage", currentPage);
        mv.setView(new MappingJackson2JsonView());//设置视图为json
        return mv;
    }

    @RequestMapping("toManageWendang")
    public String toManageWendang(HttpServletRequest request) {
        //调用service查询所有的文档
        List<Wendang> wendangList = wendangService.findWendangByPages(request);
        //查询到所有图纸的类别并存入session，便于渲染树状结构，选择图纸类别进行查询
        List<Wendangleibie> wendangleibieList = wendangService.findAllWendangLeibies();
        //查询所有图纸的数量，用于 分页条
        int totalPage = wendangService.getTotalPage();
        //存入session
        request.getSession().setAttribute("wendangList", wendangList);
        request.getSession().setAttribute("wendangleibieList", wendangleibieList);
        request.getSession().setAttribute("totalWendangPage", totalPage);
        //交给jsp渲染视图
        return "manageWendang";
    }

    @RequestMapping("/toAddWendang")
    public String toAddWendang(HttpServletRequest request) {
        //查询到所有图纸的类别并存入session，便于渲染树状结构，选择图纸类别进行查询
        List<Wendangleibie> WendangleibieList = wendangService.findAllWendangLeibies();
        request.getSession().setAttribute("WendangleibieList", WendangleibieList);
        return "addWendang";
    }

    @RequestMapping("/addWendang")
    public String addWendang(HttpServletRequest request) {
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
        //获取参数
        String wendangming = request.getParameter("wendangming");
        Long wendangLeibie = Long.parseLong(request.getParameter("wendangLeibie"));
        MultipartFile file = multipartHttpServletRequest.getFile("file");
        //新建Wendang对象
        Wendang wendang = new Wendang();
        /**
         * 上传文件
         */
        //文件上传成功后，将文件的地址写到数据库
        String filePath = pathRoot;//保存图片的路径
        //获取原始文件名
        String originalFilename = file.getOriginalFilename();
        //获取后缀
        String suffix = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
        //设置原始后缀
        //wendang.setYuanshihouzhui(originalFilename);//不存原始后缀了，此处存原始文件名


        //设置wendangming
        if (wendangming != null && !wendangming.equals("")) {//如果传值有wendangming
            //加上后缀
            wendang.setWendangming(wendangming);
        } else {//传值没有tuming，用文件的名字
            //去掉后缀
            originalFilename = originalFilename.substring(0, originalFilename.indexOf("." + suffix));
            wendang.setWendangming(originalFilename);
        }
        wendang.setLeibie(new Wendangleibie(wendangLeibie));
        //新的文件名字，使用uuid随机生成数这样不会重复
        String uuid = UUID.randomUUID() + "";
        String newFileName = uuid + "." + suffix;


        //封装上传文件位置的全路径，就是硬盘路径+文件名
        File targetFile = new File(filePath, newFileName);

        try {
            //把本地文件上传到已经封装好的文件位置的全路径就是上面的targetFile
            file.transferTo(targetFile);
            wendang.setPath(uuid + ".pdf");//文件名保存到实体类对应属性上
            wendang.setYuanshihouzhui(uuid+"."+suffix);//保存原始文件
            if (!suffix.equalsIgnoreCase("pdf")) {//如果不是pdf格式的文档
                Document doc = null;
                try {
                    //创建一个原始文件
                    doc = new Document(filePath + "/" + newFileName);

                    //if (!suffix.equalsIgnoreCase("pdf")) {//原始文件不是pdf需要转换一下
                    //转换
                    doc.save(filePath + "/" + uuid + ".pdf");
                    //}
                    //wendang.setPath(uuid + ".pdf");//文件名保存到实体类对应属性上
                    request.getSession().setAttribute("addWendang_msg", "保存文档成功");

                } catch (Exception e) {//如果不是可以转换的文件类型
                    wendang.setPath(uuid + "." + suffix);
                    request.getSession().setAttribute("addWendang_msg", "保存文档成功");
                }

            } else {//是pdf文件
                request.getSession().setAttribute("addWendang_msg", "保存文档成功");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("addWendang_msg", "保存文档出错");
        }
        //把Wendang对象信息传入数据库保存
        wendangService.saveWendang(wendang);
        return "redirect:/wendang/toAddWendang.do";
    }

    @RequestMapping("/toUpdateWendang")
    public String toUpdateWendang(HttpServletRequest request) {
        //获取到需要修改的图纸的id，在数据库中查找到这个数据，并在修改页面进行回显
        Long wendangId = Long.parseLong(request.getParameter("wendangId"));
        Wendang changeWendang = wendangService.getWendangById(wendangId);
        request.getSession().setAttribute("changeWendang", changeWendang);
        return "updateWendang";
    }

    @RequestMapping("/updateWendang")
    public String updateWendang(HttpServletRequest request) {
        //从session 中取出 changeTuzhi
        Wendang changeWendang = (Wendang) request.getSession().getAttribute("changeWendang");
        //从session中删除
        request.getSession().removeAttribute("changeWendang");
        //获得表单中填写的参数
        String wendangming = request.getParameter("wendangming");
        Long wendangLeibie = Long.parseLong(request.getParameter("wendangLeibie"));
        changeWendang.setLeibie(new Wendangleibie(wendangLeibie));
        changeWendang.setWendangming(wendangming);
        //传给service修改
        wendangService.updateWendang(changeWendang);
        request.getSession().setAttribute("updateWendang_msg", "修改文档成功");
        return "redirect:/wendang/toManageWendang.do";//重定向到管理图纸
    }

    @RequestMapping("/deleteWendang")
    public ModelAndView deleteWendang(@Param("wendangId") Long wendangId) {
        ModelAndView mv = new ModelAndView();
        mv.setView(new MappingJackson2JsonView());
        //调用service
        try {
            wendangService.deleteWendangById(wendangId,pathRoot);
            mv.addObject("updateWendang_msg", "删除文档成功");
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("updateWendang_msg", "删除文档失败");
        }
        return mv;
    }

    //在线展示文档
    @RequestMapping("/displayWendang")
    public String displayWendang(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
        //接收传入的图纸地址

        Long id = Long.parseLong(request.getParameter("id"));

        Wendang wendangById = wendangService.getWendangById(id);
        String path = wendangById.getPath();


        if (path.indexOf(".pdf") == -1) {//不是pdf文件
            return "redirect:"+webPath+"/documents/"+path;//直接查看
        }


        //想命名的原文件的路径
        File file = new File(pathRoot+path);

        //把pdf文件重命名一次
        path = UUID.randomUUID() + ".pdf";

        //将原文件更改为f:\a\b.xlsx，其中路径是必要的。注意
        if (file.renameTo(new File(pathRoot + path))) {
        //更新文档的地址
            wendangService.updatePath(id, path);
        }



        //重定向调用预览pdf的插件
        return "redirect:/resources/plugins/pdfJs/web/viewer.html?file=/documents/"+path;
    }

    //下载
    @RequestMapping("/download")
    public void down(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long id = Long.parseLong(request.getParameter("id"));
        Wendang wendang = wendangService.getWendangById(id);

        String filePath = pathRoot;
        String fileName = wendang.getYuanshihouzhui();//这是转换过后的pdf的位置，原始文件是同名的原始后缀的文件
        //获取文件的后缀
        String suffix=fileName.substring(fileName.lastIndexOf(".") + 1);
        if (suffix.equalsIgnoreCase("pdf")) {//原始文件是pdf文件
            fileName = wendang.getPath();//他就只有一个文件把这个文件下载下来
        }
        String realPath = filePath + fileName;


        InputStream bis = new BufferedInputStream(new FileInputStream(new File(realPath)));
        fileName = wendang.getWendangming() + "." + suffix;
        fileName = URLEncoder.encode(fileName, "UTF-8");

        response.addHeader("Content-Disposition", "attachment;filename=" + fileName);

        response.setContentType("multipart/form-data");

        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        int len = 0;
        while ((len = bis.read()) != -1) {
            out.write(len);
            out.flush();
        }
        out.close();
    }

    @RequestMapping("toShebeishuomingshu")
    public String toShebeishuomingshu() {
        return "shebeishuomingshu";
    }
}
