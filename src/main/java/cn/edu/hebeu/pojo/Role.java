package cn.edu.hebeu.pojo;

/**
 * 角色类
 */
public class Role {
    private Long roleId;
    private String roleName;

    public Role() {
    }

    public Role(Long roleId) {
        this.roleId = roleId;
        if (roleId == 2L) {
            this.roleName = "管理员";
        }
        if (roleId == 3L) {
            this.roleName = "用户";
        }
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
