package cn.edu.hebeu.service;

import cn.edu.hebeu.mapper.UserMapper;
import cn.edu.hebeu.pojo.Role;
import cn.edu.hebeu.pojo.User;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;


public interface UserService {
    User getUserByUserName(String userName);

    boolean checkUser(String userName, String password, HttpServletRequest request);

    void logout(HttpServletRequest request);

   /* Long getUserNumber(Role role);*/

    List<User> getUsersByPage(HttpServletRequest request);

    int addUser(User user);

    int updateUser(User userForUpdate);

    int deleteUser(HttpServletRequest request,Long userId);

    boolean findUserByIdForUpdate(HttpServletRequest request, Long userId);

}
