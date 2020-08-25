package cn.edu.hebeu.mapper;

import cn.edu.hebeu.pojo.Role;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleMapper {
    Role getRole(Long id);
}
