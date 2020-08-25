package cn.edu.hebeu.pojo;

/**
 * 文档类别
 */
public class Wendangleibie {
    Long leibieId;//当前id；
    Long parentId;//父目录id
    Long depth;//深度；
    String leibieName;

    public Wendangleibie() {
    }

    public Wendangleibie(Long leibieId) {
        this.leibieId = leibieId;
    }

    public Long getDepth() {
        return depth;
    }

    public void setDepth(Long depth) {
        this.depth = depth;
    }

    public Long getLeibieId() {
        return leibieId;
    }

    public void setLeibieId(Long leibieId) {
        this.leibieId = leibieId;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getLeibieName() {
        return leibieName;
    }

    public void setLeibieName(String leibieName) {
        this.leibieName = leibieName;
    }
}
