package cn.edu.hebeu.mapper;

import cn.edu.hebeu.pojo.Tuzhi;
import cn.edu.hebeu.pojo.Tuzhileibie;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface TuzhileibieMapper {
    Tuzhileibie getLeibie(Long leibieId);

    List<Tuzhileibie> findAllTuzhiLeibies();

    int addTuzhiLeibie(String leibieName);
}
