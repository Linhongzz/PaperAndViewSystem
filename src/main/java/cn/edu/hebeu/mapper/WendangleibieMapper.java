package cn.edu.hebeu.mapper;

import cn.edu.hebeu.pojo.Tuzhileibie;
import cn.edu.hebeu.pojo.Wendangleibie;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WendangleibieMapper {

    Wendangleibie getLeibie(Long leibieId);

    List<Wendangleibie> findAllWendangLeibies();

    int addWendangLeibie(Wendangleibie wendangleibie);
}
