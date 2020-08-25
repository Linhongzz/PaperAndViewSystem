package cn.edu.hebeu.pojo;

public class Tuzhileibie {
    private Long leibieId;
    private String leibieName;

    public Tuzhileibie(Long leibieId) {
        this.leibieId = leibieId;
    }

    public Tuzhileibie() {
    }

    public Long getLeibieId() {
        return leibieId;
    }

    public void setLeibieId(Long leibieId) {
        this.leibieId = leibieId;
    }

    public String getLeibieName() {
        return leibieName;
    }

    public void setLeibieName(String leibieName) {
        this.leibieName = leibieName;
    }
}
