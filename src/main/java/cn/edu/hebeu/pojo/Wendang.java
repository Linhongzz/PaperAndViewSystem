package cn.edu.hebeu.pojo;

/**
 * 文档类
 */
public class Wendang {
    private Long id;
    private Wendangleibie leibie;//文档类别
    private String wendangming;//文档名
    private String yuanshihouzhui;//原始后缀,改为存原始文件名
    private String path;//路径

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Wendangleibie getLeibie() {
        return leibie;
    }

    public void setLeibie(Wendangleibie leibie) {
        this.leibie = leibie;
    }

    public String getWendangming() {
        return wendangming;
    }

    public void setWendangming(String wendangming) {
        this.wendangming = wendangming;
    }

    public String getYuanshihouzhui() {
        return yuanshihouzhui;
    }

    public void setYuanshihouzhui(String yuanshihouzhui) {
        this.yuanshihouzhui = yuanshihouzhui;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }


}
