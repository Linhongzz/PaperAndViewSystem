package cn.edu.hebeu.interceptor;

import cn.edu.hebeu.pojo.User;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    /**
     * 该方法将在Controller处理之前进行调用，return false则请求中止
     */
    public boolean preHandle(HttpServletRequest httpServletRequest,  HttpServletResponse httpServletResponse, Object o) throws Exception {
        // 获取请求的url
        String url = httpServletRequest.getRequestURI();
        if (url.equals(httpServletRequest.getContextPath()+"/user/checkUser.do")
                ||url.equals(httpServletRequest.getContextPath()+"/user/login.do")
                ||url.equals(httpServletRequest.getContextPath()+"/documents/*")) {
            //登陆接口，放行
            return true;
        } else {
            HttpSession session = httpServletRequest.getSession();
            User user = (User) session.getAttribute("user");
            if (user != null) {
                return true;
            }
        }
        // 不符合条件的跳转到登录界面
        // 客户端跳转
        httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/user/login.do");
        return false;
    }
}
