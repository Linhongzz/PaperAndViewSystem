package cn.edu.hebeu.service.impl;

import cn.edu.hebeu.mapper.UserMapper;
import cn.edu.hebeu.pojo.User;
import cn.edu.hebeu.service.UserService;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;
    @Override
    public User getUserByUserName(String userName) {
        return userMapper.getUserByUserName(userName);
    }

    @Override
    public boolean checkUser(String userName, String password, HttpServletRequest request) {
        User userInDb=userMapper.getUserByUserName(userName);
        if (userInDb == null) {//数据库中没有查找到用户名一致的用户
            request.setAttribute("login_msg","用户名或密码错误");
            return false;
        }
        if (password.equals(userInDb.getPassword())) {
            //密码正确，回传user
            request.getSession().setAttribute("user", userInDb);
            request.setAttribute("login_msg","");
            return true;
        } else {
            //密码错误，返回空
            request.setAttribute("login_msg","用户名或密码错误");
            return false;
        }

    }

    @Override
    public void logout(HttpServletRequest request) {
        //销毁session
        request.getSession().invalidate();
    }

   /* @Override
    public Long getUserNumber(Role role) {

        return userMapper.getUserNumber(role);
    }*/

    @Override
    public List<User> getUsersByPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        //获取登陆的User对象
        User user = (User) session.getAttribute("user");
        int pageNub=1;//默认这个参数为1
        try {
            //获取带来的页码参数
            pageNub= Integer.parseInt(request.getParameter("pageNub"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        //把当前页页码存入session
        session.setAttribute("currentPage",pageNub);
        //获取他能改变的用户数量
        Long userNum = (Long) session.getAttribute("userNum");
        if (userNum==null||userNum==0) {//session中没有这个值

            //从数据库中查询
            userNum= userMapper.getUserNumber(user.getRole());
            //存入session
            session.setAttribute("userNum", userNum);
            //存入页数
            session.setAttribute("userPageNum",(userNum/20)+1);
        }
        RowBounds rowBounds = new RowBounds((pageNub - 1) * 20, 20);

        return userMapper.getUsersByPage(rowBounds,user.getRole());
    }

    @Override
    public int addUser(User user) {

        return userMapper.addUser(user);
    }

    @Override
    public int updateUser(User userForUpdate) {
        return userMapper.updateUser(userForUpdate);
    }

    @Override
    public int deleteUser(HttpServletRequest request, Long userId) {
        //调用mapper操作数据库
        int flag = userMapper.deleteUserById(userId);
        //删除了用户，用户数量改变了，从session中删除记录用户数量的属性userNum
        request.getSession().removeAttribute("userNum");

        return flag;
    }

    @Override
    public boolean findUserByIdForUpdate(HttpServletRequest request, Long userId) {
        try {
            //调用mapper查询user
            User userForUpdate = userMapper.findUserById(userId);
            //存入session
            request.getSession().setAttribute("userForUpdate", userForUpdate);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
