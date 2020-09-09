package cn.edu.hebeu.controller;

import cn.edu.hebeu.pojo.Tuzhi;
import cn.edu.hebeu.pojo.Tuzhileibie;
import cn.edu.hebeu.service.TuzhiService;
import cn.edu.hebeu.service.impl.TuzhiServiceImpl;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/tuzhi")
public class TuzhiController {
    @Autowired
    TuzhiService tuzhiService;

    //文档在服务器的位置
    String pathRoot = "C:/documents/";
    //服务器位置
    String webPath="http://localhost:8080";

    /**
     * 点击图纸查询按钮
     * 默认查询所有图纸
     * 跳转到tuzhiList.jsp展示数据
     */
    @RequestMapping("/listTuzhi")
    public String listTuzhi(HttpServletRequest request) {
        //调用service查询所有的图纸
        List<Tuzhi> tuzhiList = tuzhiService.findTuzhiByPages(request);
        //查询到所有图纸的类别并存入session，便于渲染树状结构，选择图纸类别进行查询
        List<Tuzhileibie> tuzhileibieList = tuzhiService.findAllTuzhiLeibies();
        //查询所有图纸的数量，用于 分页条
        int totalPage = tuzhiService.getTotalPage();

        //存入session
        request.getSession().setAttribute("tuzhiList", tuzhiList);
        request.getSession().setAttribute("tuzhileibieList", tuzhileibieList);
        request.getSession().setAttribute("totalPage", totalPage);
        //交给jsp渲染视图
        return "tuzhiList";
    }


    @RequestMapping("/toManageTuzhi")
    public String toManageTuzhi(HttpServletRequest request) {
        //调用service查询所有的图纸
        List<Tuzhi> tuzhiList = tuzhiService.findTuzhiByPages(request);
        //查询到所有图纸的类别并存入session，便于渲染树状结构，选择图纸类别进行查询
        List<Tuzhileibie> tuzhileibieList = tuzhiService.findAllTuzhiLeibies();
        //查询所有图纸的数量，用于 分页条
        int totalPage = tuzhiService.getTotalPage();

        //存入session
        request.getSession().setAttribute("tuzhiList", tuzhiList);
        request.getSession().setAttribute("tuzhileibieList", tuzhileibieList);
        request.getSession().setAttribute("totalPage", totalPage);
        //交给jsp渲染视图
        return "manageTuzhi";
    }

    @RequestMapping("/toAddTuzhi")
    public String toAddTuzhi(HttpServletRequest request) {
        //查询到所有图纸的类别并存入session，便于渲染树状结构，选择图纸类别进行查询
        List<Tuzhileibie> tuzhileibieList = tuzhiService.findAllTuzhiLeibies();
        request.getSession().setAttribute("tuzhileibieList", tuzhileibieList);
        return "addTuzhi";
    }

    @RequestMapping("/toUpdateTuzhi")
    public String toUpdateTuzhi(HttpServletRequest request) {
        //获取到需要修改的图纸的id，在数据库中查找到这个数据，并在修改页面进行回显
        Long tuzhiId = Long.parseLong(request.getParameter("tuzhiId"));
        Tuzhi changeTuzhi = tuzhiService.getTuzhiById(tuzhiId);
        request.getSession().setAttribute("changeTuzhi", changeTuzhi);

        return "updateTuzhi";
    }

    /**
     * 通过参数 来获得不同页的图纸
     */
    @RequestMapping("/listTuzhiByParams")
    public ModelAndView listTuzhiByParams(@RequestParam("leibieId") Long leibieId, @RequestParam("currentTuzhiPage") int currentTuzhiPage) {
        ModelAndView mv = new ModelAndView();
        //调用service查询文件
        List<Tuzhi> tuzhiList = tuzhiService.listTuzhiByParams(leibieId, currentTuzhiPage);
        mv.addObject("tuzhiList", tuzhiList);
        //调用service查询有多少分页条的属性
        int totalPage = 0;
        if (leibieId == 0L) {
            totalPage = tuzhiService.getTotalPage();
        } else {
            totalPage = tuzhiService.getTotalPage(leibieId);
        }

        mv.addObject("totalPage", totalPage);

        mv.addObject("currentPage", currentTuzhiPage);
        mv.setView(new MappingJackson2JsonView());//设置视图为json
        return mv;
    }

    /**
     * 模糊查询
     * tumingOrTuhao:tumingOrTuhao,text:text,currentPage:currentPage
     */
    @RequestMapping("/listTuzhiByFuzzyQuery")
    public ModelAndView listTuzhiByFuzzyQuery(
            @RequestParam("tumingOrTuhao") String tumingOrTuhao,
            @RequestParam("text") String text,
            @RequestParam("currentPage") int currentPage) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        text=URLDecoder.decode(text, "utf-8");
        //调用service执行方法 查询文件
        List<Tuzhi> tuzhiList = tuzhiService.listTuzhiByFuzzyQuery(tumingOrTuhao, text, currentPage);
        mv.addObject("tuzhiList", tuzhiList);
        //调用service查询有多少分页条的属性
        int totalPage = tuzhiService.getTotalPageForFuzzyQuery(tumingOrTuhao, text);
        mv.addObject("totalPage", totalPage);
        mv.addObject("currentPage", currentPage);
        mv.setView(new MappingJackson2JsonView());//设置视图为json
        return mv;
    }

    @RequestMapping("/addTuzhi")
    public String addTuzhi(HttpServletRequest request) {
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
        //获取参数
        String tuming = request.getParameter("tuming");
        String tuhao = request.getParameter("tuhao");
        Long tuzhiLeibie = Long.parseLong(request.getParameter("tuzhiLeibie"));
        MultipartFile file = multipartHttpServletRequest.getFile("file");
        //新建Tuzhi对象
        Tuzhi tuzhi = new Tuzhi();
        /**
         * 上传文件
         */
        //图片上传成功后，将图片的地址写到数据库
        String filePath = pathRoot;//保存图片的路径,tomcat中有配置
        //获取原始文件名
        String originalFilename = file.getOriginalFilename();
        String suffix=originalFilename.substring(originalFilename.lastIndexOf(".")+1);
        if(!suffix.equalsIgnoreCase("pdf")){
            //原始文件名后缀不是pdf
            request.getSession().setAttribute("addTuzhi_msg", "上传文件类型出错，请选择pdf格式的文件");
            return "redirect:/tuzhi/toAddTuzhi.do";
        }

        //设置tuming
        if (tuming != null && !tuming.equals("")) {//如果传值有tuming
            //加上后缀
            tuzhi.setTuming(tuming);
            originalFilename = tuming;
        } else {//传值没有tuming，用文件的名字
            //去掉后缀
            originalFilename = originalFilename.substring(0, originalFilename.indexOf(".pdf"));
            tuzhi.setTuming(originalFilename);
        }
        tuzhi.setTuhao(tuhao);
        tuzhi.setLeibie(new Tuzhileibie(tuzhiLeibie));

        //新的文件名字，使用uuid随机生成数这样不会重复
        String newFileName = UUID.randomUUID()+".pdf";
        //封装上传文件位置的全路径，就是硬盘路径+文件名
        File targetFile = new File(filePath, newFileName);
        //把本地文件上传到已经封装好的文件位置的全路径就是上面的targetFile
        try {
            file.transferTo(targetFile);
            tuzhi.setPath(newFileName);//文件名保存到实体类对应属性上
            request.getSession().setAttribute("addTuzhi_msg", "保存图纸成功");
        } catch (IOException e) {
            e.printStackTrace(); //出错了
            request.getSession().setAttribute("addTuzhi_msg", "保存图纸出错");
        }
        //把Tuzhi对象信息传入数据库保存
        tuzhiService.saveTuzhi(tuzhi);


        return "redirect:/tuzhi/toAddTuzhi.do";
    }

    @RequestMapping("/updateTuzhi")
    public String updateTuzhi(HttpServletRequest request) {
        //从session 中取出 changeTuzhi
        Tuzhi changeTuzhi = (Tuzhi) request.getSession().getAttribute("changeTuzhi");
        //从session中删除
        request.getSession().removeAttribute("changeTuzhi");
        //获得表单中填写的参数
        String tuming = request.getParameter("tuming");
        String tuhao = request.getParameter("tuhao");
        Long tuzhiLeibie = Long.parseLong(request.getParameter("tuzhiLeibie"));
        changeTuzhi.setLeibie(new Tuzhileibie(tuzhiLeibie));
        changeTuzhi.setTuming(tuming);
        changeTuzhi.setTuhao(tuhao);
        //传给service修改
        tuzhiService.updateTuzhi(changeTuzhi);
        request.getSession().setAttribute("updateTuzhi_msg", "修改图纸成功");


        return "redirect:/tuzhi/toManageTuzhi.do";//重定向到管理图纸
    }

    @RequestMapping("/deleteTuzhi")
    public ModelAndView deleteTuzhi(@Param("tuzhiId") Long tuzhiId) {
        ModelAndView mv = new ModelAndView();
        mv.setView(new MappingJackson2JsonView());
        //调用service
        try {
            tuzhiService.deleteTuzhiById(tuzhiId);
            mv.addObject("updateTuzhi_msg", "删除图纸成功");
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("updateTuzhi_msg", "删除图纸失败");
        }
        return mv;
    }

    //在线展示图纸
    @RequestMapping("/displayTuzhi")
    public String displayTuzhi(HttpServletRequest request) {
        //接收传入的id
        Long id = Long.parseLong(request.getParameter("id"));
        Tuzhi tuzhi = tuzhiService.getTuzhiById(id);
        String path = tuzhi.getPath();

        //原始文件
        File file = new File(pathRoot + path);
        //新的文件名
        path = UUID.randomUUID().toString() + ".pdf";
        //更新文件名
        if (file.renameTo(new File(pathRoot + path))) {//改名成功
            //写入数据库里
            tuzhi.setPath(path);
            tuzhiService.updateTuzhi(tuzhi);
        }


        //重定向调用预览pdf的插件
        return "redirect:/resources/plugins/pdfJs/web/viewer.html?file=/documents/"+path;
    }
    //下载
    @RequestMapping("/download")
    public void down(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long id = Long.parseLong(request.getParameter("id"));
        Tuzhi tuzhi = tuzhiService.getTuzhiById(id);

        String filePath = "C:/documents/";
        String fileName = tuzhi.getPath();
        String realPath = filePath + fileName;

        InputStream bis = new BufferedInputStream(new FileInputStream(new File(realPath)));
        fileName = tuzhi.getTuming()+".pdf";
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
    // 跳转到添加类别页面
    @RequestMapping("/toAddTuzhiLeibie")
    public String toAddTuzhiLeibie(HttpServletRequest request) {
        //查询到所有图纸的类别并存入session，便于渲染树状结构，选择图纸类别进行查询
        List<Tuzhileibie> tuzhileibieList = tuzhiService.findAllTuzhiLeibies();
        request.getSession().setAttribute("tuzhileibieList", tuzhileibieList);
        return "addTuzhiLeibie";
    }
    @RequestMapping("/addTuzhiLeibie")
    public String addTuzhiLeibie(HttpServletRequest request) {
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
        //获取参数
        String leibieName = request.getParameter("leibieName");
        if (StringUtils.isEmpty(leibieName)) {
            request.getSession().setAttribute("addTuzhiLeibie_msg", "请输入图纸类别名称");
            return "redirect:/tuzhi/toAddTuzhiLeibie.do";
        }
        int i = tuzhiService.saveTuzhiLeibie(leibieName);
        if (i == 1) {
            request.getSession().setAttribute("addTuzhiLeibie_msg", "保存成功");

        }
        return "redirect:/tuzhi/toAddTuzhiLeibie.do";
    }
}
