package cn.edu.hebeu.mapper;

import cn.edu.hebeu.pojo.Role;
import cn.edu.hebeu.pojo.User;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    //通过用户名查找用户
    User getUserByUserName(String userName);

    //查找符合条件的用户数目
    Long getUserNumber(Role role);

    //分页查询用户
    List<User> getUsersByPage(RowBounds rowBounds,Role role);

    //添加用户
    int addUser(User user);

    int updateUser(User updateUser);
    //删除用户
    int deleteUserById(Long userId);

    User findUserById(Long userId);



}
