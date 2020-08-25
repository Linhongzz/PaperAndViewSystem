package cn.edu.hebeu.controller;

import cn.edu.hebeu.pojo.Role;
import cn.edu.hebeu.pojo.User;
import cn.edu.hebeu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;

    /**
     * 跳转到登录页面 /WEB-INF/jsp/login.jsp
     *
     * @return
     */
    @RequestMapping("/login")
    public ModelAndView login() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("login");
        return mv;
    }

    @RequestMapping("/checkUser")
    public String checkUser(String userName, String password, HttpServletRequest request) {
        boolean flag = userService.checkUser(userName, password, request);
        if (flag) {//登陆成功
            return "redirect:/wendang/listWendang.do";//重定向
        } else {
            return "login";//再次登陆
        }
    }

    @RequestMapping("/logout")
    public String logOut(HttpServletRequest request) {
        //调用userService删除session中的user属性
        userService.logout(request);
        //跳转回登录页面
        return "login";
    }

    @RequestMapping("/userList")
    public String userList(HttpServletRequest request) {
        //调用service 进行分页查询
        List<User> userList = userService.getUsersByPage(request);
        //存入session
        request.getSession().setAttribute("userList", userList);
        return "userList";
    }

    /**
     * 去到addUser.jsp界面
     *
     * @return
     */
    @RequestMapping("/toAddUser")
    public String toAddUser() {
        return "addUser";
    }

    /**
     * 添加用户
     *
     * @return
     */
    @RequestMapping("/addUser")
    public String addUser(HttpServletRequest request) {
        //获取参数
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String realName = request.getParameter("realName");
        String roleId_str = request.getParameter("roleId");
        Long roleId = Long.parseLong(roleId_str);
        //封装对象
        User user = new User();
        user.setUserName(userName);
        user.setPassword(password);
        user.setRealName(realName);
        user.setRole(new Role(roleId));

        //调用service存入
        try {
            userService.addUser(user);
            return "redirect:/user/userList.do";
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("addUser_msg", "用户名重复");
            return "addUser";
        }
    }

    @RequestMapping("/deleteUser")
    public String deleteUser(HttpServletRequest request, Long userId) {
        //调用service删除用户
        userService.deleteUser(request, userId);
        return "redirect:/user/userList.do";
    }

    @RequestMapping("/toUpdateUser")
    public String toUpdateUser(HttpServletRequest request, Long userId) {
        //调用service
        boolean flag = userService.findUserByIdForUpdate(request, userId);
        if (flag) {//查找成功
            return "updateUser";
        } else {
            return "redirect:/user/userList.do";
        }
    }

    @RequestMapping("/updateUser")
    public String updateUser(HttpServletRequest request) {
        //获取参数
        User userForUpdate = (User) request.getSession().getAttribute("userForUpdate");


        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String realName = request.getParameter("realName");
        String roleId_str = request.getParameter("roleId");
        Long roleId = Long.parseLong(roleId_str);
        //封装对象
        userForUpdate.setUserName(userName);
        userForUpdate.setPassword(password);
        userForUpdate.setRealName(realName);
        userForUpdate.setRole(new Role(roleId));

        //调用service存入
        try {
            userService.updateUser(userForUpdate);
            request.getSession().removeAttribute("userForUpdate");
            return "redirect:/user/userList.do";
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("addUser_msg", "用户名重复");
            return "updateUser";
        }
    }
}
