package cn.edu.hebeu.pojo;

/**
 * 用户类
 */
public class User {
    private Long userId;
    private Role role;
    private String realName;
    private String userName;
    private String password;

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", role=" + role.getRoleId()+role.getRoleName() +
                ", realName='" + realName + '\'' +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
